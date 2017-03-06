//
//  XBPlanHeapCollectionViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/15.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanHeapCollectionViewCell.h"
#import "XBChoiceModel.h"
#import "UIView+AnimationProperty.h"

@interface XBPlanHeapCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *describeLab;
@property (weak, nonatomic) IBOutlet UIImageView *backImgV;

@end

@implementation XBPlanHeapCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedEvent)];
    self.backImgV.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)setupCell
{
    self.backgroundColor = XBDefaultBackGroundColor;
}

- (void)loadContent {
    
    XBBestPlanCatsModel *model = self.dataAdapter.data;
    
    self.titleLab.text = model.title;
    self.subTitleLab.text = model.text;
    self.describeLab.text = model.descriptions;
    [self.backImgV sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
}

- (void)willDisplay {
    
    self.titleLab.alpha = 0.f;
    self.titleLab.scale = 0.975f;
    self.subTitleLab.alpha = 0.f;
    self.subTitleLab.scale = 0.975f;
    self.describeLab.alpha = 0.f;
    self.describeLab.scale = 0.975f;
    self.backImgV.alpha = 0.f;
    self.backImgV.scale = 0.975f;
    
    [UIView animateWithDuration:0.75f animations:^{
        
        self.titleLab.alpha = 1.f;
        self.titleLab.scale = 1.f;
        self.subTitleLab.alpha = 1.f;
        self.subTitleLab.scale = 1.f;
        self.describeLab.alpha = 1.f;
        self.describeLab.scale = 1.f;
        self.backImgV.alpha = 1.f;
        self.backImgV.scale = 1.f;
    }];
}

- (void)didEndDisplay {
    
    [self.titleLab.layer removeAllAnimations];
    [self.subTitleLab.layer removeAllAnimations];
    [self.describeLab.layer removeAllAnimations];
    [self.backImgV.layer removeAllAnimations];
}

@end
