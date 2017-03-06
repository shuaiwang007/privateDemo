//
//  XBFootprintCollectionViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/15.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBFootprintCollectionViewCell.h"

@interface XBFootprintCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIButton *headerBt;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *planNameBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHConstraint;



@end

@implementation XBFootprintCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithPopularStepModel:(XBBestPopularStepsModel *)model
{
    if (!model.width) {
        return;
    }
    CGFloat cellW =1.0 * (Width - 40) / 2;
    self.imgHConstraint.constant = 1.0*model.height * cellW / model.width;
    
    
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    [self.headerBt setImage:[UIImage imageNamed:@"an_1"] forState:UIControlStateNormal];
    self.nameLab.text = @"毛豆妈妈";
    self.desLab.text = model.brief_content;
    [self.planNameBt setTitle:@"每天聊一会" forState:UIControlStateNormal];
    
    [self layoutSubviews];
}


@end
