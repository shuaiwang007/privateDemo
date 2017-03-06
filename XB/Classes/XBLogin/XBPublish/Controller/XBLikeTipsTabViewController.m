//
//  XBLikeTipsTabViewController.m
//  XB
//
//  Created by 王化强 on 2017/3/4.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBLikeTipsTabViewController.h"
#import "XBMyLikeTipModel.h"
#import "XBMyLikeTipTableViewCell.h"

static NSString *myLikeTipCell = @"myLikeTipCell";
@interface XBLikeTipsTabViewController ()
@property (nonatomic, strong) NSArray *modelArr;
@end

@implementation XBLikeTipsTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XBMyLikeTipTableViewCell" bundle:nil] forCellReuseIdentifier:myLikeTipCell];
    
    self.tableView.rowHeight = 80;
    [self initData];
}

- (void)initData
{
    [[ENetwork sharedNetwork] POST:XBApiTipsMyLike parameters:@{@"pn":@1} success:^(id responseObject) {
        ELog(@"XBApiTipsMyLike   %@   ", responseObject);
        self.modelArr = [NSArray yy_modelArrayWithClass:[XBMyLikeTipModel class] json:responseObject[@"items"]];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ELog(@"   %@   ", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBMyLikeTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myLikeTipCell forIndexPath:indexPath];
    [cell setCellWithModel:self.modelArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBMyLikeTipModel *model = self.modelArr[indexPath.row];
    if (self.callBack) {
        self.callBack(model.tip_res_id, model.title);
    }
}


@end
