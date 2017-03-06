//
//  XBPlanDetailHeaderView.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanDetailHeaderView.h"

@implementation XBPlanDetailHeaderView

+ (XBPlanDetailHeaderView *)headerView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"XBPlanDetailHeaderView" owner:nil options:nil];
    return (XBPlanDetailHeaderView *)[nibView objectAtIndex:0];
}

@end
