//
//  XBLikeTipsTabViewController.h
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBBaseTableViewController.h"

@interface XBLikeTipsTabViewController : XBBaseTableViewController

@property (nonatomic, copy) void (^callBack)(NSString *tip_id, NSString *title);

@end
