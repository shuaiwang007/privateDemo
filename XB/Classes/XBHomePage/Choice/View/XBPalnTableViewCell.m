//
//  XBPalnTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/14.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPalnTableViewCell.h"

@interface XBPalnTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *tagLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

@implementation XBPalnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithRecommondPLanModel:(XBBestRecommondPlansModel *)model
{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.titleLab.text = model.title;
    
}

@end
