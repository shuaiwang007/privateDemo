//
//  XBPlanTipModel.h
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBPlanTip : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *tip_cat;
@property (nonatomic, strong) NSNumber *all_count;
@property (nonatomic, strong) NSArray *items;

@end

@interface XBPlanTipModel : NSObject

@property (nonatomic, strong) NSString *tip_res_id;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *brief;

@end
