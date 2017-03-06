//
//  XBOneStepTableViewCell.h
//  XB
//
//  Created by 王化强 on 2017/2/27.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPlanTipModel.h"

@interface XBOneStepTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *lineView;


- (void)setCellWithModel:(XBPlanTipModel *)model;

@end
