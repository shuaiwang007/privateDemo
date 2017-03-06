//
//  XBRecommondPlanerModel.h
//  XB
//
//  Created by 王化强 on 2017/2/23.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBRecommondPlaner : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *items;

@end

@interface XBRecommondPlanerModel : NSObject

@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSString *recommond_reason;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *user_pic;
@property (nonatomic, strong) NSNumber *is_followed;

@end
