//
//  XBCommentViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/28.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBCommentViewController.h"
#import "XBCommentModel.h"
#import "XBCommentTableViewCell.h"
#import "XBReCommentViewController.h"
#import "XBCommenFootView.h"

static NSString *commentCell = @"commentCell";

@interface XBCommentViewController ()

@end

@implementation XBCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XBCommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentCell];
    
    self.tableView.scrollEnabled = self.scrollEnable;
    
    [self initData];
}

- (void)initData
{
    NSString *api;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@1 forKey:@"pn"];
    if (self.plan_res_id) {
        api = XBApiCommentPlanList;
        [dict setObject:self.plan_res_id forKey:@"plan_res_id"];
    } else if (self.step_res_id) {
        api = XBApiCommentStepList;
        [dict setObject:self.step_res_id forKey:@"step_res_id"];
    } else {
        return;
    }
    [[ENetwork sharedNetwork] POST:api parameters:dict success:^(id responseObject) {
        ELog(@"XBApiCommentPlanList   %@   ", responseObject);
        
        self.commentArr = [[NSArray yy_modelArrayWithClass:[XBCommentModel class] json:responseObject[@"items"]] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self addBottomView];
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        ELog(@"   %@   ", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCell forIndexPath:indexPath];
    
    if (indexPath.row == 0 && self.commenViewHBLock) {
        self.commenViewHBLock(self.tableView.contentSize.height);
    }
    
    [cell setCellWithModel:self.commentArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBCommentModel *model = self.commentArr[indexPath.row];
    [self presentCommenVCWithModel:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self configCellHeightWithModel:self.commentArr[indexPath.row]];
}
- (CGFloat)configCellHeightWithModel:(XBCommentModel *)model
{
    CGFloat h = 45.f;
    
    if (model.parent_comment) {
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:11.f]};
        CGSize parentSize = [XBCommonTool boundSizeWith:model.parent_comment.comment attributes:dict constrainSize:CGSizeMake(Width - 70, 100)];
        h = h + 15 + parentSize.height;
    }
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:11.f]};
    CGSize commentSize = [XBCommonTool boundSizeWith:model.comment attributes:dict constrainSize:CGSizeMake(Width - 60, 100)];
    h += commentSize.height;
    
    return h;
}


- (void)presentCommenVCWithModel:(XBCommentModel *)model
{
    XBReCommentViewController *VC = [[XBReCommentViewController alloc] init];
    VC.model = model;
    VC.pushBlock = ^(XBCommentModel *model) {
        [self.commentArr insertObject:model atIndex:0];
        [self.tableView reloadData];
    };
    [self presentViewController:VC animated:YES completion:nil];
}





/**
 //    NSString *alertStr = @"这个脚印";
 //    if (model.comment) {
 //        alertStr = model.comment;
 //    }
 //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"是否对:%@ 进行评论", alertStr] preferredStyle:UIAlertControllerStyleActionSheet];
 //    UIAlertAction *action = [UIAlertAction actionWithTitle:@"评论" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 //        ELog(@"   发布   ");
 //        XBReCommentViewController *VC = [[XBReCommentViewController alloc] init];
 //        VC.model = model;
 //        VC.pushBlock = ^(XBCommentModel *model) {
 //            [self.commentArr insertObject:model atIndex:0];
 //            [self.tableView reloadData];
 //        };
 //
 //        [self presentViewController:VC animated:YES completion:nil];
 //    }];
 //    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
 //    [alert addAction:action];
 //    [alert addAction:cancel];
 //    [self presentViewController:alert animated:YES completion:nil];

 */
@end
