//
//  XBMyLikeTipTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBMyLikeTipTableViewCell.h"


@interface XBMyLikeTipTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation XBMyLikeTipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModel:(XBMyLikeTipModel *)model
{
    self.titleLab.text = model.title;
    self.desLab.text = model.brief;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]];
}

@end
