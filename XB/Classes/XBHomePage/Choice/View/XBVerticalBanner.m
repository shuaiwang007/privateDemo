//
//  XBVerticalBanner.m
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBVerticalBanner.h"



@implementation XBVerticalBanner

+ (XBVerticalBanner *)verticalBanner
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"XBVerticalBanner" owner:nil options:nil];
    XBVerticalBanner *banner = (XBVerticalBanner *)[nibView objectAtIndex:0];
    banner.belongBt.layer.cornerRadius = 3;
    banner.belongBt.layer.borderWidth = 1;
    banner.belongBt.layer.borderColor = XBDefaultMainColor.CGColor;
    
    return banner;
}

- (void)setProgressValue:(CGFloat)progressValue
{
    _progressValue = progressValue;
    _progressWidth.constant = 0;
    [UIView animateWithDuration:0.7f animations:^{
        _progressWidth.constant = self.processView.frame.size.width * progressValue;
        [self layoutIfNeeded];
        [self layoutSubviews];
    } completion:nil];
}

@end
