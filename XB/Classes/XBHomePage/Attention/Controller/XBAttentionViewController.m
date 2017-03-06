//
//  XBAttentionViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/17.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBAttentionViewController.h"
#import "XBFootPrintTableViewCell.h"
#import "XBPlanHeapCollectionViewCell.h"
#import "XBAttentionPalnTableViewCell.h"
#import "XBAttentionStepTableViewCell.h"
#import "XBHomePageUserView.h"
#import "XBAttentionModel.h"

static NSString *footCell = @"footPrintTabcell";
static NSString *planCell = @"attentionPlanCell";
static NSString *stepCell = @"attentionStpCell";

@interface XBAttentionViewController ()

@property (nonatomic, strong) UIButton *tipBt;
@property (nonatomic, assign) CGFloat tipBtHeight;
@property (nonatomic, assign) NSInteger sectionCount; // 新增加的信息数量，动态增加的时候更新cestion
@property (nonatomic, strong) NSMutableArray *attentionModelArr;
@property (nonatomic, strong) XBHomePageUserView *userView;

@end

@implementation XBAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.tipBt.mas_bottom);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XBFootPrintTableViewCell" bundle:nil] forCellReuseIdentifier:footCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBAttentionPalnTableViewCell" bundle:nil] forCellReuseIdentifier:planCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBAttentionStepTableViewCell" bundle:nil] forCellReuseIdentifier:stepCell];
    
    self.sectionCount = 2;
    
    
    if (self.attentionType == AttentionTypeDefault) {
        [self initDataAttention];
    } else {
        [self initDataUser];
    }
}

- (void)initDataAttention
{
    [[ENetwork sharedNetwork] POST:XBApiFeedFollow parameters:nil success:^(id responseObject) {
        ELog(@"XBApiFeedFollow   %@   ", responseObject[@"items"]);
        NSArray *itemsArr = [responseObject objectForKey:@"items"];
        [self analysisModelWithArr:itemsArr];
        
        [self.tableView reloadData];
    } failure:nil];
}

- (void)initDataUser
{
    [[ENetwork sharedNetwork] POST:XBApiFeedFollow parameters:nil success:^(id responseObject) {
        ELog(@"XBApiFeedFollow   %@   ", responseObject[@"items"]);
        NSArray *itemsArr = [responseObject objectForKey:@"items"];
        
        if (itemsArr.count == 0) {
            [self.view addSubview:self.userView];
        } else {
            [self analysisModelWithArr:itemsArr];
        }
        
        [self.tableView reloadData];
    } failure:nil];
}

// 解析请求回来的数据
- (void)analysisModelWithArr:(NSArray *)itemsArr
{
    for (NSDictionary *dic in itemsArr) {
        
        NSString *type = dic[@"type"];
        NSDictionary *content = dic[@"content"];
        
        XBAttentionModel *model = [[XBAttentionModel alloc] init];
        model.type = type;
        
        if ([type isEqualToString:@"follow_feed_step"]) {
            model.content = [XBFeedStepModel yy_modelWithDictionary:content];
        } else if ([type isEqualToString:@"follow_feed_plan"]) {
            model.content = [XBFeedPlanModel yy_modelWithDictionary:content];
        } else if ([type isEqualToString:@"follow_feed_tip"]) {
            model.content = [XBFeedTipModel yy_modelWithDictionary:content];
        }
        [self.attentionModelArr addObject:model];
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showTip:YES];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.attentionModelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBAttentionModel *model = self.attentionModelArr[indexPath.section];
    if ([model.type isEqualToString:@"follow_feed_step"]) {
        
        XBFootPrintTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footCell forIndexPath:indexPath];
        [cell setCellWithModel:model.content className:@"XBFootCustomIrregularGridViewCell" footType:FootTypeAttention];
        return cell;
        
    } else if ([model.type isEqualToString:@"follow_feed_plan"]) {
        XBAttentionPalnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:planCell forIndexPath:indexPath];
        [cell setCellWithModel:model.content];
        return cell;
        
    } else if ([model.type isEqualToString:@"follow_feed_tip"]) {
        
        XBAttentionStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stepCell forIndexPath:indexPath];
        [cell setCellWithModel:model.content];
        return cell;
        
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBAttentionModel *model = self.attentionModelArr[indexPath.section];
    
    if ([model.type isEqualToString:@"follow_feed_step"]) {
        XBAttentionModel *model = self.attentionModelArr[indexPath.section];
        return [self configStepCellHeightWithModel:model.content];
    } else if ([model.type isEqualToString:@"follow_feed_plan"]) {
        XBAttentionModel *model = self.attentionModelArr[indexPath.section];
        return [self configPlanCellHeightWithModel:model.content];
    } else if ([model.type isEqualToString:@"follow_feed_tip"]) {
        return 210.f;
    } else {
        return 0.1f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}


