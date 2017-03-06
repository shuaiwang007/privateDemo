//
//  XBTagView.m
//  XB
//
//  Created by 王化强 on 2017/3/2.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBTagView.h"

@interface XBTagView ()

@end

@implementation XBTagView

- (instancetype)initWithArr:(NSArray *)arr
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Width, [self configHWithArr:arr]);
    };
    return self;
}

- (CGFloat)configHWithArr:(NSArray *)arr
{
    CGFloat h = 10.f; // 行间隔
    CGFloat line = 1;
    CGFloat x = Width - 15;
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        CGFloat w = [self widthWithStr:arr[i]];
        if (i == 0) {
            x = x - w;
        } else {
            
            if (x - w < 15) {
                line += 1;
                x = Width - 15 - w;
            } else {
                x = x - w - 10 - 5; // 列间距10 bt宽+5
            }
        }
        
        UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(x, (line - 1)*20+ line*h , w + 5, 20)];
        [bt setTitle:arr[i] forState:UIControlStateNormal];
        bt.layer.borderWidth = 1;
        bt.layer.cornerRadius = 3;
        [bt setTitleColor:XBDefaultFontColor forState:UIControlStateNormal];
        bt.layer.borderColor = XBDefaultFontColor.CGColor;
        bt.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:bt];
    }
    
    return (line + 1)*h + line*20;
}

- (CGFloat)widthWithStr:(NSString *)str
{
    return [XBCommonTool boundSizeWith:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} constrainSize:CGSizeMake(300, 30)].width;
}

@end
