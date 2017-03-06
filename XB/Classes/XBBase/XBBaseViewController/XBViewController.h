//
//  XBViewController.h
//  XB
//
//  Created by 王化强 on 2017/2/11.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBNavigationBar.h"

@interface XBViewController : UIViewController

@property (nonatomic, strong) XBNavigationBar *eNaviBar;
@property (nonatomic, strong) NSString *headerTitle;

- (void)leftBarButtonClick:(UIButton *)button;
- (void)rightBarButtonClick:(UIButton *)button;

@end
