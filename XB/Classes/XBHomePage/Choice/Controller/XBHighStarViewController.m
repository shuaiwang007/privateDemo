//
//  XBHighStarViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/23.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBHighStarViewController.h"
#import "XBHighStarTableViewCell.h"

static NSString *highStarCell = @"highStarCell";
@interface XBHighStarViewController ()

@end

@implementation XBHighStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerTitle = @"高能计划主";
    [self.tableView registerNib:[UINib nibWithNibName:@"XBHighStarTableViewCell" bundle:nil] forCellReuseIdentifier:highStarCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBHighStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:highStarCell forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

@end
