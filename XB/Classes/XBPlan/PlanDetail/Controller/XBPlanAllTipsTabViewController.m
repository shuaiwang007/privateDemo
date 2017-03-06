//
//  XBPlanAllTipsTabViewController.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanAllTipsTabViewController.h"
#import "XBPlanDetailTipsModel.h"
#import "XBPlanTipsHeaderView.h"
#import "XBPlanDetailTipTableViewCell.h"
#import "XBPlanDetailTipsTabHeaderView.h"
#import "XBTagView.h"
#import "XBFoldLabView.h"

static NSString *planDetailTipCell = @"planDetailTipCell";
@interface XBPlanAllTipsTabViewController ()
@property (nonatomic, strong) XBPlanDetailTipsModel *tipsModel;
@end

@implementation XBPlanAllTipsTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 110.f;
    [self.tableView registerNib:[UINib nibWithNibName:@"XBPlanDetailTipTableViewCell" bundle:nil] forCellReuseIdentifier:planDetailTipCell];
    
    [self initData];
}

- (void)initData
{
    if (!self.res_id) {
        return;
    }
    [[ENetwork sharedNetwork] POST:XBApiTipPlanTips parameters:@{@"plan_res_id":self.res_id} success:^(id responseObject) {
        ELog(@"XBApiTipPlanTips   %@   ", responseObject);
        self.tipsModel = [XBPlanDetailTipsModel yy_modelWithJSON:responseObject];
        [self setHeaderView];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ELog(@"   %@   ", error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tipsModel.items.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XBPlanDetailTipItem *model = self.tipsModel.items[section];
    return model.tips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBPlanDetailTipItem *item = self.tipsModel.items[indexPath.section];
    XBPlanDetailTipModel *tip = item.tips[indexPath.row];
    XBPlanDetailTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:planDetailTipCell forIndexPath:indexPath];
    [cell setCellWithModel:tip];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XBPlanTipsHeaderView *view = [XBPlanTipsHeaderView headerView];
    XBPlanDetailTipItem *item = self.tipsModel.items[section];
    view.titleLab.text = item.subtitle_name;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 39.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.7f;
}

- (void)setHeaderView
{
    CGFloat w = Width;
#warning 还缺少真实数据，缺字段
    XBPlanDetailTipsTabHeaderView *header = [XBPlanDetailTipsTabHeaderView headerView];
    XBFoldLabView *foldView = [[XBFoldLabView alloc] initWithStr:@"，则家人均获得此勋章。参与此计划的家人脚印总数达到要求，则家人均获得此勋章。参与此计划的家人脚印总数达到要求，则家人均获得此勋章。参与此计划的家人脚印总数达到要求，则家人均获得此勋章。参与此计划的家人脚印总数达到要求，则家人均获得此勋章。"];
    foldView.frame = CGRectMake(0, 170, w, foldView.height);
    XBTagView *tag = [[XBTagView alloc] initWithArr:@[@"的家人脚印", @"的家人", @"的家人脚印的家人脚印", @"的家人脚印", @"的家人", @"的家人脚印的家人脚印", @"的家人脚印"]];
    tag.frame = CGRectMake(0, 170 + foldView.height, w, tag.height);
    header.frame = CGRectMake(0, 0, w, 170 + foldView.height + tag.height + 55);
    [header addSubview:foldView];
    [header addSubview:tag];
    
    header.backBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    self.tableView.tableHeaderView = header;
}

@end
