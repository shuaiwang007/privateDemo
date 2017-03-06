//
//  XBUserCenterTableViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/18.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBUserCenterTableViewController.h"
#import "XBUserPageViewController.h"
#import "XBNavigationBar.h"
#import "XBPlanPageListViewController.h"

@interface XBUserCenterTableViewController () <XBNavigationBarDelegate>

@property (nonatomic, strong) XBNavigationBar *navBar;
@property (nonatomic, strong) UILabel *messageCountLab;

@end

@implementation XBUserCenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navBar];
    self.tableView.frame = CGRectMake(0, XBNavigationBarHeight, Width, Height - XBNavigationBarHeight - XBTabBarHeight);
    
    self.navBar.title = @"我";
    [self.navBar.leftBtn setTitle:@"消息" forState:UIControlStateNormal];
    [self.navBar.rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    
    self.messageCountLab.text = @"99";
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section != 3) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = XBWriteColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XBUserPageViewController *VC = [[XBUserPageViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 135;
    } else if (indexPath.section == 3 && indexPath.row == 1) {
        return 76;
    } else {
        return 44;
    }
}
- (void)leftBarButtonClick:(UIButton *)button
{
    ELog(@"   %@   ", @"open news");
}

- (void)rightBarButtonClick:(UIButton *)button
{
    ELog(@"   %@   ", @"setting");
}

- (XBNavigationBar *)navBar
{
    if (_navBar == nil) {
        _navBar = [[XBNavigationBar alloc] initWithFrame:CGRectMake(0, 0, XBScreenWidth, XBNavigationBarHeight)];
        _navBar.delegate = self;
        _navBar.backgroundColor = [UIColor colorFromHexRGB:@"FFFFFF"];
    }
    return _navBar;
}

- (UILabel *)messageCountLab
{
    if (!_messageCountLab) {
        CGRect frame = self.navBar.leftBtn.frame;
        _messageCountLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 10, 5, 14, 14)];
        _messageCountLab.font = [UIFont systemFontOfSize:9.f];
        _messageCountLab.layer.cornerRadius = 7;
        _messageCountLab.textAlignment = NSTextAlignmentCenter;
        _messageCountLab.backgroundColor = XBDefaultMainColor;
        _messageCountLab.layer.masksToBounds = YES;
        [self.navBar.leftBtn addSubview:_messageCountLab];
    }
    return _messageCountLab;
}

@end
