//
//  XBPlanTopTableViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanTopTableViewController.h"
#import "XBPlanDetailPageViewController.h"
#import "XBPlanDetailModel.h"
#import "XBPlanDetailHeaderView.h"
#import "XBPlanInitiatorTableViewCell.h"
#import "XBPlanDetailMedalTableViewCell.h"
#import "XBPlanDetailListTableViewCell.h"
#import "XBPlanDetailTabHeaderView.h"
#import "XBTagView.h"
#import "XBFoldLabView.h"
#import "XBPlanAllTipsTabViewController.h"
#import "XBTipDetailTableViewController.h"

static NSString *commonCell = @"commonCell";
static NSString *initiatorCell = @"planInitiatorCell";
static NSString *planMedalCell = @"planMedalCell";
static NSString *planDetailListCell = @"planDetailListCell";

@interface XBPlanTopTableViewController ()
@property (nonatomic, strong) XBPlanDetailModel *planDetailModel;
@end

@implementation XBPlanTopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"XBPlanInitiatorTableViewCell" bundle:nil] forCellReuseIdentifier:initiatorCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBPlanDetailMedalTableViewCell" bundle:nil] forCellReuseIdentifier:planMedalCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBPlanDetailListTableViewCell" bundle:nil] forCellReuseIdentifier:planDetailListCell];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        
    }];
    
    [self initData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.containSizeBlock) {
        self.containSizeBlock(self.tableView.contentSize.height);
    }
}

- (void)initData
{
    if (!self.res_id) {
        return;
    }
    [[ENetwork sharedNetwork] POST:XBApiPlanDetail parameters:@{@"res_id":self.res_id} success:^(id responseObject) {
//        ELog(@"self.tableView.contentSize.height   %@   ", responseObject);
        
        self.planDetailModel = [XBPlanDetailModel yy_modelWithJSON:responseObject[@"content"]];
        
        [self.tableView reloadData];
        [self setHeaderView];
        
    } failure:^(NSError *error) {
        ELog(@"   %@   ", error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.planDetailModel.tips.tips.count <= 3 ? self.planDetailModel.tips.tips.count : 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {           // 本计划已有XX小步
        XBPlanDetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:planDetailListCell forIndexPath:indexPath];
        
        XBPlanDetailTip *model = self.planDetailModel.tips.tips[indexPath.row];
        cell.titleLab.text = model.title;
        return cell;
        
    } else if (indexPath.section == 1) {    // 计划发起人
        XBPlanInitiatorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:initiatorCell forIndexPath:indexPath];
        [cell setCellWithModel:self.planDetailModel.planer];
        return cell;
    } else {                                // XX人已经拿到了计划勋章
        XBPlanDetailMedalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:planMedalCell forIndexPath:indexPath];
        [cell setCellWithModel:self.planDetailModel.badge];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBTipDetailTableViewController *VC = [[XBTipDetailTableViewController alloc] init];
    XBPlanDetailTip *model = self.planDetailModel.tips.tips[indexPath.row];
    VC.res_id = model.res_id;
    [self.navigationController pushViewController:VC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XBPlanDetailHeaderView *header = [XBPlanDetailHeaderView headerView];
    
    if (section == 0) {
        header.titleLab.text = [NSString stringWithFormat:@"本计划已有%@小步", self.planDetailModel.tips.tips_count];
    } else if (section == 1) {
        header.titleLab.text = @"计划发起人";
    } else {
        header.titleLab.text = [NSString stringWithFormat:@"%@人已经拿到了本计划的勋章", self.planDetailModel.badge.got_count];
    }
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [[UIView alloc] init];
    if (section == 0) {
        foot.backgroundColor = XBWriteColor;
        UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(Width/2 - 75, 5, 150, 35)];
        bt.layer.borderWidth = 1;
        bt.layer.borderColor = XBDefaultFontColor.CGColor;
        bt.layer.cornerRadius = 17.5f;
        [bt addTarget:self action:@selector(checkAllPlan) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:@"查看全部" forState:UIControlStateNormal];
        [bt setTitleColor:XBDefaultFontColor forState:UIControlStateNormal];
        [foot addSubview:bt];
    }
    return foot;
}
- (void)checkAllPlan
{
    ELog(@"   %@   ", @"查看全部");
    XBPlanAllTipsTabViewController *VC = [[XBPlanAllTipsTabViewController alloc] init];
    VC.res_id = self.res_id;
    [self.navigationController pushViewController:VC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44.f;
    } else if (indexPath.section == 1){
        return 75 + [self configCellInitiatorCellWithModel:self.planDetailModel.planer];
    } else {
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 45.f;
    } else if (section == 2) {
        return 10.f;
    } else {
        return 0.01f;
    }
}

- (CGFloat)configCellInitiatorCellWithModel:(XBPlaner *)model
{
    CGSize size = [XBCommonTool boundSizeWith:model.descriptions attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.f]} constrainSize:CGSizeMake(Width - 30, 100)];
    return size.height + 30.f;
}

- (void)setHeaderView
{
    XBFoldLabView *labView = [[XBFoldLabView alloc] initWithStr:self.planDetailModel.plan_info.brief_descript];// // @"参与此计划的家人脚印总数达到要求，则家人均获得此勋章。参与此计划的家人脚印总数达到要求，则家人均获得此勋章。参与此计划的家人脚印总数达到要求，则家人均获得此勋章。参与此计划的家人脚印总数达到要求，则家人均获得此勋章。参与此计划的家人脚印总数达到要求，则家人均获得此勋章。"
    XBTagView *tagView = [[XBTagView alloc] initWithArr:self.planDetailModel.plan_info.plan_tags];
    
    labView.frame = CGRectMake(0, 210, Width, labView.height);
    tagView.frame = CGRectMake(0, 210 + labView.height, Width, tagView.height);
    
    UIView *headerTabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 210 + tagView.height + labView.height)];
    
    XBPlanDetailTabHeaderView *view = [XBPlanDetailTabHeaderView headerView];
    view.frame = headerTabView.frame;
    view.titleLab.text = self.planDetailModel.plan_info.title;
    [view.imgV sd_setImageWithURL:[NSURL URLWithString:self.planDetailModel.plan_info.pic]];
    view.countLab.text = [NSString stringWithFormat:@"已有%@人参加", self.planDetailModel.plan_info.joined_count];;
    view.joinBlock = ^(NSString *planId) {
        ELog(@"plan_res_id   %@   ", self.planDetailModel.plan_info.plan_res_id);
    };
    view.backBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [view addSubview:labView];
    [view addSubview:tagView];
    [headerTabView addSubview:view];
    
//    self.containSizeBlock(self.tableView.contentSize.height);
    
    self.tableView.tableHeaderView = headerTabView;
}



@end
