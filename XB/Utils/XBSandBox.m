//
//  XBSandBox.m
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBSandBox.h"

@implementation XBSandBox

#pragma mark - 用户信息
+ (void)setUserInfo:(NSDictionary *)userInfo
{
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"XBUserInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSDictionary *)getUserInfo
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"XBUserInfo"];
}

+ (void)removeUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"XBUserInfo"];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"XBAuthSession"];
}

#pragma mark - authSession
+ (void)setAuthSession:(NSString *)authSession
{
    [[NSUserDefaults standardUserDefaults] setObject:authSession forKey:@"XBAuthSession"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getAuthSession
{
    NSString *session = [[NSUserDefaults standardUserDefaults] objectForKey:@"XBAuthSession"];
    return session ? session : @"";
}

@end
