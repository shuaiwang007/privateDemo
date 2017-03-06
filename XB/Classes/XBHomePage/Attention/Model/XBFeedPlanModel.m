//
//  XBFeedPlanModel.m
//  XB
//
//  Created by 王化强 on 2017/2/22.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBFeedPlanModel.h"

@implementation XBFeedPlanUserInfo

@end



@implementation XBPlanInfo

@end



@implementation XBFeedPlanModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user_info":[XBFeedPlanUserInfo class],
             @"plan_info":[XBPlanInfo class]};
}

@end
