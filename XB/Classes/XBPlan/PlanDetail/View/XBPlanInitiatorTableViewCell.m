//
//  XBPlanInitiatorTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanInitiatorTableViewCell.h"

@interface XBPlanInitiatorTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *desPlanLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *focusBt;
@property (weak, nonatomic) IBOutlet UILabel *desUserLab;

@property (nonatomic, strong) NSNumber *userId;
@end

@implementation XBPlanInitiatorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.focusBt.layer.cornerRadius = 4;
    self.focusBt.layer.borderWidth = 1;
    self.focusBt.layer.borderColor = [UIColor colorFromHexRGB:@"FD9C24"].CGColor;
}

- (void)setCellWithModel:(XBPlaner *)model
{
    self.userId = model.user_id;
    
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.user_pic]];
    self.nameLab.text = model.user_name;
    self.desPlanLab.text = model.planer_tag;
    self.desUserLab.text = model.descriptions;
    
}
- (IBAction)focusAction:(UIButton *)sender {
    
    if (self.focusBlock) {
        self.focusBlock(self.userId);
    }
}

@end
