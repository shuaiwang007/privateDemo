//
//  XBPlanPageViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/17.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanPageViewController.h"
#import "XBPlanTableViewController.h"
#import "XBTipTableViewController.h"

@interface XBPlanPageViewController ()

@end

@implementation XBPlanPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.viewFrame = CGRectMake(0, 20, Width, Height - XBTabBarHeight);
        self.menuHeight = 44;
        self.titleSizeNormal = 15.f;
        self.titleSizeSelected = 18.f;
        self.titleColorNormal = XBWriteColor;
        self.titleColorSelected = XBWriteColor;
        self.menuBGColor = XBDefaultMainColor;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.selectIndex = 0;
        
        UIView *statusbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
        statusbar.backgroundColor = XBDefaultMainColor;
        [self.view addSubview:statusbar];
    }
    return self;
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 2;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        XBPlanTableViewController *VC = [[XBPlanTableViewController alloc] init];
        return VC;
    } else {
        XBTipTableViewController *VC = [[XBTipTableViewController alloc] init];
        return VC;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return index == 0 ? @"计划" : @"1小步";
}

@end



//- (void)setRootVC
//{
//    Class VC = [XBPlanTableViewController class];
//    WMPageController *pageController = [[WMPageController alloc] initWithViewControllerClasses:@[VC, VC] andTheirTitles:@[@"计划", @"1小步"]];
//
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pageController];
//    nav.navigationBar.backgroundColor = XBDefaultMainColor;
//    [self addChildViewController:nav];
//    nav.navigationBar.hidden = YES;
//    [self.view addSubview:nav.view];
//
//    pageController.viewFrame = CGRectMake(0, XBNavigationBarHeight, Width, Height - XBNavigationBarHeight - XBTabBarHeight);
//    pageController.menuHeight = 44;
//    pageController.menuView.frame = CGRectMake(0, 0, Width, 44);
//    pageController.menuViewStyle = WMMenuViewStyleLine;
//    pageController.titleSizeNormal = 15.f;
//    pageController.titleSizeSelected = 18.f;
//    pageController.titleColorNormal = XBWriteColor;
//    pageController.titleColorSelected = XBWriteColor;
//    pageController.menuBGColor = XBDefaultMainColor;
//    pageController.showOnNavigationBar = YES;
//    pageController.menuBGColor = XBDefaultMainColor;
//    pageController.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
//}



