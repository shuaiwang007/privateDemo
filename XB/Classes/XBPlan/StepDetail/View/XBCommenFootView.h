//
//  XBCommenFootView.h
//  XB
//
//  Created by 王化强 on 2017/3/1.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBCommenFootView : UIView

@property (weak, nonatomic) IBOutlet UIButton *firstBT;

@property (weak, nonatomic) IBOutlet UIButton *addFootPrintBt;
@property (weak, nonatomic) IBOutlet UIButton *commentBt;
@property (nonatomic, copy) void (^addFootBlock)();
@property (nonatomic, copy) void (^firstBlock)();
@property (nonatomic, copy) void (^shareBlock)();
@property (nonatomic, copy) void (^commentBlock)();

+ (XBCommenFootView *)commenFootView;

@end
