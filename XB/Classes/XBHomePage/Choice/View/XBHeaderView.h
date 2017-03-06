//
//  XBHeaderView.h
//  XB
//
//  Created by 王化强 on 2017/2/15.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *forwardBt;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;

@property (nonatomic, strong) NSString *forwardStr;
@property (nonatomic, copy) void (^forwardBlock)();


+ (XBHeaderView *)headerView;

@end
