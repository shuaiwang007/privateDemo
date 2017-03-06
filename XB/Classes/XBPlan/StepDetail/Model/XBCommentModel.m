//
//  XBCommentModel.m
//  XB
//
//  Created by 王化强 on 2017/2/28.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBCommentModel.h"

@implementation XBCommentUserInfo

@end

@implementation XBParentComment

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID"  : @"id"};
}

@end

@implementation XBCommentModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID"  : @"id"};
}

@end
