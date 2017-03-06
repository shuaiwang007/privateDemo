//
//  XBCommonTool.m
//  XB
//
//  Created by 王化强 on 2017/2/10.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBCommonTool.h"

@implementation XBCommonTool

+ (UIViewController *)currentViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstView = [keyWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];
    UIResponder *next = [secondView nextResponder];
    while (![next isKindOfClass:[UIViewController class]]) {
        next = next.nextResponder;
    }
    UIViewController *vc = (UIViewController *)next;
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            return [nav.viewControllers lastObject];
        } else {
            return tab.selectedViewController;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.viewControllers lastObject];
    } else {
        return vc;
    }
}

+ (CGSize)boundSizeWith:(NSString *)str attributes:(nullable NSDictionary<NSString *, id> *)attributes constrainSize:(CGSize)contentSize
{
    CGSize size = [str boundingRectWithSize:contentSize
                                    options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:attributes
                                    context:NULL].size;
    
    return size;
}

+ (NSString *)getCurrentTimestamp
{
    NSDate *date = [NSDate date];
    return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
}

+ (NSString *)timeFormatConversionWithDataStr:(NSString *)str
{
    
    NSString *returnStr;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSString *systemDate = [self transformationofseconds:[NSString stringWithFormat:@"%f", now] WithTag:1];
    NSString *strDate = [self transformationofseconds:str WithTag:1];
    
    if ([systemDate isEqualToString:strDate]) {
        // 当天
        returnStr = [NSString stringWithFormat:@"今天%@", [self transformationofseconds:str WithTag:0]];
    } else {
        returnStr = strDate;
    }
    return returnStr;
}


// 时间戳的转化（小时分钟）
+ (NSString *)transformationofseconds:(NSString *)time WithTag:(NSInteger)TAG
{
    NSString *result;
    long int sencods1 = [time intValue];
    long int totalSeconds = sencods1;
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:totalSeconds];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    
    if (TAG == 0) {
        NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
        NSRange containsA = [formatStringForHours rangeOfString:@"a"]; // 含 H 24  ah 12
        BOOL hasAMPM = (containsA.location != NSNotFound);
        if (hasAMPM) {
            [formatter setDateFormat:@"a h:mm"];
        } else {
            [formatter setDateFormat:@"HH:mm"];
        }
    } else if(TAG == 1){
        [formatter setDateFormat:@"YYYY-MM-dd"];
    } else if(TAG == 2){
        [formatter setDateFormat:@"HH"];
    } else if(TAG == 3){
        [formatter setDateFormat:@"mm"];
    } else if(TAG == 4){
        [formatter setDateFormat:@"ss"];
    } else if (TAG == 5) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    result = [formatter stringFromDate:date];
    
    return result;
    
}



@end
