//
//  XBNavigationBar.m
//  XB
//
//  Created by 王化强 on 2017/2/10.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBNavigationBar.h"

@implementation XBNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftBtn];
        [self addBottomLine];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLab.text = title;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, XBScreenWidth - 120, 43)];
        _titleLab.backgroundColor = XBWriteColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLab];
    }
    return _titleLab;
}


- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 20, 44, 43);
        _leftBtn.backgroundColor = [UIColor clearColor];
        [_leftBtn setTitleColor:XBDefaultFontColor forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _leftBtn.exclusiveTouch = YES;
        [_leftBtn addTarget:self action:@selector(leftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(XBScreenWidth - 44, 20, 44, 43);
        _rightBtn.backgroundColor = [UIColor clearColor];
        [_rightBtn setTitleColor:XBDefaultFontColor forState:UIControlStateNormal];
        
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightBtn.exclusiveTouch = YES;
        [_rightBtn addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (void)leftBarButtonClick:(UIButton *)button;
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftBarButtonClick:)]) {
        [self.delegate leftBarButtonClick:button];
    }
}
- (void)rightBarButtonClick:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightBarButtonClick:)]) {
        [self.delegate rightBarButtonClick:button];
    }
}

- (void)addBottomLine
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.7, XBScreenWidth, 0.7)];
    line.backgroundColor = XBLineColor;
    [self addSubview:line];
}

@end
