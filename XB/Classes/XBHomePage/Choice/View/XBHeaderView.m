//
//  XBHeaderView.m
//  XB
//
//  Created by 王化强 on 2017/2/15.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBHeaderView.h"

@implementation XBHeaderView


+ (XBHeaderView *)headerView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"XBHeaderView" owner:nil options:nil];
    return (XBHeaderView *)[nibView objectAtIndex:0];
}

- (IBAction)forwardAction:(UIButton *)sender {
    
    if (self.forwardBlock) {
        self.forwardBlock();
    }
}


- (void)setForwardStr:(NSString *)forwardStr
{
    _forwardStr = forwardStr;
    
    if (_forwardBt.imageView.image) {
        NSDictionary *attributes = @{NSFontAttributeName : self.forwardBt.titleLabel.font};
        CGSize size =  [forwardStr boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
        self.forwardBt.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        self.forwardBt.imageEdgeInsets = UIEdgeInsetsMake(0, size.width, 0, 0);
    }
    
    [self.forwardBt setTitle:forwardStr forState:UIControlStateNormal];
    
}

@end
