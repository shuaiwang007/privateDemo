//
//  XBGridCollectionView.h
//  XB
//
//  Created by 王化强 on 2017/2/14.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBGridCollectionView : UITableViewCell

@property (nonatomic, copy) void (^actionBlock)(NSIndexPath *indexPath);

- (void)setCellWithModelArr:(NSArray *)modelArr
                      class:(NSString *)className
                   itemSize:(CGSize)itemSize
                 cellHeight:(CGFloat)cellHeight;

@end
