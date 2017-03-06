//
//  XBReCommentViewController.m
//  XB
//
//  Created by 王化强 on 2017/3/1.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBReCommentViewController.h"

@interface XBReCommentViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeHoldLab;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

@implementation XBReCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.delegate = self;
    self.tableView.hidden = YES;
    
    [self.eNaviBar.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.eNaviBar.leftBtn setImage:nil forState:UIControlStateNormal];
    [self.eNaviBar.rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    self.eNaviBar.rightBtn.userInteractionEnabled = NO;
    self.eNaviBar.rightBtn.backgroundColor = XBDefaultBackGroundColor;
    
    
    [self.textView becomeFirstResponder];
    self.placeHoldLab.text = @"对进行评论";
    
    if (self.model) {
        self.placeHoldLab.text = [NSString stringWithFormat:@"回复：%@", self.model.user_info.user_name];
    } else {
        self.placeHoldLab.text = @"聊聊这个计划吧";
    }
}

- (void)rightBarButtonClick:(UIButton *)button
{
    
    ELog(@"   发布评论   ");
    if (self.pushBlock) {
        if (self.model) {
            self.model.parent_comment.comment = self.model.comment;
            self.model.parent_comment.ID = self.model.ID;
            self.model.parent_comment.date_time = self.model.date_time;
            self.model.parent_comment.user_info = self.model.user_info;
            self.model.comment = self.textView.text;
        } else {
            XBCommentModel *model = [[XBCommentModel alloc] init];
            model.ID = @11;
            model.user_info.user_id = @1;
            model.user_info.user_name = @"我自己";
//            model.user_info.user_pic = @"";
            model.parent_comment = nil;
            model.comment = self.textView.text;
            model.date_time = [XBCommonTool getCurrentTimestamp];
            self.model = model;
        }
        
        
        [self dismissViewControllerAnimated:YES completion:^{
            self.pushBlock(self.model);
        }];
    }
    
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.eNaviBar.rightBtn.userInteractionEnabled = NO;
        self.eNaviBar.rightBtn.backgroundColor = XBDefaultBackGroundColor;
        self.placeHoldLab.hidden = NO;
    } else {
        self.placeHoldLab.hidden = YES;
        self.eNaviBar.rightBtn.userInteractionEnabled = YES;
        self.eNaviBar.rightBtn.backgroundColor = XBWriteColor;
    }
    
    
    if (self.textView.text.length > 140) {
       self.textView.text = [self.textView.text substringToIndex:140];
        self.countLab.text = @"140/140";
        
    } else {
        self.countLab.text = [NSString stringWithFormat:@"%zd/140", self.textView.text.length];
    }
}

@end
