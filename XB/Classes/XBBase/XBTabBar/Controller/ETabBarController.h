//
//  ETabBarController.h
//  ERootVC
//
//  Created by 王化强 on 16/7/11.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTestViewController.h"
#import "XBHomePageViewController.h"
#import "XBPlanPageViewController.h"
#import "XBUserCenterTableViewController.h"
#import "XBTenMinuteViewController.h"

@interface ETabBarController : UITabBarController

@property (nonatomic, strong) XBHomePageViewController *homePage;
@property (nonatomic, strong) XBPlanPageViewController *planPage;
@property (nonatomic, strong) XBTestViewController *testVC3;
@property (nonatomic, strong) XBTenMinuteViewController *tenMinutes;
@property (nonatomic, strong) XBUserCenterTableViewController *userVC;

@end
