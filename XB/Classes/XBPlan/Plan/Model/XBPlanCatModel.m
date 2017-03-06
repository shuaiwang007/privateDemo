//
//  XBPlanCatModel.m
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanCatModel.h"

@implementation XBPlanCatModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"ID":@"id", @"descriptions":@"description"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"tags" : [XBPlantagModel class]};
}

@end

@implementation XBPlantagModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"ID":@"id"};
}

@end
