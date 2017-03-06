//
//  UIImage+RoundRectImage.h
//  XB
//
//  Created by 王化强 on 2017/2/13.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundRectImage)

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

@end
