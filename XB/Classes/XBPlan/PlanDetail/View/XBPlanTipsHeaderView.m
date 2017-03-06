//
//  XBPlanTipsHeaderView.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanTipsHeaderView.h"

@implementation XBPlanTipsHeaderView

+ (XBPlanTipsHeaderView *)headerView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"XBPlanTipsHeaderView" owner:nil options:nil];
    return (XBPlanTipsHeaderView *)[nibView objectAtIndex:0];
}

@end