#pragma mark - 计算Cell高度
- (CGFloat)configStepCellHeightWithModel:(XBFeedStepModel *)model
{
    CGFloat h = 60.0f; // 关注的cell用户信息头部
    if (model.pics.count == 1 || model.video) {
#warning 实际已宽高比为准
        h += 260.f;
    } else if (model.pics.count) {
        h += 190.f;
    }
    
    NSString *str = [NSString stringWithFormat:@"@%@%@", model.from.from, model.text];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12.f]};
    CGSize size =  [str boundingRectWithSize:CGSizeMake(Width - 20, 60) options:NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    h = h + size.height + 55.f;
    return h;
}

- (CGFloat)configPlanCellHeightWithModel:(XBFeedPlanModel *)model
{
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12.f]};
    CGSize size =  [model.plan_info.brief_descript boundingRectWithSize:CGSizeMake(Width - 40, 50) options:NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    return size.height + 205.f;
}




#pragma mark - TipView

- (void)closeTipView
{
    self.sectionCount += 1;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    //这个位置应该在修改tableView之前将数据源先进行修改,否则会崩溃........必须向tableView的数据源数组中相应的添加一条数据
    [self.attentionModelArr insertObject:self.attentionModelArr[2] atIndex:0];
    
    [self.tableView beginUpdates];
    [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    [self.tableView reloadData];
    
    [self showTip:NO];
}

- (void)showTip:(BOOL)show
{
    if (show) {
        [self tipViewOpen];
    } else {
        [self tipViewClose];
    }
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (UIButton *)tipBt
{
    if (!_tipBt) {
        
        _tipBt = [[UIButton alloc] init];
        _tipBt.titleLabel.font = [UIFont systemFontOfSize:13];
        _tipBt.titleLabel.textAlignment = NSTextAlignmentCenter;
        _tipBt.backgroundColor = XBWriteColor;
        [_tipBt setTitleColor:XBDefaultMainColor forState:UIControlStateNormal];
        [_tipBt setTitle:@"有一条更新点击刷新看看" forState:UIControlStateNormal];
        [_tipBt addTarget:self action:@selector(closeTipView) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_tipBt];
        
        [_tipBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.height.mas_equalTo(self.tipBtHeight);
        }];
    }
    return _tipBt;
}

- (void)updateViewConstraints
{
    [self.tipBt mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(self.tipBtHeight);
    }];
    
    [self.tipBt.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tipBt);
        make.size.equalTo(self.tipBt);
    }];
    
    [super updateViewConstraints];
}

- (void)tipViewOpen
{
    self.tipBtHeight = 39;
}

- (void)tipViewClose
{
    self.tipBtHeight = 0;
}

- (NSMutableArray *)attentionModelArr
{
    if (!_attentionModelArr) {
        _attentionModelArr = [[NSMutableArray alloc] init];
    }
    return _attentionModelArr;
}

#pragma mark - 沙克里面如果没有数据，则显示引导界面
- (XBHomePageUserView *)userView
{
    if (!_userView) {
        _userView = [XBHomePageUserView userView];
        _userView.frame = CGRectMake(0, 0, Width, Height);
        
        _userView.choiceBlock = ^{
            // 去精选
            ELog(@"   去精选   ");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeToChoice" object:@0];
        };
        
        _userView.inviteBlock = ^{
            // 邀请亲友
            ELog(@"   邀请亲友   ");
        };
        
    }
    return _userView;
}

@end
