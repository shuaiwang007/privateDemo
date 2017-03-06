//
//  XBPlanTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanTableViewCell.h"

@interface XBPlanTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;

@end

@implementation XBPlanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithModel:(XBPlanListModel *)model progressViewHidden:(BOOL)hidden
{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.titleLab.text = model.title;
    if (!model.joined_count) {
        model.joined_count = @1;
    }
    self.desLab.text = [NSString stringWithFormat:@"%@人加入 | %@小步", model.joined_count, model.tip_count];
    
    
    if (!hidden) {
        self.myProgressLab.hidden = NO;
        self.progressView.hidden = NO;
        self.lineView.hidden = YES;
        NSInteger myStep = [model.my_step_count integerValue];
        self.myProgressLab.text = [NSString stringWithFormat:@"%zd/%@", myStep, model.tip_count];
        self.progressView.progress = 0.5;//5/[model.tip_count integerValue];
        CGFloat p = [model.my_step_count floatValue] / [model.tip_count floatValue];
        [self.progressView setProgress:p animated:YES];
    } else {
        self.lineView.hidden = NO;
        self.myProgressLab.hidden = YES;
        self.progressView.hidden = YES;
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.progressView.hidden = NO;
    self.myProgressLab.hidden = NO;
    self.lineView.hidden = NO;
}

@end
