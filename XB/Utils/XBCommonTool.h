//
//  XBCommonTool.h
//  XB
//
//  Created by 王化强 on 2017/2/10.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBCommonTool : NSObject

+ (UIViewController *)currentViewController;

// 计算lab Size
+ (CGSize)boundSizeWith:(NSString *)str
             attributes:(NSDictionary *)attributes
          constrainSize:(CGSize)contentSize;

+ (NSString *)getCurrentTimestamp;
+ (NSString *)timeFormatConversionWithDataStr:(NSString *)str;
+ (NSString *)transformationofseconds:(NSString *)time WithTag:(NSInteger)TAG;

@end
