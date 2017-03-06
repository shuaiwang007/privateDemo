//
//  XBMyJoinPlan.h
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XBMyJionPlanHeaderView;

@interface XBMyJoinPlaninfo : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *plan_res_id;
@end


@interface XBMyJoinTips : NSObject
@property (nonatomic, strong) NSString *res_id;
@property (nonatomic, strong) NSString *title;
@end


@interface XBMyJoinPlan : NSObject
@property (nonatomic, assign) BOOL open;
@property (nonatomic, strong) XBMyJionPlanHeaderView *headerView;
@property (nonatomic, strong) XBMyJoinPlaninfo *plan_info;
@property (nonatomic, strong) NSArray *tips;
@end
