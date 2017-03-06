//
//  XBPlanListModel.m
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanListModel.h"

@implementation XBPlan

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"plan_cat_show":[XBPlanList class]};
}

@end

@implementation XBPlanList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items":[XBPlanListModel class]};
}

@end

@implementation XBPlanListModel


@end
