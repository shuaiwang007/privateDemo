//
//  XBPlanDetailTabHeaderView.h
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBPlanDetailTabHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;


@property (nonatomic, copy) void (^joinBlock)(NSString *planId);
@property (nonatomic, copy) void (^backBlock)();
+ (XBPlanDetailTabHeaderView *)headerView;

@end
