//
//  ETabBar.m
//  EFood
//
//  Created by 王化强 on 16/8/7.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import "ETabBar.h"
#include "ETabBarButton.h"

@interface ETabBar ()

@property (nonatomic, strong) NSMutableArray *tabBarButtons;

@end

@implementation ETabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpTopLine];
    }
    return self;
}

#pragma mark - 设置顶部的单线
- (void)setUpTopLine
{
    UIView *topLineView = [[UIView alloc]init];
    topLineView.frame = CGRectMake(0, 0, self.width, 0.5);
    topLineView.backgroundColor = [UIColor grayColor];
    [self addSubview:topLineView];
}

#pragma mark - 设置子控件并赋值
- (void)setItems:(NSArray *)items
{
    _items = items;
    for (UIView *childView in self.subviews) {
        [childView removeFromSuperview];
    }
    
    // 添加所有按钮
    for (int i = 0; i < _items.count; i++) {
        // 取出按钮对应的模型
        UITabBarItem *item = _items[i];
        ETabBarButton *btn = [[ETabBarButton alloc] init];
        
        btn.tag = self.tabBarButtons.count;
        
        btn.item = item;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
        
        [self.tabBarButtons addObject:btn];
        
        NSInteger index = XBTabbarDefaultSelectIndex;
        if (btn.tag == index) {
            [self btnClick:btn];
            btn.backgroundColor =[UIColor whiteColor];
        }
    }
    
}

#pragma mark -btn点击
- (void)btnClick:(ETabBarButton *)button
{
    for (ETabBarButton *bt in self.tabBarButtons) {
        if (bt.tag == button.tag) {
            bt.selected = YES;
        } else {
            bt.selected = NO;
        }
    }
    // 点击tabBar上通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectBarItem:)]) {
        [_delegate tabBar:self didSelectBarItem:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat x = 0;
    CGFloat y = 0;
    NSUInteger count = self.items.count;
    CGFloat tabBarW = self.bounds.size.width;
    CGFloat tabBarH = self.bounds.size.height;
    CGFloat w = tabBarW / count;
    CGFloat h = tabBarH;
    NSInteger i = 0;
    for (ETabBarButton *tabBarButton in self.tabBarButtons) {
        x = i * w;
        tabBarButton.frame = CGRectMake(x, y, w, h);
        i++;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

@end
