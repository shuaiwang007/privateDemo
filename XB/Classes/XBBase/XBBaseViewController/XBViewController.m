//
//  XBViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/11.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBViewController.h"

@interface XBViewController () <XBNavigationBarDelegate>

@end

@implementation XBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XBDefaultBackGroundColor;
    
    [self.view addSubview:self.eNaviBar];
}

- (void)setHeaderTitle:(NSString *)headerTitle
{
    self.eNaviBar.title = headerTitle;
}

- (XBNavigationBar *)eNaviBar
{
    if (_eNaviBar == nil) {
        _eNaviBar = [[XBNavigationBar alloc] initWithFrame:CGRectMake(0, 0, XBScreenWidth, 64)];
        _eNaviBar.delegate = self;
        _eNaviBar.backgroundColor = [UIColor colorFromHexRGB:@"FFFFFF"];
    }
    return _eNaviBar;
}

- (void)leftBarButtonClick:(UIButton *)button
{
    [self back];
}

- (void)rightBarButtonClick:(UIButton *)button
{
    
}

-(void)back
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
