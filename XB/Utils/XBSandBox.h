//
//  XBSandBox.h
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBSandBox : NSObject

#pragma mark - 用户信息
+ (void)setUserInfo:(NSDictionary *)userInfo;
+ (NSDictionary *)getUserInfo;
+ (void)removeUserInfo;

#pragma mark - authSession
+ (void)setAuthSession:(NSString *)authSession;
+ (NSString *)getAuthSession;

@end
