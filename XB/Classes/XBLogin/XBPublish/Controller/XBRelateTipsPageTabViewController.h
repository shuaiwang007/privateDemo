//
//  XBRelateTipsPageTabViewController.h
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <WMPageController/WMPageController.h>

@interface XBRelateTipsPageTabViewController : WMPageController

@property (nonatomic, copy) void (^callBack)(NSString *plan_res_id, NSString *tip_id, NSString *title);

@end
