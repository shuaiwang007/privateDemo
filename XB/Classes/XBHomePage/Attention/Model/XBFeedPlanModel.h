//
//  XBFeedPlanModel.h
//  XB
//
//  Created by 王化强 on 2017/2/22.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBFeedPlanUserInfo : NSObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *user_pic;
@property (nonatomic, strong) NSString *user_name;

@end

@interface XBPlanInfo : NSObject

@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSNumber *tip_count;
@property (nonatomic, strong) NSString *brief_descript;

@end

@interface XBFeedPlanModel : NSObject

@property (nonatomic, strong) XBFeedPlanUserInfo *user_info;
@property (nonatomic, strong) XBPlanInfo *plan_info;

@end
