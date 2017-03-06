//
//  XBOneStepTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/27.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBOneStepTableViewCell.h"

@interface XBOneStepTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation XBOneStepTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModel:(XBPlanTipModel *)model
{
    self.titleLab.text = model.title;
    self.desLab.text = model.brief;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
