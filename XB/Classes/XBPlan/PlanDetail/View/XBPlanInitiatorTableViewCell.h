//
//  XBPlanInitiatorTableViewCell.h
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPlanDetailModel.h"

@interface XBPlanInitiatorTableViewCell : UITableViewCell
@property (nonatomic, copy) void (^focusBlock)(NSNumber *userId);

- (void)setCellWithModel:(XBPlaner *)model;

@end
