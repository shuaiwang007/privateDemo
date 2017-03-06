//
//  XBPlanDetailTabHeaderView.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanDetailTabHeaderView.h"

@interface XBPlanDetailTabHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *joinBt;
@property (weak, nonatomic) IBOutlet UIButton *backBt;
@property (nonatomic, strong) NSNumber *planId;

@end

@implementation XBPlanDetailTabHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.joinBt.layer.cornerRadius = 17.5;
}

+ (XBPlanDetailTabHeaderView *)headerView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"XBPlanDetailTabHeaderView" owner:nil options:nil];
    return (XBPlanDetailTabHeaderView *)[nibView objectAtIndex:0];
}

- (IBAction)joinAction:(UIButton *)sender {
    
    if (self.joinBlock) {
        self.joinBlock(@"");
    }
}
- (IBAction)backAction:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}

@end
