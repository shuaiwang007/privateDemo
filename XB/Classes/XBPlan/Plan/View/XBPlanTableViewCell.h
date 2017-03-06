//
//  XBPlanTableViewCell.h
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPlanListModel.h"

@interface XBPlanTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *myProgressLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;

- (void)setCellWithModel:(XBPlanListModel *)model progressViewHidden:(BOOL)hidden;

@end
