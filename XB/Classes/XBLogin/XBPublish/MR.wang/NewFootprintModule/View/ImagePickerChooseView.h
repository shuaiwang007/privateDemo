//
//  ImagePickerChooseView.h
//  whqFor
//
//  Created by Mr.Wang on 2017/2/26.
//  Copyright © 2017年 Mr.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ImagePickerBlock)();
@interface ImagePickerChooseView : UIView

@property (nonatomic, strong)UIView *tapView;
@property (nonatomic, strong)UITableView *chooseTableView;
@property (nonatomic, copy) void(^smallVideoBlock)();
-(id)initWithFrame:(CGRect)frame andAboveView:(UIView *)bgView;
-(void)addImagePickerChooseView;
-(void)setImagePickerBlock:(ImagePickerBlock)block;
-(void)disappear;

@end
