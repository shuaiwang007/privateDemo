//
//  XBChoiceModel.h
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBChoiceBaseModel : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *items;

@end


@interface XBBestBanner : XBChoiceBaseModel

@end

@interface XBBestBannerModel : NSObject

@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *scheme;

@end



@interface XBBestIamin : XBChoiceBaseModel

@end

@interface XBBestIaminModel : NSObject
@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *need_count;
@property (nonatomic, strong) NSNumber *my_step_count;

@end



@interface XBBestRecommondPlans : XBChoiceBaseModel

@end

@interface XBBestRecommondPlansModel : NSObject
@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *joined_count;
@property (nonatomic, strong) NSNumber *tip_count;
@property (nonatomic, strong) NSString *brief_descript;
@property (nonatomic, strong) NSString *recommond_tag;

@end




@interface XBBestPlanCats : XBChoiceBaseModel

@end

@interface XBBestPlanCatsModel : NSObject
@property (nonatomic, strong) NSString *plan_cat_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *descriptions;
@property (nonatomic, strong) NSString *image_url;
@end





@interface XBBestRecommondTips : XBChoiceBaseModel

@end

@interface XBBestRecommondTipsModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *tip_cat;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *brief_content;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *lock;
@property (nonatomic, strong) NSString *unlock_condition;
@end




@interface XBBestPlaner : XBChoiceBaseModel

@end

@interface XBBestPlanerModel : NSObject
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *scheme;
@end




@interface XBWaterFallfserInfo : NSObject
@property (nonatomic, strong) NSString *descriptions;
@property (nonatomic, strong) NSString *planer_tag;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *user_pic;
@property (nonatomic, strong) NSString *username;
@end

@interface XBBestPopularSteps : XBChoiceBaseModel

@end

@interface XBBestPopularStepsModel : NSObject
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *step_res_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *brief_content;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *video;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) XBWaterFallfserInfo *user_info;

@end


@interface XBChoiceModel : NSObject

@property (nonatomic, strong) XBBestBanner *best_banner;
@property (nonatomic, strong) XBBestIamin *best_Iamin;
@property (nonatomic, strong) XBBestRecommondPlans *best_recommond_plans;
@property (nonatomic, strong) XBBestPlanCats *best_plan_cats;
@property (nonatomic, strong) XBBestRecommondTips *best_recommond_tips;
@property (nonatomic, strong) XBBestPlaner *best_planer;
@property (nonatomic, strong) XBBestPopularSteps *best_popular_steps;

@end
