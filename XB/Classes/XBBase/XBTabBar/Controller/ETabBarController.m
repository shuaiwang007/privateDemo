//
//  ETabBarController.m
//  ERootVC
//
//  Created by 王化强 on 16/7/11.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import "ETabBarController.h"
#import "XBNavigationController.h"
#import "XBAttentionViewController.h"
#import "NewFootprintViewController.h"

//#import "UIImage+RoundRectImage.h" // 测试

#include "ETabBar.h"

@interface ETabBarController () <ETabBarDelegate>

@property (nonatomic, strong) ETabBar *eTabBar;
@property (nonatomic, strong) NSMutableArray *items;/**< 保存对应子控制器的item模型的数组 */

@end

@implementation ETabBarController

- (void)viewWillLayoutSubviews{
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = XBTabBarHeight;
    tabFrame.origin.y = self.view.frame.size.height - XBTabBarHeight;
    self.tabBar.frame = tabFrame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _homePage = [[XBHomePageViewController alloc] init];
    _planPage = [[XBPlanPageViewController alloc] init];
    _testVC3 = [[XBTestViewController alloc] init];
    
    _tenMinutes = [[XBTenMinuteViewController alloc] init];
    _userVC  = [[XBUserCenterTableViewController alloc] init];
    
    [self addChildVC:_homePage title:@"首页" image:[UIImage imageNamed:@"tab_home"] selectedImage:[UIImage imageNamed:@"tab_home_click"]];
    
    [self addChildVC:_planPage title:@"计划" image:[UIImage imageNamed:@"tab_classfy"] selectedImage:[UIImage imageNamed:@"tab_classfy_click"]];

//    UIImage *clip = [UIImage imageNamed:@"an_1.jpg"];
//    CGFloat min = MIN(clip.size.width, clip.size.height);
//    UIImage *centerImg = [UIImage createRoundedRectImage:clip size:CGSizeMake(min, min) radius:min/2];
    
    [self addChildVC:_testVC3 title:nil image:[UIImage imageNamed:@"post_normal"] selectedImage:[UIImage imageNamed:@"post_normal"]];
    [self addChildVC:_tenMinutes title:@"10分钟" image:[UIImage imageNamed:@"tab_user"] selectedImage:[UIImage imageNamed:@"tab_user_click"]];
    [self addChildVC:_userVC title:@"我" image:[UIImage imageNamed:@"tab_user"] selectedImage:[UIImage imageNamed:@"tab_user_click"]];
    
    [self.tabBar addSubview:self.eTabBar];
    self.eTabBar.items = self.items;
    self.selectedIndex = XBTabbarDefaultSelectIndex;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self removeTabBarButton];
}

- (void)removeTabBarButton
{
    // 移除系统的TabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:[UIControl class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

/**
 *  添加一个子控制器
 *
 *  @param childVC       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    childVC.title = title;
    childVC.tabBarItem.image = image;
    childVC.tabBarItem.selectedImage = selectedImage;
    
    [self.items addObject:childVC.tabBarItem];
    XBNavigationController *nav = [[XBNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

- (void)tabBar:(ETabBar *)tabBar didSelectBarItem:(NSInteger)index
{
    
    ELog(@"didSelectBarItem   %zd   ", index);
    if (index == 2) { // self.selectedIndex == 2 && index == 2
        ELog(@"   发布按钮   ");
//        XBTestViewController *VC = [[XBTestViewController alloc] init];
//        [self presentViewController:VC animated:YES completion:nil];
        
        // 为了使titleArrSet方法生效，再次计算title宽度
//        self.homePage.titleArr = [[self.homePage.titleArr arrayByAddingObject:@"沙克"] mutableCopy];
//        
//        XBAttentionViewController *VC = [[XBAttentionViewController alloc] init];
//        VC.attentionType = AttentionTypeUser;
//        [self.homePage.VCArr addObject:VC];
//        [self.homePage reloadData];
        NewFootprintViewController *VC = [[NewFootprintViewController alloc] init];
        [[XBCommonTool currentViewController] presentViewController:VC animated:YES completion:nil];
        
    } else {
        self.selectedIndex = index;
    }
    
    if (index == 2) {
    
    } else if (index == 3) {
//        if (!EAppdelegate.userId) {
//            ELoginAndRegisterViewController *VC = [[ELoginAndRegisterViewController alloc] init];
//            [_cartVC presentViewController:VC animated:NO completion:nil];
//        }
    }
}


- (ETabBar *)eTabBar
{
    if (_eTabBar == nil) {
        _eTabBar = [[ETabBar alloc] initWithFrame:self.tabBar.bounds];
        _eTabBar.delegate = self;
    }
    return _eTabBar;
}

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
