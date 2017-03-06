//
//  XBStepFromTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/28.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBStepFromTableViewCell.h"

@interface XBStepFromTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *fromStepLab;
@property (weak, nonatomic) IBOutlet UILabel *fromPlanLab;
@property (weak, nonatomic) IBOutlet UILabel *stepNameLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@end

@implementation XBStepFromTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModel:(XBPlanFromModel *)model
{
    self.fromPlanLab.text = model.from;
    self.stepNameLab.text = model.title;
    self.desLab.text = model.brief;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]];
}

@end
