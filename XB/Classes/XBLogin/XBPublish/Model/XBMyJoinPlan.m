//
//  XBMyJoinPlan.m
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBMyJoinPlan.h"

@implementation XBMyJoinPlaninfo

@end


@implementation XBMyJoinTips

@end


@implementation XBMyJoinPlan
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"plan_info":[XBMyJoinPlaninfo class],
             @"tips":[XBMyJoinTips class]};
}
@end
