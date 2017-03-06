//
//  EErrorView.m
//  EFood
//
//  Created by 王化强 on 2016/11/20.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import "EErrorView.h"

@implementation EErrorView

+ (EErrorView *)initErrorView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"EErrorView" owner:nil options:nil];
    return (EErrorView *)[nibView objectAtIndex:0];
}


- (IBAction)errorRefreshAction:(UIButton *)sender {
    
    [[ENetwork sharedNetwork] POST:self.urlStr parameters:self.parameters success:self.success failure:nil];
    
    self.success = ^void (NSDictionary *dict) {
        
        ELog(@"   ==================   ");
    };
    
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}


@end
