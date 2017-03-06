//
//  XBRecommonPlanerTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBRecommonPlanerTableViewCell.h"
#import "UIView+AnimationProperty.h"

@interface XBRecommonPlanerTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UILabel *lab3;

@property (weak, nonatomic) IBOutlet UIButton *changeBt;


@end

@implementation XBRecommonPlanerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.changeBt.layer.cornerRadius = 4;
    self.changeBt.layer.borderColor = XBDefaultMainColor.CGColor;
    self.changeBt.layer.borderWidth = 1;
    self.imgV1.layer.cornerRadius = 4;
    self.imgV2.layer.cornerRadius = 4;
    self.imgV3.layer.cornerRadius = 4;
    self.imgV3.layer.masksToBounds = YES;
    self.imgV2.layer.masksToBounds = YES;
    self.imgV1.layer.masksToBounds = YES;
}

- (IBAction)changeAction:(UIButton *)sender {
    
    [self changeAnimation];
    
}

- (void)changeAnimation
{
    [UIView animateWithDuration:0.7 animations:^{
        CGFloat alpha = 0.1;
        CGFloat scale = 0.8;
        
        self.imgV1.alpha = alpha;
        self.lab1.alpha = alpha;
        self.imgV2.alpha = alpha;
        self.lab2.alpha = alpha;
        self.imgV3.alpha = alpha;
        self.lab3.alpha = alpha;
        
        self.imgV1.scale = scale;
        self.lab1.scale = scale;
        self.imgV2.scale = scale;
        self.lab2.scale = scale;
        self.imgV3.scale = scale;
        self.lab3.scale = scale;
        
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            
            CGFloat normal = 1;
            
            self.imgV1.alpha = normal;
            self.lab1.alpha = normal;
            self.imgV2.alpha = normal;
            self.lab2.alpha = normal;
            self.imgV3.alpha = normal;
            self.lab3.alpha = normal;
            
            self.imgV1.scale = normal;
            self.lab1.scale = normal;
            self.imgV2.scale = normal;
            self.lab2.scale = normal;
            self.imgV3.scale = normal;
            self.lab3.scale = normal;
        }];
    }];
}

@end
