//
//  XBPlanListModel.h
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBRecommondPlanerModel.h"

@interface XBPlan : NSObject

@property (nonatomic, strong) XBRecommondPlaner *recommond_planer;
@property (nonatomic, strong) NSArray *plan_cat_show;

@end

@interface XBPlanList : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *plan_cat;
@property (nonatomic, strong) NSNumber *all_count;
@property (nonatomic, strong) NSArray *items;

@end

@interface XBPlanListModel : NSObject

@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *joined_count;
@property (nonatomic, strong) NSNumber *tip_count;
@property (nonatomic, strong) NSString *brief_descript;
@property (nonatomic, strong) NSNumber *my_step_count;

@end
