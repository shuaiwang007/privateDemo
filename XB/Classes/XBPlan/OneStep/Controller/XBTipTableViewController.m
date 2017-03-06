//
//  XBTipTableViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBTipTableViewController.h"
#import "XBPlanTipModel.h"
#import "XBHeaderView.h"
#import "XBOneStepTableViewCell.h"
#import "XBTipPageListViewController.h" // 1小步第一版可能砍掉
#import "XBTipDetailTableViewController.h"
#import "XBStepDetailTableViewController.h"

static NSString *oneStepCell = @"oneStepCell";

@interface XBTipTableViewController ()

@property (nonatomic, strong) NSArray *tipArr;

@end

@implementation XBTipTableViewController


/**
 一小步
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 0, Width, Height - XBNavigationBarHeight - XBTabBarHeight);
    [self.tableView registerNib:[UINib nibWithNibName:@"XBOneStepTableViewCell" bundle:nil] forCellReuseIdentifier:oneStepCell];
    
    [self initData];
}

- (void)initData
{
    [[ENetwork sharedNetwork] POST:XBApiIndexTip parameters:nil success:^(id responseObject) {
        
        ELog(@"XBApiIndexTip   %@   ", responseObject);
        self.tipArr = [NSArray yy_modelArrayWithClass:[XBPlanTip class] json:responseObject[@"list"]];
        ELog(@"   %@   ", self.tipArr);
        [self.tableView reloadData];
    } failure:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tipArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XBPlanTip *model = self.tipArr[section];
    return model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBOneStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneStepCell forIndexPath:indexPath];
    
    XBPlanTip *tip = self.tipArr[indexPath.section];
    XBPlanTipModel *model = tip.items[indexPath.row];
    [cell setCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBTipDetailTableViewController *VC = [[XBTipDetailTableViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XBHeaderView *header = [XBHeaderView headerView];
    XBPlanTip *tip = self.tipArr[section];
    header.titleLab.text = tip.title;
    header.forwardStr = [NSString stringWithFormat:@"全部%@个", tip.all_count];
    
    header.forwardBlock = ^{
//        XBTipPageListViewController *VC = [[XBTipPageListViewController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
    };
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}


@end
