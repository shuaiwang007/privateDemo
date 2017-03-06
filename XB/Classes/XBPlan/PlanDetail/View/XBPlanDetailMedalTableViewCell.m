//
//  XBPlanDetailMedalTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanDetailMedalTableViewCell.h"

@interface XBPlanDetailMedalTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

@implementation XBPlanDetailMedalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModel:(XBBadge *)model
{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.badge_info.pic]];
    self.titleLab.text = model.badge_info.title;
    self.desLab.text = model.badge_info.descriptions;
    self.countLab.text = [NSString stringWithFormat:@"踩%@20个脚印即可获得", model.badge_info.condition.value];
}

@end
