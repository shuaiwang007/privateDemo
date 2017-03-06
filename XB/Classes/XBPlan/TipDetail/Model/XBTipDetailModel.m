//
//  XBTipDetailModel.m
//  XB
//
//  Created by 王化强 on 2017/2/27.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBTipDetailModel.h"

@implementation XBTipDetailInfoModel

@end

@implementation XBTipFromModel

@end

@implementation XBTipDetailUserInfoModel

@end


@implementation XBTipDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tip_info":[XBTipDetailInfoModel class],
             @"from":[XBTipFromModel class],
             @"user_info":[XBTipDetailUserInfoModel class]};
}

@end
