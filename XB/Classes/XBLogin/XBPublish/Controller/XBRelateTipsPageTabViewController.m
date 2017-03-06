//
//  XBRelateTipsPageTabViewController.m
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBRelateTipsPageTabViewController.h"
#import "XBNavigationBar.h"
#import "XBLikeTipsTabViewController.h"
#import "XBJoinTipsTabViewController.h"

@interface XBRelateTipsPageTabViewController () <XBNavigationBarDelegate>
@property (nonatomic, strong) XBNavigationBar *eNaviBar;
@property (nonatomic, strong) NSString *plan_res_id;
@property (nonatomic, strong) NSString *tip_id;
@property (nonatomic, strong) NSString *title;
@end

@implementation XBRelateTipsPageTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
    
    
}

- (void)rightBarButtonClick:(UIButton *)button
{
    if (!self.tip_id) {
        [SVProgressHUD showInfoWithStatus:@"请先选则相关小步"];
        return;
    }
    if (self.callBack) {
        self.callBack(self.plan_res_id, self.tip_id, self.title);
        [self back];
    }
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.viewFrame = CGRectMake(0, 64, Width, Height - XBTabBarHeight);
        self.menuHeight = 44;
        self.titleSizeNormal = 13.f;
        self.titleSizeSelected = 15.f;
        self.titleColorNormal = XBWriteColor;
        self.titleColorSelected = XBWriteColor;
        self.menuBGColor = XBDefaultMainColor;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.selectIndex = 0;
        self.itemsWidths = [self itemWidthWithTabs:@[@"喜欢的", @"加入计划的"]];
        
        [self setTopView];
    }
    return self;
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 2;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        XBLikeTipsTabViewController *VC = [[XBLikeTipsTabViewController alloc] init];
        VC.callBack = ^(NSString *tip_id, NSString *title) {
            self.plan_res_id = nil;
            self.tip_id = tip_id;
            self.title = title;
        };
        return VC;
    } else {
        XBJoinTipsTabViewController *VC = [[XBJoinTipsTabViewController alloc] init];
        VC.callBack = ^(NSString *plan_res_id, NSString *tip_id, NSString *title) {
            self.plan_res_id = plan_res_id;
            self.tip_id = tip_id;
            self.title = title;
        };
        
        return VC;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return index == 0 ? @"喜欢的" : @"加入计划的";
}

- (NSArray *)itemWidthWithTabs:(NSArray *)tabs
{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < tabs.count; i++) {
        
        CGSize size = [tabs[i] boundingRectWithSize:CGSizeMake(200, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        [arr addObject:[NSNumber numberWithFloat:(size.width + 15)]];
    }
    return arr;
}

- (void)setTopView
{
    [self.eNaviBar.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.eNaviBar.leftBtn setTitleColor:XBWriteColor forState:UIControlStateNormal];
    [self.eNaviBar.rightBtn setTitleColor:XBWriteColor forState:UIControlStateNormal];
    [self.eNaviBar.leftBtn setImage:nil forState:UIControlStateNormal];
    [self.eNaviBar.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.eNaviBar.titleLab.text = @"选择脚印相关1小步";
    self.eNaviBar.titleLab.backgroundColor = XBDefaultMainColor;
    
    [self.view addSubview:self.eNaviBar];
}

- (XBNavigationBar *)eNaviBar
{
    if (_eNaviBar == nil) {
        _eNaviBar = [[XBNavigationBar alloc] initWithFrame:CGRectMake(0, 0, XBScreenWidth, 64)];
        _eNaviBar.delegate = self;
        _eNaviBar.backgroundColor = XBDefaultMainColor;
    }
    return _eNaviBar;
}

- (void)leftBarButtonClick:(UIButton *)button
{
    [self back];
}

- (void)back
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
