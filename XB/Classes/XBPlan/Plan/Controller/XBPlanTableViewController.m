//
//  XBPlanTableViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/17.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanTableViewController.h"
#import "XBHeaderView.h"
#import "XBPlanPageListViewController.h"
#import "XBPlanListModel.h"
#import "XBRecommonPlanerTableViewCell.h"
#import "XBPlanTableViewCell.h"
#import "XBPlanDetailPageViewController.h"

static NSString *recommonPlanerCell = @"recommonPlanerCell";
static NSString *planListCell = @"planListCell";

@interface XBPlanTableViewController ()

@property (nonatomic, strong) XBPlan *planModel;

@end

@implementation XBPlanTableViewController

/**
 计划的主页
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 0, Width, Height - XBNavigationBarHeight - XBTabBarHeight);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XBRecommonPlanerTableViewCell" bundle:nil] forCellReuseIdentifier:recommonPlanerCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBPlanTableViewCell" bundle:nil] forCellReuseIdentifier:planListCell];
    
    [self initData];
}

- (void)initData
{
    [[ENetwork sharedNetwork] POST:XBApiIndexPlan parameters:nil success:^(id responseObject) {
        
//        ELog(@"XBApiIndexPlan   %@   ", responseObject); 
        self.planModel = [XBPlan yy_modelWithJSON:responseObject[@"items"]];
        [self.tableView reloadData];
    } failure:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1 + self.planModel.plan_cat_show.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    } else {
        XBPlanList *listModel = self.planModel.plan_cat_show[section - 1];
        return listModel.items.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XBRecommonPlanerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recommonPlanerCell forIndexPath:indexPath];
        return cell;
    } else {
        XBPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:planListCell forIndexPath:indexPath];
        
        BOOL progressHidden = YES;
        if (indexPath.section == 1) {
            progressHidden = NO;
        }
        XBPlanList *listModel = self.planModel.plan_cat_show[indexPath.section - 1];
        XBPlanListModel *model = listModel.items[indexPath.row];
        [cell setCellWithModel:model progressViewHidden:progressHidden];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 计划主页面
    } else if (indexPath.section > 0) {
        XBPlanDetailPageViewController *VC = [[XBPlanDetailPageViewController alloc] init];
        XBPlanList *listModel = self.planModel.plan_cat_show[indexPath.section - 1];
        XBPlanListModel *model = listModel.items[indexPath.row];
        VC.res_id = model.plan_res_id;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XBHeaderView *header = [XBHeaderView headerView];
    if (section == 0) {
        header.forwardBt.hidden = YES;
        XBRecommondPlaner *model = self.planModel.recommond_planer;
        header.titleLab.text = model.title;
    } else {
        XBPlanList *list = self.planModel.plan_cat_show[section - 1];
        header.forwardStr = [NSString stringWithFormat:@"全部%@个计划", list.all_count];
        header.titleLab.text = list.title;
        
        header.forwardBlock = ^void () {
            ELog(@"   %zd   ", section);
            XBPlanPageListViewController *VC = [[XBPlanPageListViewController alloc] init];
            
            [self.navigationController pushViewController:VC animated:YES];
        };
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (Width - 40) / 3 + 90;
    } else {
        return 85.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}

@end
