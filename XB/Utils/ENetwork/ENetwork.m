//
//  ENetwork.m
//  EFood
//
//  Created by 王化强 on 16/8/10.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import "ENetwork.h"
#import "MD5Util.h"
#import "SFHFKeychainUtils.h"
#import "EErrorView.h"
#import "XBDataContext.h"


//Keychain
#define SERVICE_NAME @"com.xiaobu121.xiaobu"
//推广渠道
#define XB_CHANNEL_CODE @"ios"

//sk
#define E_SK @"android"


@interface ENetwork ()

@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) id parameters;
@property (nonatomic, copy) void (^success)(NSDictionary *responseObject);

@end

@implementation ENetwork

+ (instancetype)sharedNetwork {
    static ENetwork *_shareNetwork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareNetwork = [[ENetwork alloc] initWithBaseURL:[NSURL URLWithString:XBAPIBaseURLStr]];
        
        _shareNetwork.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _shareNetwork.requestSerializer = [AFHTTPRequestSerializer serializer];
        _shareNetwork.requestSerializer.timeoutInterval = 30;
        _shareNetwork.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    ELog(@"   %@   ", @"unkown");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    ELog(@"   %@   ", @"NotReachable");
                    [SVProgressHUD showInfoWithStatus:@"网络不可用"];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    [SVProgressHUD showInfoWithStatus:@"正在使用手机流量"];
                    ELog(@"   %@   ", @"WWAN");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    ELog(@"   %@   ", @"WiFi");
                    break;
                    
                default:
                    break;
            }
        }];
        
        //_sharedClient.securityPolicy.validatesDomainName = NO;
        //_sharedClient.securityPolicy.allowInvalidCertificates = YES;
    });
    
    return _shareNetwork;
}


- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure
{
    self.urlStr = URLString;
    self.parameters = parameters ? parameters : @{};
    self.success = success;
    
//    ELog(@"URLString   %@   ", URLString);
    [self POST:URLString parameters:[self signParameter:parameters] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        ELog(@" responseObject  %@   ", responseObject);
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 0) {
            success([responseObject objectForKey:@"content"]);
        } else if (code == 20100) {
            success(nil); // no data
        } else if (code == 41001) {
            
        } else {
            [self alertWithCode:code msg:[responseObject objectForKey:@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ELog(@"%@   %@   ", URLString, error);
        
        if (failure) {
            failure(error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showErrorView];
            });
        }
    }];
}


- (void)POSTWithUrlStr:(NSString *)URLString
            parameters:(id)parameters
              fileData:(NSData *)fileData
              progress:(nullable void (^)(NSProgress * _Nonnull))progress
               success:(void (^)(NSDictionary *responseObject))success
               failure:(void (^)(NSError *error))failure
{
    
    NSString *picName = [NSString stringWithFormat:@"image_%.f.jpg", [[NSDate date] timeIntervalSince1970]];
    [self POST:URLString parameters:[self signParameter:parameters] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:@"userfile" fileName:picName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
            success([responseObject objectForKey:@"content"]);
        } else {
            ELog(@"code!=0   %@   ", responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ELog(@"   %@   ", error);
    }];
}

#pragma mark - 全局添加错误页面，不想添加的话，failure传nil
- (void)showErrorView
{
    EErrorView *errorView = [EErrorView initErrorView];
    
    errorView.urlStr = self.urlStr;
    errorView.parameters = self.parameters;
    errorView.success = self.success;
    
    __weak typeof(errorView) weakErrorView = errorView;
    errorView.refreshBlock = ^void () {
        
        [weakErrorView removeFromSuperview];
    };
    
    UIViewController *VC = [XBCommonTool currentViewController];
    errorView.frame = CGRectMake(0, 64, XBScreenWidth, XBScreenHeight);
    [VC.view addSubview:errorView];
}


