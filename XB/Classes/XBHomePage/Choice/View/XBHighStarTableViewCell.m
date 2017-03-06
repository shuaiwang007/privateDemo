//
//  XBHighStarTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/23.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBHighStarTableViewCell.h"

@interface XBHighStarTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *focusBt;

@end

@implementation XBHighStarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.focusBt.layer.cornerRadius = 3.0f;
    self.focusBt.layer.borderWidth = 1.0f;
    self.focusBt.layer.borderColor = XBDefaultMainColor.CGColor;
}

- (IBAction)focusAction:(UIButton *)sender {
    if (self.focusBlock) {
        self.focusBlock(YES);
    }
}


@end
