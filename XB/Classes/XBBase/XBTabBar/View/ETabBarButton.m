//
//  ETabBarButton.m
//  EFood
//
//  Created by 王化强 on 16/8/7.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import "ETabBarButton.h"
#import "EBadgeView.h"

@interface ETabBarButton ()

@property (nonatomic, strong) EBadgeView *badgeView;//通信上面的小红点

@end

@implementation ETabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTitleColor:XBLineColor forState:UIControlStateNormal];
        [self setTitleColor:XBDefaultMainColor forState:UIControlStateSelected];
        [self setTitleColor:XBDefaultMainColor forState:5];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
        
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // 主动调用
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    // 利用KVO时刻监听UITabBarItem对象的badgeValue的改变
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
}

// 注意:最好在观察者销毁的时候,移除观察者
- (void)dealloc
{
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [_item removeObserver:self forKeyPath:@"title"];
    [_item removeObserver:self forKeyPath:@"image"];
    [_item removeObserver:self forKeyPath:@"selectedImage"];
}

// 一旦监听的对象的值改变就会调用
// 在给控件赋值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 重新赋值
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    [self setImage:_item.selectedImage forState:UIControlStateHighlighted];
    [self setImage:_item.selectedImage forState:5]; //
    
    self.badgeView.badgeValue = _item.badgeValue;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageH = self.height * 0.7;
    CGFloat imageW = self.width;
    CGFloat imageXY = 0;
    self.imageView.frame  = CGRectMake(imageXY, imageXY, imageW, imageH);
    
    if (self.titleLabel.text.length == 0) {
        self.imageView.frame  = CGRectMake(0, 5, imageW, self.height - 10);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = 10;
        
        // 设置点击动画
        CAKeyframeAnimation * animation;
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.5;
        animation.removedOnCompletion = YES;
        animation.fillMode = kCAFillModeForwards;
        
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        
        animation.values = values;
        [self.imageView.layer addAnimation:animation forKey:nil];
    }
    
    CGFloat titleX = 0;
    CGFloat titleY = imageH -2;
    CGFloat titleH = self.height - imageH;
    CGFloat titleW = self.width;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    
    CGFloat badgeViewX = self.width/2 + 10;
    CGFloat badgeViewY = 2;
    self.badgeView.frame = CGRectMake(badgeViewX, badgeViewY, 16, 16);
}

// 懒加载
- (EBadgeView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [EBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:_badgeView];
    }
    return _badgeView;
}

@end
