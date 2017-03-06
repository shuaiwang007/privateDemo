//
//  XBPlanCreatorTableViewCell.h
//  XB
//
//  Created by 王化强 on 2017/2/27.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTipDetailModel.h"

@interface XBPlanCreatorTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *focusBt;

- (void)setCellWithModel:(XBTipDetailUserInfoModel *)model;

@end
