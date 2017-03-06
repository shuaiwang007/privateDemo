//
//  XBPlanDetailModel.h
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBPlaner : NSObject
@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSString *user_pic;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *descriptions;
@property (nonatomic, strong) NSString *planer_tag;
@end



@interface XBPlanDetailInfo : NSObject
@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSNumber *tip_count;
@property (nonatomic, strong) NSNumber *joined_count;
@property (nonatomic, strong) NSString *brief_descript;
@property (nonatomic, strong) NSArray *plan_tags;
@end




@interface XBTips : NSObject
@property (nonatomic, strong) NSNumber *tips_count;
@property (nonatomic, strong) NSArray *tips;
@end

@interface XBPlanDetailTip : NSObject
@property (nonatomic, strong) NSString *res_id;
@property (nonatomic, strong) NSString *title;
@end




@interface XBPlanCondition : NSObject
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *plan_name;
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSString *cond_str;
@end

@interface XBPlanBadgeInfo : NSObject
@property (nonatomic, strong) NSNumber *badge_id;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptions;
@property (nonatomic, strong) XBPlanCondition *condition;

@end

@interface XBBadge : NSObject
@property (nonatomic, strong) NSNumber *got_count;
@property (nonatomic, strong) XBPlanBadgeInfo *badge_info;
@end




@interface XBPlanDetailModel : NSObject

@property (nonatomic, strong) XBPlaner *planer;
@property (nonatomic, strong) XBPlanDetailInfo *plan_info;
@property (nonatomic, strong) XBTips *tips;
@property (nonatomic, strong) XBBadge *badge;

@end
