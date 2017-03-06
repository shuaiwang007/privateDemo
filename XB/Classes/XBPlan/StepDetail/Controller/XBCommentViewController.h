//
//  XBCommentViewController.h
//  XB
//
//  Created by 王化强 on 2017/2/28.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBBaseTableViewController.h"

@interface XBCommentViewController : XBBaseTableViewController

@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *step_res_id;
@property (nonatomic, strong) NSMutableArray *commentArr;
@property (nonatomic, copy) void (^commenViewHBLock)(CGFloat H);
@property (nonatomic, assign) BOOL scrollEnable;


@end
