//
//  XBAppDelegateHandle.m
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBAppDelegateHandle.h"
#import "XBDataContext.h"

static XBAppDelegateHandle *_context = nil;

@implementation XBAppDelegateHandle

+ (instancetype)shareContext
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _context = [[XBAppDelegateHandle alloc] init];
    });
    return _context;
}

- (void)config
{
    [[XBDataContext shareContext] configData]; // 程序启动时配置一遍常用数据
}



@end
