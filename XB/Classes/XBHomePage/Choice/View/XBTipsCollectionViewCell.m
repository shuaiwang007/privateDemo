//
//  XBTipsCollectionViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/15.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBTipsCollectionViewCell.h"
#import "XBChoiceModel.h"

@interface XBTipsCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation XBTipsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedEvent)];
    [self addGestureRecognizer:tap];
}


- (void)loadContent
{
    // 配置数据
    XBBestPlanerModel *model = self.dataAdapter.data;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.nameLab.text = model.title;
    
}

@end
