//
//  ENetwork.h
//  EFood
//
//  Created by 王化强 on 16/8/10.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ENetwork : AFHTTPSessionManager

+ (instancetype)sharedNetwork;


- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

// 上传文件
- (void)POSTWithUrlStr:(NSString *)URLString
            parameters:(id)parameters
              fileData:(NSData *)fileData
              progress:(void (^)(NSProgress * progress))progress
               success:(void (^)(NSDictionary *responseObject))success
               failure:(void (^)(NSError *error))failure;

@end
