//
//  EBadgeView.m
//  EFood
//
//  Created by 王化强 on 16/8/7.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import "EBadgeView.h"

@implementation EBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 设置背景图片
        self.backgroundColor = [UIColor cyanColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.layer.cornerRadius = 8.0f;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = NO;
    }
    return self;
}
- (void)setBadgeValue:(NSString *)badgeValue
{
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
//    ELog(@"badgeValue   %@   ", badgeValue);
    [self setTitle:badgeValue forState:UIControlStateNormal];
}

@end
