//
//  XBJoinTipsTabViewController.h
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBBaseTableViewController.h"

@interface XBJoinTipsTabViewController : XBBaseTableViewController

@property (nonatomic, copy) void (^callBack)(NSString *plan_res_id, NSString *tip_id, NSString *title);

@end
