//
//  XBTipPageListViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/27.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBTipPageListViewController.h"
#import "WMPanGestureRecognizer.h"

static CGFloat const kWMHeaderViewHeight = 150;

@interface XBTipPageListViewController ()

@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGFloat viewTop;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) NSArray *tipModelArr;

@end

@implementation XBTipPageListViewController

// 1.1版本暂时不做
/**
 全部1小步页page,顶部cat,tag标签，下侧展示
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];
    
    [self initData];
    
}

- (void)initData
{
    [[ENetwork sharedNetwork] POST:XBApiTipAllCat parameters:nil success:^(id responseObject) {
//        self.catModelArr = [NSArray yy_modelArrayWithClass:[XBPlanCatModel class] json:[responseObject objectForKey:@"plan_category"]];
        
//        self.itemsWidths = [self itemWidthWithTabs:self.catModelArr];
        self.selectIndex = self.index;
        
        [self reloadData];
        
    } failure:nil];
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.menuHeight = 30;
        self.titleSizeNormal = 15.f;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleColorNormal = XBWriteColor;
        self.titleColorSelected = XBWriteColor;
        self.menuBGColor = XBDefaultMainColor;
    }
    return self;
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.tipModelArr.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    XBBaseTableViewController *VC = [[XBBaseTableViewController alloc] init];
//    XBPlanCatModel *model = self.catModelArr[index];
//    VC.tags = model.tags;
    return VC;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
//    XBPlanCatModel *model = self.catModelArr[index];
    return @"这是一个测试数据";//model.name;
}

- (void)panOnView:(WMPanGestureRecognizer *)recognizer {
    ELog(@"pannnnnning received..");
    
    CGPoint currentPoint = [recognizer locationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.lastPoint = currentPoint;
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat targetPoint = velocity.y < 0 ? XBNavigationBarHeight : XBNavigationBarHeight + kWMHeaderViewHeight;
        NSTimeInterval duration = fabs((targetPoint - self.viewTop) / velocity.y);
        
        if (fabs(velocity.y) * 1.0 > fabs(targetPoint - self.viewTop)) {
            NSLog(@"velocity: %lf", velocity.y);
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.viewTop = targetPoint;
            } completion:nil];
            
            return;
        }
        
    }
    CGFloat yChange = currentPoint.y - self.lastPoint.y;
    self.viewTop += yChange;
    self.lastPoint = currentPoint;
}

// MARK: ChangeViewFrame (Animatable)
- (void)setViewTop:(CGFloat)viewTop {
    
    _viewTop = viewTop;
    
    if (_viewTop <= XBNavigationBarHeight) {
        _viewTop = XBNavigationBarHeight;
    }
    
    if (_viewTop > kWMHeaderViewHeight + XBNavigationBarHeight) {
        _viewTop = kWMHeaderViewHeight + XBNavigationBarHeight;
    }
    
    self.viewFrame = CGRectMake(0, _viewTop, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - _viewTop);
}


#pragma mark - 计算tabs的宽度
- (NSArray *)itemWidthWithTabs:(NSArray *)tabs
{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < tabs.count; i++) {
//        XBPlanCatModel *model = tabs[i];
        
        CGSize size = [@"这是一个测试数据" boundingRectWithSize:CGSizeMake(100, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        [arr addObject:[NSNumber numberWithFloat:(size.width + 15)]];
    }
    return arr;
}

@end
