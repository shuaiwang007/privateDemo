//
//  XBStepDetailTableViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/28.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBStepDetailTableViewController.h"
#import "XBFeedStepModel.h"
#import "XBFootPrintTableViewCell.h"
#import "XBStepFromTableViewCell.h"
#import "XBCommenFootView.h"
#import "XBCommentViewController.h"
#import "XBReCommentViewController.h"
#import "XBCommentModel.h"

static NSString *footPrintTabcell = @"footPrintTabcell";
static NSString *stepFromCell = @"stepFromCell";

@interface XBStepDetailTableViewController ()

@property (nonatomic, strong) XBFeedStepModel *stepModel;
@property (nonatomic, strong) XBCommentViewController *commenVC;
@property (nonatomic, assign) CGFloat commenViewH;

@end

@implementation XBStepDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerTitle = @"某个脚印页";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XBFootPrintTableViewCell" bundle:nil] forCellReuseIdentifier:footPrintTabcell];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBStepFromTableViewCell" bundle:nil] forCellReuseIdentifier:stepFromCell];
    
    [self initData];
}

- (void)initData
{
    if (!self.res_id) {
        return;
    }
    [[ENetwork sharedNetwork] POST:XBApiStepDetail parameters:@{@"res_id":self.res_id} success:^(id responseObject) {
        ELog(@"XBApiStepDetail   %@   ", responseObject);
        
        self.stepModel = [XBFeedStepModel yy_modelWithJSON:responseObject[@"content"]];
        
        [self addBottomView];
        [self.tableView reloadData];
        
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
    if (section < 2) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XBFootPrintTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footPrintTabcell forIndexPath:indexPath];
        [cell setCellWithModel:self.stepModel className:@"XBFootCustomIrregularGridViewCell" footType:FootTypeFootPrientDetail];
        return cell;
    } else if (indexPath.section == 1) {
        XBStepFromTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stepFromCell forIndexPath:indexPath];
        [cell setCellWithModel:self.stepModel.from];
        
        return cell;
        
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        [cell addSubview:self.commenVC.view];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self configStepCellHeightWithModel:self.stepModel];
    } else if (indexPath.section == 1) {
        return 180.f;
    } else {
        return self.commenViewH;
    }
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

- (XBCommentViewController *)commenVC
{
    if (!_commenVC) {
        _commenVC = [[XBCommentViewController alloc] init];
        __weak typeof(self) weakSelf = self;
        [self addChildViewController:_commenVC];
        _commenVC.scrollEnable = NO;
        _commenVC.step_res_id = self.res_id;
        _commenVC.commenViewHBLock = ^(CGFloat H) {
            weakSelf.commenViewH = H;
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
    return _commenVC;
}

- (void)addBottomView
{
    self.tableView.frame = CGRectMake(0, 64, Width, self.view.height - 50 - 64);
    XBCommenFootView *bottomView = [XBCommenFootView commenFootView];
    bottomView.frame = CGRectMake(0, Height - 50, Width, 50);
    
    bottomView.addFootBlock = ^{
        ELog(@"   加脚印   ");
    };
    
    bottomView.shareBlock = ^{
        ELog(@"   分享   ");
    };
    
    bottomView.commentBlock = ^{
        ELog(@"   评论   ");
        [self presentCommenVCWithModel:nil];
    };
    [self.view addSubview:bottomView];
}

- (void)presentCommenVCWithModel:(XBCommentModel *)model
{
    XBReCommentViewController *VC = [[XBReCommentViewController alloc] init];
    VC.pushBlock = ^(XBCommentModel *model) {
        [self.commenVC.commentArr insertObject:model atIndex:0];
        [self.commenVC.tableView reloadData];
    };
    [self presentViewController:VC animated:YES completion:nil];
}

@end
