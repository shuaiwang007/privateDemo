//
//  XBAttentionPalnTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/22.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBAttentionPalnTableViewCell.h"

@interface XBAttentionPalnTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *actionNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *planImgV;
@property (weak, nonatomic) IBOutlet UILabel *planNameLab;
@property (weak, nonatomic) IBOutlet UILabel *planCountLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;

@end

@implementation XBAttentionPalnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 5;
}

- (void)setCellWithModel:(XBFeedPlanModel *)model
{
    [self.userHeaderImgV sd_setImageWithURL:[NSURL URLWithString:model.user_info.user_pic]];
    self.userNameLab.text = model.user_info.user_name;
    self.actionNameLab.text = [NSString stringWithFormat:@"发起计划：%@", model.plan_info.title];
    [self.planImgV sd_setImageWithURL:[NSURL URLWithString:model.plan_info.pic]];
    self.planCountLab.text = [NSString stringWithFormat:@"%@", model.plan_info.tip_count];
    self.desLab.text = model.plan_info.brief_descript;
}

@end
