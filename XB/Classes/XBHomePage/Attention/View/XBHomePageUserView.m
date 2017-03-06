//
//  XBHomePageUserView.m
//  XB
//
//  Created by 王化强 on 2017/2/23.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBHomePageUserView.h"

@interface XBHomePageUserView ()

@property (weak, nonatomic) IBOutlet UILabel *userLab;
@property (weak, nonatomic) IBOutlet UIButton *choiceBt;
@property (weak, nonatomic) IBOutlet UIButton *inviteBt;

@end


@implementation XBHomePageUserView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.choiceBt.layer.cornerRadius = 5;
    self.choiceBt.layer.borderColor = XBDefaultMainColor.CGColor;
    self.choiceBt.layer.borderWidth = 1;
    
    self.inviteBt.layer.cornerRadius = 5;
    self.inviteBt.layer.borderColor = XBDefaultMainColor.CGColor;
    self.inviteBt.layer.borderWidth = 1;
    
}

+ (XBHomePageUserView *)userView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"XBHomePageUserView" owner:nil options:nil];
    XBHomePageUserView *userView = [nibView objectAtIndex:0];
    return userView;
}

- (IBAction)choiceAction:(UIButton *)sender {
    if (self.choiceBlock) {
        self.choiceBlock();
    }
}

- (IBAction)inviteAction:(UIButton *)sender {
    if (self.inviteBlock) {
        self.inviteBlock();
    }
}



@end
