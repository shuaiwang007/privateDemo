//
//  XBBaseTableViewController.h
//  XB
//
//  Created by 王化强 on 2017/2/18.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBBaseTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end
