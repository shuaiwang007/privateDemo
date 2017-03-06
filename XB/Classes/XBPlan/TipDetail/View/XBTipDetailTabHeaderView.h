//
//  XBTipDetailTabHeaderView.h
//  XB
//
//  Created by 王化强 on 2017/2/27.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTipDetailTabHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

+ (XBTipDetailTabHeaderView *)tabHeaderView;

@end
