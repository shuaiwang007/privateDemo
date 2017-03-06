//
//  XBReCommentViewController.h
//  XB
//
//  Created by 王化强 on 2017/3/1.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBNavTableViewViewController.h"
#import "XBCommentModel.h"

@interface XBReCommentViewController : XBNavTableViewViewController

@property (nonatomic, strong) XBCommentModel *model;
@property (nonatomic, copy) void (^pushBlock)(XBCommentModel *model);

@end
