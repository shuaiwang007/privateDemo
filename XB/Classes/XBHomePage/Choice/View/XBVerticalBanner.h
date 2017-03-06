//
//  XBVerticalBanner.h
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBVerticalBanner : UIView

@property (weak, nonatomic) IBOutlet UIButton *belongBt;
@property (weak, nonatomic) IBOutlet UIView *processView;
@property (weak, nonatomic) IBOutlet UIView *progress;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressWidth;
@property (nonatomic, assign) CGFloat progressValue;


+ (XBVerticalBanner *)verticalBanner;

@end
