//
//  WaterfallLayoutController.m
//  Animations
//
//  Created by YouXianMing on 16/1/3.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "WaterfallLayoutController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "XBFootprintCollectionViewCell.h"
#import "XBChoiceModel.h"
#import "XBImgVCollectionViewCell.h"
#import "XBStepDetailTableViewController.h"

static NSString *picturesSource   = @"http://www.duitang.com/album/1733789/masn/p/0/50/";
static NSString *cellIdentifier   = @"xbFootPrintCell";
static NSString *imageCell        = @"imageCell";

@interface WaterfallLayoutController () <UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) XBBestPopularSteps *popularStepModel;

@end

@implementation WaterfallLayoutController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XBFootprintCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XBImgVCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:imageCell];
    
    [self initData];
}

- (void)initData
{
    [[ENetwork sharedNetwork] POST:XBApiPopStep parameters:@{@"pn":@1} success:^(id responseObject) {
        ELog(@"XBApiPopStep   %@   ", responseObject);
        self.popularStepModel = [XBBestPopularSteps yy_modelWithJSON:responseObject];
        
//        NSInteger count = self.popularStepModel.items.count;
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            ELog(@"_dataSource.count   %zd   ", count);
//            CGFloat h = (count/2 + count%2)*(10 + 1.0*(Width - 40)/2 * (1.0 * 20 / 14)) - 10;
//            self.collectionView.frame = CGRectMake(0, 0, Width, h > 0 ? h : 0.01f);
            [self.collectionView reloadData];
        });
        
    } failure:nil];
}

- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.itemCountBlock) {
            [_dataSource addObjectsFromArray:@[@"1", @"2", @"3"]];
//            self.itemCountBlock(_dataSource.count);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
    });
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XBBestPopularStepsModel *model = self.popularStepModel.items[indexPath.row];
    NSLog(@"点击了 %@", model.type);
    XBStepDetailTableViewController *VC = [[XBStepDetailTableViewController alloc] init];
    VC.res_id = model.step_res_id;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ELog(@"section.contentSize   %.f   ", self.collectionView.contentSize.height);
    return self.popularStepModel.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XBBestPopularStepsModel *model = self.popularStepModel.items[indexPath.row];
    UICollectionViewCell *cell;
    
    if ([model.type isEqualToString:@"op"]) {
        XBImgVCollectionViewCell *cellImg = [collectionView dequeueReusableCellWithReuseIdentifier:imageCell forIndexPath:indexPath];
        [cellImg.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        cell = cellImg;
    } else {
        XBFootprintCollectionViewCell *cellFoot = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        [cellFoot setCellWithPopularStepModel:model];
        cell = cellFoot;
    }
    
    if (indexPath.row == 0) {
        if (self.itemCountBlock) {
            self.itemCountBlock(self.collectionView.contentSize.height);
            self.collectionView.frame = CGRectMake(0, 0, Width, self.collectionView.contentSize.height);
        }
        ELog(@"collectionView.contentSize   %.f   ", self.collectionView.contentSize.height);
    }
    
    return cell;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
// 计算cell宽高比
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellW =1.0 * (Width - 40) / 2;
    XBBestPopularStepsModel *model = self.popularStepModel.items[indexPath.row];
    
    if ([model.type isEqualToString:@"op"]) { // 推荐位
        // 宽高比
        return CGSizeMake(cellW, 1.0*model.height * cellW / model.width);
    } else {
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
        CGSize size = [model.brief_content boundingRectWithSize:CGSizeMake(cellW, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        // 宽高比
        ELog(@"size.height   %.f   ", size.height);
        return CGSizeMake(cellW, 1.0*model.height * cellW / model.width + size.height + 55);
    }
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        // 初始化布局
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        // 设置布局
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        layout.columnCount  = 2;             // 几列显示
        layout.minimumColumnSpacing    = 10;  // cell之间的水平间距
        layout.minimumInteritemSpacing = 10;  // cell之间的垂直间距
        
        // 初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:layout];
        //    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource       = self;
        _collectionView.delegate         = self;
        _collectionView.backgroundColor  = [UIColor whiteColor];
        
        
        // 添加到视图当中
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
