//
//  XBAttentionViewController.h
//  XB
//
//  Created by 王化强 on 2017/2/17.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AttentionType) {
    AttentionTypeDefault,
    AttentionTypeUser,
};

@interface XBAttentionViewController : XBBaseTableViewController

@property (nonatomic, assign) AttentionType attentionType;

@end
