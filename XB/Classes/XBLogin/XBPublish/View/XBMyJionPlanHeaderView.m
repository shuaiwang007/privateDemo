//
//  XBMyJionPlanHeaderView.m
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBMyJionPlanHeaderView.h"

@implementation XBMyJionPlanHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.rightBt setImage:[UIImage imageNamed:@"carat-open.png"] forState:UIControlStateSelected];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(action:)];
    [self addGestureRecognizer:tapGesture];
}

+ (XBMyJionPlanHeaderView *)headerView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"XBMyJionPlanHeaderView" owner:nil options:nil];
    return (XBMyJionPlanHeaderView *)[nibView objectAtIndex:0];
}

- (IBAction)action:(UIButton *)sender {
    
    [self toggleOpenWithUserAction:YES];
}

- (void)toggleOpenWithUserAction:(BOOL)userAction {
    
    self.rightBt.selected = !self.rightBt.selected;
    if (userAction) {
        if (self.rightBt.selected) {
            if (self.handleBlock) {
                self.handleBlock(YES);
            }
        } else {
            if (self.handleBlock) {
                self.handleBlock(NO);
            }
        }
    }
}

@end
