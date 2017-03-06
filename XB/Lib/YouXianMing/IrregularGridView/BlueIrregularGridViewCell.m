//
//  BlueIrregularGridViewCell.m
//  Animations
//
//  Created by YouXianMing on 2016/11/11.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BlueIrregularGridViewCell.h"
#import "UIView+Extension.h"
#import "UIColor+Category.h"
#import "UIImage+SolidColor.h"
#import "UILabel+SizeToFit.h"

@interface BlueIrregularGridViewCell ()

@property (nonatomic, strong) UILabel      *titleLabel;

@end

@implementation BlueIrregularGridViewCell

- (void)setupCell {
    
    UIColor *imageColor       = [UIColor colorFromHexRGB:@"5688F4"];
    UIImage *normalImage      = [UIImage imageWithSize:CGSizeMake(5, 5) color:imageColor];
    UIImage *highlightedImage = [UIImage imageWithSize:CGSizeMake(5, 5) color:XBDefaultMainColor]; // [imageColor colorWithAlphaComponent:0.5f]
    
    self.button                     = [[UIButton alloc] initWithFrame:self.bounds];
    self.button.layer.cornerRadius  = 4.f;
    self.button.layer.masksToBounds = YES;
    self.button.layer.borderWidth   = 0.5f;
    self.button.layer.borderColor   = [[UIColor grayColor] colorWithAlphaComponent:0.25f].CGColor;
    [self.button setBackgroundImage:normalImage      forState:UIControlStateNormal];
    [self.button setBackgroundImage:highlightedImage forState:UIControlStateSelected];
    [self addSubview:self.button];
    
    [self.button addTarget:self action:@selector(selectedEvent) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel           = [[UILabel alloc] init];
    self.titleLabel.font      = [UIFont systemFontOfSize:12.f];
    self.titleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85f];
    [self addSubview:self.titleLabel];
}

- (void)loadContent {
    
    if ([self.dataAdapter.data isEqualToString:@"全部"]) {
        self.button.selected = YES;
    }
    
    self.button.width = self.dataAdapter.itemWidth;    
    [self.titleLabel sizeToFitWithText:self.data config:^(UILabel *label) {
        
        label.centerY = self.height / 2.f;
        label.left    = 10.f;
    }];
}

@end
