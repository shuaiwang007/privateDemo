//
//  XBPlanDetailTipTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanDetailTipTableViewCell.h"

@interface XBPlanDetailTipTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *sortLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconV;

@end


@implementation XBPlanDetailTipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModel:(XBPlanDetailTipModel *)model
{
    self.titleLab.text = model.title;
    self.desLab.text = model.brief_content;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.sortLab.text = @"1";
}

@end
