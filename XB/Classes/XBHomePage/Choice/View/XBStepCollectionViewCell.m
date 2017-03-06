//
//  XBStepCollectionViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/15.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBStepCollectionViewCell.h"
#import "XBChoiceModel.h"

@interface XBStepCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *briefLab;
@property (weak, nonatomic) IBOutlet UILabel *tipCatLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation XBStepCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = XBDefaultBackGroundColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedEvent)];
    [self addGestureRecognizer:tap];
}


- (void)loadContent
{
    // 配置数据
    XBBestRecommondTipsModel *model = self.dataAdapter.data;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.briefLab.text = model.brief_content;
    self.titleLab.text = model.title;
    self.tipCatLab.text = model.tip_cat;
    
}

@end
