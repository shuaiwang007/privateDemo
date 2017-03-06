//
//  CustomSliderView.m
//  whqFor
//
//  Created by 王帅 on 2017/2/27.
//  Copyright © 2017年 Mr.wang. All rights reserved.
//

#import "CustomSliderView.h"

@implementation CustomSliderView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.sliderView.continuous = YES;
    self.sliderView.thumbTintColor = [UIColor redColor];
    self.sliderView.minimumTrackTintColor = [UIColor redColor];
    self.sliderView.maximumTrackTintColor = [UIColor whiteColor];
    self.sliderView.minimumValue = -1;
    self.sliderView.maximumValue = 1;
    
}

//滑条滑动
- (IBAction)sliderAction:(UISlider *)sender {
    if (self.beautyImageType == BeautyImageTypeVariable) {//亮度
        ELog(@"亮度调节");
        if (self.lightChangeBlock) {
            self.lightChangeBlock(sender);
        }
        
    }else if (self.beautyImageType == BeautyImageTypevContrast) { //对比度
        ELog(@"对比度调节");
        if (self.contrastChangeBlock) {
            self.contrastChangeBlock(sender);
        }
    }else if (self.beautyImageType == BeautyImageTypeColourTmp) { //色温
        ELog(@"色温调节");
        if (self.colourTmpChangeBlock) {
            self.colourTmpChangeBlock(sender);
        }
    }else if (self.beautyImageType == BeautyImageTypeSaturability){ //饱和度
        ELog(@"饱和度调节");
        if (self.saturibleChangeBlock) {
            self.saturibleChangeBlock(sender);
        }
    }
}
//取消
- (IBAction)cancelBtnOnClick:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock(self.beautyImageType);
    }
}
//确定
- (IBAction)doneBtnOnClick:(id)sender {
    if (self.doneBlock) {
        self.doneBlock(self.beautyImageType);
    }
}

@end
