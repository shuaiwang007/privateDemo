//
//  XBJoinTipsTabViewController.m
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBJoinTipsTabViewController.h"
#import "XBMyJoinPlan.h"
#import "XBMyJionPlanHeaderView.h"
#import "XBMyJoinTipTableViewCell.h"

static NSString *myJoinTipCell = @"myJoinTipCell";
@interface XBJoinTipsTabViewController ()
@property (nonatomic, strong) NSArray *modelArr;
@property (nonatomic) NSInteger openSectionIndex;
@end

@implementation XBJoinTipsTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XBMyJoinTipTableViewCell" bundle:nil] forCellReuseIdentifier:myJoinTipCell];
    
    self.openSectionIndex = NSNotFound;
    [self initData];
}

- (void)initData
{
    [[ENetwork sharedNetwork] POST:XBApiTipsMyJoin parameters:@{@"pn":@1} success:^(id responseObject) {
        ELog(@"   %@   ", responseObject);
        self.modelArr = [NSArray yy_modelArrayWithClass:[XBMyJoinPlan class] json:responseObject[@"items"]];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ELog(@"   %@   ", error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XBMyJoinPlan *model = (self.modelArr)[section];
    return model.open ? model.tips.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBMyJoinTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myJoinTipCell forIndexPath:indexPath];
    XBMyJoinPlan *plan = self.modelArr[indexPath.section];
    XBMyJoinTips *tip = plan.tips[indexPath.row];
    cell.titleLab.text = tip.title;
    cell.numLab.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBMyJoinPlan *plan = self.modelArr[indexPath.section];
    XBMyJoinTips *tip = plan.tips[indexPath.row];
    if (self.callBack) {
        self.callBack(plan.plan_info.plan_res_id, tip.res_id, tip.title);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XBMyJionPlanHeaderView *header = [XBMyJionPlanHeaderView headerView];
    header.section = section;
    XBMyJoinPlan *plan = (self.modelArr)[section];
    header.titleLab.text = plan.plan_info.title;
    plan.headerView = header;
    header.handleBlock = ^(BOOL open) {
        [self handleWithOpen:open section:section];
    };
    if (section == 1) {
        [header toggleOpenWithUserAction:YES];
    }
    return header;
}

- (void)handleWithOpen:(BOOL)open section:(NSInteger)section
{
    if (open) {
        [self openWithSection:section];
    } else {
        [self closeWithSection:section];
    }
}

- (void)openWithSection:(NSInteger)section
{
    XBMyJoinPlan *plan = (self.modelArr)[section];
    plan.open = YES;
    
    NSInteger countOfRowsToInsert = [plan.tips count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
        
        XBMyJoinPlan *previousOpenSection = (self.modelArr)[previousOpenSectionIndex];
        previousOpenSection.open = NO;
        [previousOpenSection.headerView toggleOpenWithUserAction:NO];
        NSInteger countOfRowsToDelete = [previousOpenSection.tips count];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || section < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    } else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    
    self.openSectionIndex = section;
    
}

- (void)closeWithSection:(NSInteger)section
{
    XBMyJoinPlan *plan = (self.modelArr)[section];
    
    plan.open = NO;
    NSInteger countOfRowsToDelete = [self.tableView numberOfRowsInSection:section];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}

@end
