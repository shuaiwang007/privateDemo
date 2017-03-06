//
//  ETabBar.h
//  EFood
//
//  Created by 王化强 on 16/8/7.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETabBar;

@protocol ETabBarDelegate <NSObject>

@optional
- (void)tabBar:(ETabBar *)tabBar didSelectBarItem:(NSInteger)index;

@end

@interface ETabBar : UIView

@property (nonatomic, weak) id<ETabBarDelegate> delegate;
@property (nonatomic, strong) NSArray *items;

@end
