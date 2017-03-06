//
//  XBConst.h
//  XB
//
//  Created by 王化强 on 2017/2/10.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBConst : NSObject

#define XBAppdelegate  ((XBAppDelegate *)[UIApplication sharedApplication].delegate)

#define XBTabbarDefaultSelectIndex 0                                 // 默认tabbar选中下标

#define XBViewHeight [UIScreen mainScreen].bounds.size.height - 64 - 1   // 主界面高度 不带tabbar
#define XBScreenHeight [UIScreen mainScreen].bounds.size.height      // 屏幕宽度
#define XBScreenWidth [UIScreen mainScreen].bounds.size.width        // 屏幕宽度
#define XBScreenRatio 1.78                                           // 屏幕宽高比

#define XBDefaultBackGroundColor [UIColor colorFromHexRGB:@"F7F7F7"] // 背景色
#define XBDefaultFontColor [UIColor colorFromHexRGB:@"787474"]       // 字体颜色
#define XBSearchBarBackColor [UIColor colorFromHexRGB:@"EBEBEB"]     // 字体颜色
#define XBDefaultMainColor [UIColor colorWithRed:46/255. green:150/255. blue:150/255. alpha:1]       // 主绿色
#define XBWriteColor       [UIColor whiteColor]
#define XBLineColor        [UIColor colorFromHexRGB:@"D2D2D2"]       // 线的颜色

#define E_APP_VERSION  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]


/** 视频拍摄时长*/
extern CGFloat const smallVideoTime;
//美化照片的类型
typedef NS_ENUM(NSInteger,BeautyImageType) {
    BeautyImageTypeVariable = 0,    // 亮度
    BeautyImageTypevContrast,       //  对比度
    BeautyImageTypeColourTmp,       // 色温
    BeautyImageTypeSaturability     //饱和度
};

UIKIT_EXTERN const CGFloat XBTabBarHeight;
UIKIT_EXTERN const CGFloat XBNavigationBarHeight;
UIKIT_EXTERN const CGFloat XBDefaultTableViewCellHeight;             // tableviewCellHeight



//=================================API=======================================

@end
