//
//  XBHomePageViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/11.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBHomePageViewController.h"
#import "XBChoiceTableViewController.h"
#import "XBAttentionViewController.h"

@interface XBHomePageViewController ()

@property (nonatomic, strong) UILabel *attentionCountLab;

@end

@implementation XBHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.headerTitle = @"小步";
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XBScreenWidth, XBNavigationBarHeight)];
//    header.backgroundColor = XBDefaultMainColor;
//    [self.view addSubview:header];
    
    self.navigationController.navigationBar.hidden = YES;
    
    // 由沙克去精选通知，改变selectItem
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeIndex:) name:@"changeToChoice" object:nil];
    
    self.attentionCountLab.text = @"88";
}

- (void)changeIndex:(NSNotification *)notify
{
    [self.menuView selectItemAtIndex:[notify.object integerValue]];
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.viewFrame = CGRectMake(0, 20, Width, Height - XBTabBarHeight);
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleArr = [[NSMutableArray alloc] initWithArray:@[@"精选", @"关注"]];
        self.menuHeight = 44;
        self.selectIndex = 0;
        self.titleColorNormal = XBWriteColor;
        self.titleColorSelected = XBWriteColor;
        self.menuBGColor = XBDefaultMainColor;
        
        UIView *statusbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
        statusbar.backgroundColor = XBDefaultMainColor;
        [self.view addSubview:statusbar];
    }
    return self;
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.VCArr.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return self.VCArr[index];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titleArr[index];
}

- (UILabel *)attentionCountLab
{
    if (!_attentionCountLab) {
        UIView *subView = [self.menuView itemAtIndex:1];
        _attentionCountLab = [[UILabel alloc] initWithFrame:CGRectMake(subView.bounds.size.width - 7, 5, 14, 14)];
        _attentionCountLab.backgroundColor = XBDefaultMainColor;
        _attentionCountLab.layer.cornerRadius = 7.f;
        _attentionCountLab.layer.masksToBounds = YES;
        _attentionCountLab.textAlignment = NSTextAlignmentCenter;
        _attentionCountLab.font = [UIFont systemFontOfSize:10];
        
        [subView addSubview:_attentionCountLab];
    }
    return _attentionCountLab;
}

- (void)setTitleArr:(NSMutableArray *)titleArr
{
    _titleArr = titleArr;
    self.itemsWidths = [self itemWidthWithTabs:self.titleArr];
}

- (NSMutableArray *)VCArr
{
    if (!_VCArr) {
        XBChoiceTableViewController *VC1 = [[XBChoiceTableViewController alloc] init];
        XBAttentionViewController *VC2 = [[XBAttentionViewController alloc] init];
        _VCArr = [[NSMutableArray alloc] initWithArray:@[VC1, VC2]];
    }
    return _VCArr;
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

@end
