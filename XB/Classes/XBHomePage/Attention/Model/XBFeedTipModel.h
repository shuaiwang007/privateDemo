//
//  XBFeedTipModel.h
//  XB
//
//  Created by 王化强 on 2017/2/22.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTipInfoModel : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *tip_cat;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *brief_content;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *lock;
@property (nonatomic, strong) NSString *unlock_condition;

@end

@interface XBTipUserInfo : NSObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *user_pic;
@property (nonatomic, strong) NSString *user_name;

@end

@interface XBFeedTipModel : NSObject

@property (nonatomic, strong) XBTipInfoModel *tip_info;
@property (nonatomic, strong) XBTipUserInfo *user_info;

@end
