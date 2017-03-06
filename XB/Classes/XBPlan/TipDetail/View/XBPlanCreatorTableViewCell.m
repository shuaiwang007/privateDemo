//
//  XBPlanCreatorTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/27.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanCreatorTableViewCell.h"

@implementation XBPlanCreatorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModel:(XBTipDetailUserInfoModel *)model
{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.user_pic]];
    self.nameLab.text = model.user_name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
