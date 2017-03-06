//
//  XBPlanDetailTipsModel.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanDetailTipsModel.h"

@implementation XBPlanDetailTipModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID"  : @"id"};
}
@end


@implementation XBPlanDetailTipItem
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tips" : [XBPlanDetailTipModel class]};
}
@end


@implementation XBPlanDetailTipsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [XBPlanDetailTipItem class]};
}
@end
