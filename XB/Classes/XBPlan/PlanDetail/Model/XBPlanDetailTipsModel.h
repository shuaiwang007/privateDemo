//
//  XBPlanDetailTipsModel.h
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBPlanDetailTipModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *tip_cat;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *brief_content;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, assign) BOOL lock;
@property (nonatomic, strong) NSString *unlock_condition;
@property (nonatomic, assign) BOOL has_step;

@end

@interface XBPlanDetailTipItem : NSObject
@property (nonatomic, strong) NSString *subtitle_name;
@property (nonatomic, strong) NSArray *tips;

@end


@interface XBPlanDetailTipsModel : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *plan_name;
@property (nonatomic, strong) NSNumber *all_count;
@property (nonatomic, strong) NSArray *items;


@end
