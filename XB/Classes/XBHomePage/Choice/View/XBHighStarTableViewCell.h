//
//  XBHighStarTableViewCell.h
//  XB
//
//  Created by 王化强 on 2017/2/23.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBHighStarTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^focusBlock)(BOOL focus);

@end
