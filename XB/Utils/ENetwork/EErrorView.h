//
//  EErrorView.h
//  EFood
//
//  Created by 王化强 on 2016/11/20.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EErrorView : UIView

@property (weak, nonatomic) IBOutlet UILabel *errorLab;
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) id parameters;
@property (nonatomic, copy) void (^success)(NSDictionary *responseObject);


+ (EErrorView *)initErrorView;

@property (nonatomic, copy) void(^refreshBlock)();

@end
