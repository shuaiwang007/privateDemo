//
//  XBFeedStepModel.h
//  XB
//
//  Created by 王化强 on 2017/2/22.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBRecorderInfoModel : NSObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *user_pic;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *relation;

@end

@interface XBBabyInfoModel : NSObject

@property (nonatomic, strong) NSString *baby_name;
@property (nonatomic, strong) NSString *birth_day;
@property (nonatomic, strong) NSString *baby_age;

@end

@interface XBVideoModel : NSObject

@property (nonatomic, strong) NSString *video;
@property (nonatomic, strong) NSString *video_cover;

@end

@interface XBPlanFromModel : NSObject

@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *from_type;
@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *tip_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *brief;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *step_count;
@property (nonatomic, strong) NSString *like_count;

@end

@interface XBFootPrintPic : NSObject
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *width;
@end

@interface XBFeedStepModel : NSObject

@property (nonatomic, strong) NSString *step_res_id;
@property (nonatomic, strong) XBRecorderInfoModel *recorder_info;
@property (nonatomic, strong) XBBabyInfoModel *baby_info;
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic, strong) XBVideoModel *video;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) XBPlanFromModel *from;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *comment_count;
@property (nonatomic, strong) NSString *like_count;

@end




