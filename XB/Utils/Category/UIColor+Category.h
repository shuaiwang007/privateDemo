//
//  UIColor+Category.h
//  EFood
//
//  Created by 王化强 on 16/8/7.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

#define EColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
+ (UIColor *)colorFromHexRGB:(NSString *)colorString; // eg: @"f2f2f2"


@end
