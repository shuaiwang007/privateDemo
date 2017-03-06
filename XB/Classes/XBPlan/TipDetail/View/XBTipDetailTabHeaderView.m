//
//  XBTipDetailTabHeaderView.m
//  XB
//
//  Created by 王化强 on 2017/2/27.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBTipDetailTabHeaderView.h"

@implementation XBTipDetailTabHeaderView

+ (XBTipDetailTabHeaderView *)tabHeaderView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"XBTipDetailTabHeaderView" owner:nil options:nil];
    return (XBTipDetailTabHeaderView *)[nibView objectAtIndex:0];
}

@end
