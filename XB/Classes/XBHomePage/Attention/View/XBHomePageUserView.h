//
//  XBHomePageUserView.h
//  XB
//
//  Created by 王化强 on 2017/2/23.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBHomePageUserView : UIView

@property (nonatomic, copy) void (^choiceBlock)();
@property (nonatomic, copy) void (^inviteBlock)();

+ (XBHomePageUserView *)userView;

@end
