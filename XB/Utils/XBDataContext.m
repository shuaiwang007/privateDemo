//
//  XBDataContext.m
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBDataContext.h"

static XBDataContext *_context = nil;

@implementation XBDataContext

+ (instancetype)shareContext
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _context = [[XBDataContext alloc] init];
    });
    return _context;
}

- (void)configData
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSArray *versionArr = [version componentsSeparatedByString:@"."];
    NSString *versionStr = [NSString stringWithFormat:@"%@%@%@", [self versionNum:versionArr[0]], [self versionNum:versionArr[1]], [self versionNum:versionArr[2]]];
    self.versionNum =  [NSNumber numberWithInteger:[versionStr integerValue]];
    
    self.build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    
}

- (NSString *)versionNum:(NSString *)ss
{
    if ([ss intValue] < 10) {
        return [NSString stringWithFormat:@"0%@", ss];
    } else {
        return ss;
    }
}

@end
