//
//  XBNavigationBar.h
//  XB
//
//  Created by 王化强 on 2017/2/10.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  XBNavigationBarDelegate <NSObject>

- (void)leftBarButtonClick:(UIButton *)button;
- (void)rightBarButtonClick:(UIButton *)button;

@end

@interface XBNavigationBar : UIView

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, weak) id<XBNavigationBarDelegate> delegate;

@end
