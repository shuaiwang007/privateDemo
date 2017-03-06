//
//  XBPlanDetailPageViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanDetailPageViewController.h"
#import "WMPanGestureRecognizer.h"
#import "XBPlanTopTableViewController.h"
#import "XBFootPrintTableViewController.h"
#import "XBCommentViewController.h"
#import "XBCommenFootView.h"

@interface XBPlanDetailPageViewController ()

@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGFloat topVCH;   // 顶部VC的高度的
@property (nonatomic, assign) CGFloat viewTop;  // 当前距离顶部的距离
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) XBFootPrintTableViewController *footPrintVC;
@property (nonatomic, strong) XBCommentViewController *commentVC;
@property (nonatomic, strong) XBCommenFootView *bottomView;

@end

@implementation XBPlanDetailPageViewController


/**
 计划详情
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topVCH = 0.f;
    
    // 顶部VC
    XBPlanTopTableViewController *VC = [[XBPlanTopTableViewController alloc] init];
    VC.res_id = self.res_id;
    [self.view addSubview:VC.view];
    __weak typeof(VC) weakVC = VC;
    VC.containSizeBlock = ^(CGFloat containSizeH) {
        self.topVCH = containSizeH;
        self.viewTop = containSizeH;
        ELog(@"containSizeH   %.f   ", containSizeH);
        [weakVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(Width, containSizeH));
//            make.top.equalTo(self.view.mas_top);
//            make.left.equalTo(self.view.mas_left);
//            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.menuView.mas_top);
        }];
    };
    VC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:VC];
    
    [self addBottomView];
    
    // VC联动
    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];
}


#pragma mark - 下侧pageViewController
- (instancetype)init {
    if (self = [super init]) {
        
        self.viewTop = self.topVCH;
        self.menuHeight = 40;
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
    return 2;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    return index == 0 ? self.footPrintVC : self.commentVC;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return index == 0 ? @"脚印" : @"评论";
}

- (void)panOnView:(WMPanGestureRecognizer *)recognizer {
    
    CGPoint currentPoint = [recognizer locationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.lastPoint = currentPoint;
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat targetPoint = velocity.y < 0 ? 0 : self.topVCH;
        NSTimeInterval duration = fabs((targetPoint - self.viewTop) / velocity.y);
        
        if (fabs(velocity.y) * 1.0 > fabs(targetPoint - self.viewTop)) {
            ELog(@"velocity: %lf", velocity.y);
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
    
    if (_viewTop <= 0) {
        _viewTop = 0;
    }
    if (_viewTop > self.topVCH) {
        _viewTop = self.topVCH;
    }
    self.viewFrame = CGRectMake(0, _viewTop, Width, Height - _viewTop);
}

- (XBFootPrintTableViewController *)footPrintVC
{
    if (!_footPrintVC) {
        _footPrintVC = [[XBFootPrintTableViewController alloc] init];
        _footPrintVC.plan_res_id = self.res_id;
    }
    return _footPrintVC;
}

- (XBCommentViewController *)commentVC
{
    if (!_commentVC) {
        _commentVC = [[XBCommentViewController alloc] init];
        _commentVC.scrollEnable = YES;
        _commentVC.plan_res_id = self.res_id;
    }
    return _commentVC;
}

- (void)addBottomView
{
    XBCommenFootView *bottomView = [XBCommenFootView commenFootView];
    self.bottomView = bottomView;
    bottomView.frame = CGRectMake(0, Height - 50, Width, 50);
    [bottomView.addFootPrintBt setTitle:@"加入计划 行动起来" forState:UIControlStateNormal];
    bottomView.firstBT.hidden = NO;
    
    bottomView.addFootBlock = ^{
        ELog(@"   加入计划   ");
    };
    
    bottomView.firstBlock = ^{
        ELog(@"   分享   ");
    };
    
    bottomView.shareBlock = ^{
        ELog(@"   点赞   ");
    };
    
    bottomView.commentBlock = ^{
        ELog(@"   评论   ");
        
    };
    bottomView.alpha = 0;
    [self.view addSubview:bottomView];
}

@end
