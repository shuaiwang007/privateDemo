//
//  XBChoiceModel.m
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBChoiceModel.h"

@implementation XBChoiceBaseModel

@end


@implementation XBBestBanner
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items":[XBBestBannerModel class]};
}
@end

@implementation XBBestBannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

@end



@implementation XBBestIamin
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items":[XBBestIaminModel class]};
}
@end

@implementation XBBestIaminModel

@end



@implementation XBBestRecommondPlans
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items":[XBBestRecommondPlansModel class]};
}
@end

@implementation XBBestRecommondPlansModel

@end



@implementation XBBestPlanCats
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items":[XBBestPlanCatsModel class]};
}
@end

@implementation XBBestPlanCatsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"descriptions":@"description"};
}
@end



@implementation XBBestRecommondTips
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items":[XBBestRecommondTipsModel class]};
}
@end

@implementation XBBestRecommondTipsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
@end



@implementation XBBestPlaner
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items":[XBBestPlanerModel class]};
}
@end

@implementation XBBestPlanerModel

@end



@implementation XBWaterFallfserInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"descriptions":@"description"};
}
@end

@implementation XBBestPopularSteps
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items":[XBBestPopularStepsModel class]};
}
@end

@implementation XBBestPopularStepsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user_info":[XBWaterFallfserInfo class]};
}
@end


@implementation XBChoiceModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"best_banner":[XBBestBanner class],
             @"best_Iamin":[XBBestIamin class],
             @"best_recommond_plans":[XBBestRecommondPlans class],
             @"best_plan_cats":[XBBestPlanCats class],
             @"best_recommond_tips":[XBBestRecommondTips class],
             @"best_planer":[XBBestPlaner class],
             @"best_popular_steps":[XBBestPopularSteps class]};
}

@end
