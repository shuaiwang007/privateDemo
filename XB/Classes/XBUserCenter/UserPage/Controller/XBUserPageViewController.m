//
//  XBUserPageViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/18.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBUserPageViewController.h"
#import "WMPanGestureRecognizer.h"
#import "XBUserTableViewController.h"

static CGFloat const kWMHeaderViewHeight = 150;
@interface XBUserPageViewController ()

@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGFloat viewTop;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) NSArray *categoryArr;
@property (nonatomic, strong) NSArray *VCArr;

@end

@implementation XBUserPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewFrame = CGRectMake(0, kWMHeaderViewHeight, Width, Height - kWMHeaderViewHeight);
//    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
//    [self.view addGestureRecognizer:self.panGesture];
    
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.menuHeight = 36;
        self.titleSizeNormal = 15.f;
        self.titleSizeSelected = 18.f;
        self.titleColorSelected = XBDefaultMainColor;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        
        if (self.owner) {
            self.categoryArr = @[@"1小步", @"脚印"];
            self.VCArr = @[@"XBUserTableViewController", @"XBUserTableViewController"];
        } else {
            self.categoryArr = @[@"计划", @"1小步", @"脚印"];
            self.VCArr = @[@"XBUserTableViewController", @"XBUserTableViewController", @"XBUserTableViewController"];
        }
    }
    return self;
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.categoryArr.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    NSString *VCStr = self.VCArr[index];
    Class VC = NSClassFromString(VCStr);
    return [[VC alloc] init];
    
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.categoryArr[index];
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
    
    self.viewFrame = CGRectMake(0, _viewTop, Width, Height - _viewTop);
}


@end
