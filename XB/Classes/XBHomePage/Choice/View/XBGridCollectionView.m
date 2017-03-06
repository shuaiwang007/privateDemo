//
//  XBGridCollectionView.m
//  XB
//
//  Created by 王化强 on 2017/2/14.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBGridCollectionView.h"
#import "IrregularGridCollectionView.h"

@interface XBGridCollectionView () <IrregularGridCollectionViewDelegate>

@property (nonatomic, strong) IrregularGridCollectionView *irregularGridView;

@end

@implementation XBGridCollectionView

- (void)setCellWithModelArr:(NSArray *)modelArr
                      class:(NSString *)className
                   itemSize:(CGSize)itemSize
                 cellHeight:(CGFloat)cellHeight
{
    
    if (self.irregularGridView || modelArr.count < 1) {
        return;
        ELog(@"   ===irregularGridView===   ");
    }
    
    CGFloat edgeInsetTop    = 10.f;
    CGFloat gridHeight      = itemSize.height;
    CGFloat edgeInsetBottom = 10.f;
    
    NSMutableArray *arrays = [NSMutableArray array];
    Class class = NSClassFromString(className);
    
    [modelArr enumerateObjectsUsingBlock:^(id model, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrays addObject:[class dataAdapterWithData:model itemWidth:itemSize.width]];
    }];
    
    // Create IrregularGridCollectionView.
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5); // 上 左 下 右
    
    self.irregularGridView = [IrregularGridCollectionView irregularGridCollectionViewWithFrame:CGRectMake(0, 0, Width, cellHeight)
                                                                                    flowLayout:flowLayout
                                                                                      delegate:self
                                                                                 registerCells:@[gridViewCellClassType([class class], nil, YES)]
                                                                               scrollDirection:UICollectionViewScrollDirectionHorizontal
                                                                             contentEdgeInsets:UIEdgeInsetsMake(edgeInsetTop, 10, edgeInsetBottom, 10)
                                                                                   lineSpacing:0.f
                                                                              interitemSpacing:10.f
                                                                                    gridHeight:gridHeight];
    self.irregularGridView.adapters = arrays;
    
    [self addSubview:self.irregularGridView];
    // Debug frame.
    if (/* DISABLES CODE */ (0)) {
        
        self.irregularGridView.layer.borderWidth = 0.5f;
        self.irregularGridView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.35f].CGColor;
    }
}


- (void)irregularGridCollectionView:(IrregularGridCollectionView *)irregularGridCollectionView didSelectedCell:(CustomIrregularGridViewCell *)cell event:(id)event
{
    if (self.actionBlock) {
        self.actionBlock(cell.dataAdapter.indexPath);
    }
}


@end
