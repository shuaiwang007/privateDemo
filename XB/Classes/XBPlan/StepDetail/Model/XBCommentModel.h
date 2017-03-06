//
//  XBCommentModel.h
//  XB
//
//  Created by 王化强 on 2017/2/28.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBCommentUserInfo : NSObject

@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSString *user_pic;
@property (nonatomic, strong) NSString *user_name;

@end

@interface XBParentComment : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) XBCommentUserInfo *user_info;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *date_time;

@end

@interface XBCommentModel : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) XBCommentUserInfo *user_info;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *date_time;
@property (nonatomic, strong) XBParentComment *parent_comment;

@end
