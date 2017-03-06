//
//  XBPlanDetailModel.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanDetailModel.h"

@implementation XBPlaner
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"descriptions"  : @"description"};
}
@end

@implementation XBPlanDetailInfo

@end

@implementation XBTips
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tips" : [XBPlanDetailTip class]};
}
@end

@implementation XBPlanDetailTip

@end


@implementation XBPlanCondition

@end


@implementation XBPlanBadgeInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"descriptions"  : @"description"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"condition" : [XBPlanCondition class]};
}
@end


@implementation XBBadge

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"badge_info" : [XBPlanBadgeInfo class]};
}

@end


@implementation XBPlanDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"planer" : [XBPlaner class],
             @"plan_info":[XBPlanDetailInfo class],
             @"tips":[XBTips class],
             @"badge":[XBBadge class]};
}

@end
