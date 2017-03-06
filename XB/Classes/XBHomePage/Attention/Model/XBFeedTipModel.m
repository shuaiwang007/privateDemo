//
//  XBFeedTipModel.m
//  XB
//
//  Created by 王化强 on 2017/2/22.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBFeedTipModel.h"



@implementation XBTipInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID"  : @"id"};
}

@end


@implementation XBTipUserInfo


@end

@implementation XBFeedTipModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tip_info":[XBTipInfoModel class],
             @"user_info":[XBTipUserInfo class]};
}

@end
