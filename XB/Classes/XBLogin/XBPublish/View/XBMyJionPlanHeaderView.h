//
//  XBMyJionPlanHeaderView.h
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBMyJionPlanHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property (nonatomic, assign) NSInteger section;

@property (nonatomic, copy) void (^handleBlock)(BOOL open);

+ (XBMyJionPlanHeaderView *)headerView;
- (void)toggleOpenWithUserAction:(BOOL)userAction;
@end
