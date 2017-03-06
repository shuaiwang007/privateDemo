//
//  XBAttentionStepTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/22.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBAttentionStepTableViewCell.h"

@interface XBAttentionStepTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *actionLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIImageView *planImgV;
@property (weak, nonatomic) IBOutlet UILabel *tagLab;

@end

@implementation XBAttentionStepTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 5.f;
    self.tagLab.layer.cornerRadius = 3;
    self.tagLab.layer.borderWidth = 1.f;
    self.tagLab.layer.borderColor = XBDefaultMainColor.CGColor;
}

- (void)setCellWithModel:(XBFeedTipModel *)model
{
    [self.userHeaderImgV sd_setImageWithURL:[NSURL URLWithString:model.user_info.user_pic]];
    self.userNameLab.text = model.user_info.user_name;
    self.actionLab.text = @"贡献一小步";
    self.titleLab.text = model.tip_info.title;
    self.desLab.text = model.tip_info.brief_content;
    [self.planImgV sd_setImageWithURL:[NSURL URLWithString:model.tip_info.pic]];
    self.tagLab.text = model.tip_info.tip_cat;
}

@end
