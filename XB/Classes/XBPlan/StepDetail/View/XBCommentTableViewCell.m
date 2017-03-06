//
//  XBCommentTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/28.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBCommentTableViewCell.h"

@interface XBCommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *parentCommontLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *parentViewTopConstaraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *parentHConstraint;


@end

@implementation XBCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModel:(XBCommentModel *)model
{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.user_info.user_pic]];
    self.userNameLab.text = model.user_info.user_name;
    self.timeLab.text = [XBCommonTool timeFormatConversionWithDataStr:model.date_time];
    if (model.parent_comment) {
        self.parentViewTopConstaraint.constant = 0.01f;
        self.parentHConstraint.constant = 0.01f;
        self.parentCommontLab.text = model.parent_comment.comment;
    }
    self.commentLab.text = model.comment;
}

- (IBAction)headerAction:(UIButton *)sender {
    
    ELog(@"   点击了用户头像   ");
}


@end
