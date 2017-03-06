//
//  XBPlanDetailTipsTabHeaderView.h
//  XB
//
//  Created by 王化强 on 2017/3/3.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBPlanDetailTipsTabHeaderView : UIView

@property (nonatomic, copy) void (^backBlock)();
+ (XBPlanDetailTipsTabHeaderView *)headerView;

@end
