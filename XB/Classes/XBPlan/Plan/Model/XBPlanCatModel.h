//
//  XBPlanCatModel.h
//  XB
//
//  Created by 王化强 on 2017/2/24.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBPlanCatModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *descriptions;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSArray *tags;

@end

@interface XBPlantagModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;

@end