#pragma mark - 拼接参数
- (NSMutableDictionary *)signParameter:(NSDictionary *)params
{
    NSMutableDictionary *mutableParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    //TODO - 唯一标示
    NSString *udidStr = [SFHFKeychainUtils getPasswordForUsername:@"udid" andServiceName:SERVICE_NAME error:nil].length > 0 ? [SFHFKeychainUtils getPasswordForUsername:@"udid" andServiceName:SERVICE_NAME error:nil] : @"";
    
    NSString *idfaStr = [SFHFKeychainUtils getPasswordForUsername:@"idfa" andServiceName:SERVICE_NAME error:nil].length > 0 ? [SFHFKeychainUtils getPasswordForUsername:@"idfa" andServiceName:SERVICE_NAME error:nil] : @"";
    
    NSString *openStr = [SFHFKeychainUtils getPasswordForUsername:@"open_udid" andServiceName:SERVICE_NAME error:nil].length > 0 ? [SFHFKeychainUtils getPasswordForUsername:@"open_udid" andServiceName:SERVICE_NAME error:nil] : @"";
    
    NSString *macStr = [SFHFKeychainUtils getPasswordForUsername:@"mac" andServiceName:SERVICE_NAME error:nil].length > 0 ? [SFHFKeychainUtils getPasswordForUsername:@"mac" andServiceName:SERVICE_NAME error:nil] : @"";
    
    
    XBDataContext *dataContext = [XBDataContext shareContext];

    //用户登录成功后（从服务器上返回）
    NSString *auth_session = [XBSandBox getAuthSession]; // @"f060456a4f4db306d2bfd1e422f133087c8861dd";//
    NSString *timeString = [XBCommonTool getCurrentTimestamp];
    NSString *device_token =[[NSUserDefaults standardUserDefaults] stringForKey:@"device_token"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"device_token"] : @"";
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:@2 forKey:@"user_id"];
    [dict setObject:auth_session forKey:@"auth_session"];
    [dict setObject:XB_CHANNEL_CODE forKey:@"channel"];
    [dict setObject:dataContext.versionNum forKey:@"version"];
    [dict setObject:[dataContext build] forKey:@"ios_build"];
    [dict setObject:@"178.22.32.223" forKey:@"ip"]; // ip地址
    [dict setObject:@"test" forKey:@"phone_model"]; // 手机型号
    [dict setObject:@"iOS" forKey:@"os"];
    [dict setObject:[[UIDevice currentDevice] systemVersion] forKey:@"os_version"];
    [dict setObject:macStr forKey:@"mac"];             // mac地址
    [dict setObject:timeString forKey:@"timestamp"];
    
    [dict setObject:device_token forKey:@"device_token"];
    [dict setObject:idfaStr forKey:@"ios_idfa"];
    [dict setObject:openStr forKey:@"ios_openudid"];
    [dict setObject:udidStr forKey:@"ios_udid"];
    
    [dict setObject:[mutableParams yy_modelToJSONString] forKey:@"params"];
    
    //排序
    NSArray *keys = [dict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSString *paramerStr=@"";
    for (NSString *categoryId in sortedArray) {
        paramerStr = [NSString stringWithFormat:@"%@%@%@", paramerStr, categoryId, [dict objectForKey:categoryId]];
    }
    NSString *sign_md5 =paramerStr;
    sign_md5 = [NSString stringWithFormat:@"%@%@",sign_md5, E_SK];
    sign_md5 = [MD5Util md5:sign_md5];
    
    [dict setObject:sign_md5 forKey:@"sign"];
    
//    ELog(@"dict %@", dict);
    return dict;
}

- (void)alertWithCode:(NSInteger)code msg:(NSString *)msg
{
    NSString *message = @"出错啦，稍后再试";
    switch (code) {
        case 23000:
            message = @"内部错误";
            break;
        case 20000:
            message = @"数据库错误";
            break;
        case 20001:
            message = @"签名错误";
            break;
        case 20002:
            message = @"参数错误";
        case 20100:
            message = @"没有数据";
            break;
        case 40000:
            message = @"记录不存在";
            break;
        case 40001:
            message = @"记录已经存在";
            break;
        case 41000:
            message = @"账号已绑定";
            break;
//        case 41001:
//            message = @"账号未登录";
            break;
            
        default:
            break;
    }
    
    if (msg) {
        message = msg;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showInfoWithStatus:message];
    });
}

@end
