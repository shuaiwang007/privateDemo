//
//  XBPlanDetailTipsTabHeaderView.m
//  XB
//
//  Created by 王化强 on 2017/3/3.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanDetailTipsTabHeaderView.h"

@interface XBPlanDetailTipsTabHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *tagLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation XBPlanDetailTipsTabHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imgV.layer.cornerRadius = 30;
//    self.imgV.layer.masksToBounds = YES;
}


+ (XBPlanDetailTipsTabHeaderView *)headerView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"XBPlanDetailTipsTabHeaderView" owner:nil options:nil];
    return (XBPlanDetailTipsTabHeaderView *)[nibView objectAtIndex:0];
}
- (IBAction)backAction:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}

@end
