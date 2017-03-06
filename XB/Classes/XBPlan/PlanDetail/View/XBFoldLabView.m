//
//  XBFoldLabView.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBFoldLabView.h"

@implementation XBFoldLabView

- (instancetype)initWithStr:(NSString *)str
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Width, [self configViewWithStr:str]);
    }
    return self;
}

- (CGFloat)configViewWithStr:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:13.f];
    CGFloat h = [XBCommonTool boundSizeWith:str attributes:@{NSFontAttributeName:font} constrainSize:CGSizeMake(Width - 30, 100)].height;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, Width - 30, h)];
    lab.numberOfLines = 0;
    lab.font = font;
    if (h > 60) {
        h = 60;
        lab.frame = CGRectMake(15, 10, Width - 30, 60);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        NSMutableParagraphStyle   *paragraphStyle   = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setTailIndent:Width - 30];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
        [lab setAttributedText:attributedString];
        [self addSubview:lab];
        
//        self.foldBt = [[UIButton alloc] initWithFrame:CGRectMake(Width - 60, CGRectGetMaxY(lab.frame)-20, 45, 20)];
//        self.foldBt.backgroundColor = [UIColor redColor];
//        [self.foldBt addTarget:self action:@selector(foldAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.foldBt];
    } else {
        lab.text = str;
        [self addSubview:lab];
    }
    
    
    return h + 10.f;
}

- (void)foldAction:(UIButton *)bt
{
    bt.hidden = YES;
}

@end
