//
//  XBDataContext.h
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBDataContext : NSObject

// 存放一些全局配置的变量，在程序一启动时配置好，之后直接取用

@property (nonatomic, assign) NSNumber *versionNum;
@property (nonatomic, assign) NSNumber *build;
@property (nonatomic, strong) NSString *udidStr;
@property (nonatomic, strong) NSString *idfaStr;
@property (nonatomic, strong) NSString *openStr;
@property (nonatomic, strong) NSString *macStr;

+ (instancetype)shareContext;
- (void)configData;

@end
