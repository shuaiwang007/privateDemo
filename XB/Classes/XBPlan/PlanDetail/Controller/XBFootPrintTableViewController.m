//
//  XBFootPrintTableViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/25.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBFootPrintTableViewController.h"
#import "XBFeedStepModel.h"
#import "XBFootPrintTableViewCell.h"

static NSString *footPrintTabcell = @"footPrintTabcell";

@interface XBFootPrintTableViewController ()
@property (nonatomic, strong) NSArray *stepModelArr;
@property (nonatomic, strong) NSNumber *allStepCount;

@end

@implementation XBFootPrintTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 0, Width, Height - 45);
    [self.tableView registerNib:[UINib nibWithNibName:@"XBFootPrintTableViewCell" bundle:nil] forCellReuseIdentifier:footPrintTabcell];
    [self loadStep];
}

- (void)loadStep
{
    if (!self.plan_res_id) {
        return;
    }
    [[ENetwork sharedNetwork] POST:XBApiStepLists parameters:@{@"plan_res_id":self.plan_res_id, @"pn":@1} success:^(id responseObject) {
        ELog(@"XBApiStepLists   %@   ", responseObject);
        
        self.stepModelArr = [NSArray yy_modelArrayWithClass:[XBFeedStepModel class] json:responseObject[@"items"]];
        self.allStepCount = [responseObject objectForKey:@"all_count"];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ELog(@"   %@   ", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stepModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBFootPrintTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footPrintTabcell forIndexPath:indexPath];
    XBFeedStepModel *model = self.stepModelArr[indexPath.row];
    [cell setCellWithModel:model className:@"XBFootCustomIrregularGridViewCell" footType:FootTypeAttention];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self configStepCellHeightWithModel:self.stepModelArr[indexPath.row]];
}

#pragma mark - 计算脚印Cell高度
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



@end
