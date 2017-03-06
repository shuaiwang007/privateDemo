//
//  WaterfallLayoutController.h
//  Animations
//
//  Created by YouXianMing on 16/1/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//



@interface WaterfallLayoutController : UIViewController

@property (nonatomic, copy) void (^itemCountBlock) (CGFloat H);

- (void)loadMoreData;

@end
