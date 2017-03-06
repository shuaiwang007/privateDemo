//
//  XBTipDetailModel.h
//  XB
//
//  Created by 王化强 on 2017/2/27.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XBTipDetailInfoModel : NSObject

@property (nonatomic, strong) NSNumber *tip_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *age_range;

@end


@interface XBTipFromModel : NSObject

@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSNumber *tip_count;
@property (nonatomic, strong) NSString *brief_descript;
@property (nonatomic, strong) NSNumber *joined_count;
@end

//plan_res_id;
//pic;
//title;
//tip_count;
//brief_descript;
//my_step_count;
//joined_count;

@interface XBTipDetailUserInfoModel : NSObject

@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSString *user_pic;
@property (nonatomic, strong) NSString *user_name;

@end


@interface XBTipDetailModel : NSObject

@property (nonatomic, strong) XBTipDetailInfoModel *tip_info;
@property (nonatomic, strong) NSArray *from;
@property (nonatomic, strong) XBTipDetailUserInfoModel *user_info;

@end
