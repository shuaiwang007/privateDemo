//
//  XBCommenFootView.m
//  XB
//
//  Created by 王化强 on 2017/3/1.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBCommenFootView.h"

@implementation XBCommenFootView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.firstBT.hidden = YES;
}

+ (XBCommenFootView *)commenFootView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"XBCommenFootView" owner:nil options:nil];
    return (XBCommenFootView *)[nibView objectAtIndex:0];
}

- (IBAction)addFootAction:(UIButton *)sender {
    if (self.addFootBlock) {
        self.addFootBlock();
    }
}

- (IBAction)firstAction:(UIButton *)sender {
    if (self.firstBlock) {
        self.firstBlock();
    }
}

- (IBAction)shareAction:(UIButton *)sender {
    if (self.shareBlock) {
        self.shareBlock();
    }
}

- (IBAction)commentAction:(UIButton *)sender {
    if (self.commentBlock) {
        self.commentBlock();
    }
}


@end
