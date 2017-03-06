//
//  XBPlanTopTableViewController.h
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBBaseTableViewController.h"

@interface XBPlanTopTableViewController : XBBaseTableViewController

@property (nonatomic, strong) NSString *res_id;
@property (nonatomic, copy) void (^containSizeBlock)(CGFloat containSizeH);

@end
