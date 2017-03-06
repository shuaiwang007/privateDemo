//
//  XBFootPrintTableViewCell.h
//  XB
//
//  Created by 王化强 on 2017/2/21.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBFeedStepModel.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

typedef NS_ENUM(NSInteger, FootType) {
    FootTypeAttention,          // 关注里的cell样式 区别在于cell的头部不同
    FootTypeFootPrient,         // 脚印页的cell样式 也有头像
    FootTypeFootPrientDetail    // 某个脚印的cell样式 有头像 姓名 来自
};

@interface XBFootPrintTableViewCell : UITableViewCell

@property (nonatomic,strong) AVPlayer *player;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic, copy) void (^focusBlock)(NSNumber *userId);

- (void)setCellWithModel:(XBFeedStepModel *)model
               className:(NSString *)className
                footType:(FootType)footType;

@end
