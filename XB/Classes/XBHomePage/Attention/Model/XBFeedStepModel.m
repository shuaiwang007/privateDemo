//
//  XBFeedStepModel.m
//  XB
//
//  Created by 王化强 on 2017/2/22.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBFeedStepModel.h"

@implementation XBRecorderInfoModel

@end

@implementation XBBabyInfoModel

@end

@implementation XBVideoModel

@end

@implementation XBPlanFromModel

@end

@implementation XBFootPrintPic

@end


@implementation XBFeedStepModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"recorder_info":[XBRecorderInfoModel class],
             @"baby_info":[XBBabyInfoModel class],
             @"video":[XBVideoModel class],
             @"from":[XBPlanFromModel class],
             @"pics":[XBFootPrintPic class]};
}

@end
