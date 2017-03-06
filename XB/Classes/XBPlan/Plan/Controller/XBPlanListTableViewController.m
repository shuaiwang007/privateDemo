//
//  XBPlanListTableViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/17.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBPlanListTableViewController.h"
#import "IrregularGridCollectionView.h"
#import "IrregularPictureGridCell.h"
#import "BlueIrregularGridViewCell.h"
#import "XBPlanCatModel.h"
#import "XBPlanListModel.h"
#import "XBPlanTableViewCell.h"


static NSString *planListCell = @"planListCell";
@interface XBPlanListTableViewController () <IrregularGridCollectionViewDelegate>

@property (nonatomic, assign) NSInteger selectTitleIndex;
@property (nonatomic, strong) NSArray *planArr;

@end

@implementation XBPlanListTableViewController

/**
 根据planPage，cat及tag得到的数据
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.tags) {
        self.tableView.tableHeaderView = [self createDirectionVerticalType];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XBPlanTableViewCell" bundle:nil] forCellReuseIdentifier:planListCell];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self initDataWithTagId:nil];
    
}

- (void)initDataWithTagId:(NSString *)tag_id
{
    if (!tag_id) {
        tag_id = @"0";
    }
    [[ENetwork sharedNetwork] POST:XBApiPlanSearch parameters:@{@"tag_id":tag_id, @"cat_id":self.cat_id, @"pn":@0} success:^(id responseObject) {
        
        self.planArr = [NSArray yy_modelArrayWithClass:[XBPlanListModel class] json:[responseObject objectForKey:@"items"]];
        [self.tableView reloadData];
        
    } failure:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.planArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XBPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:planListCell forIndexPath:indexPath];
    
    [cell setCellWithModel:self.planArr[indexPath.row] progressViewHidden:NO];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.f;
}

#pragma mark - 创建标签
- (IrregularGridCollectionView *)createDirectionVerticalType {
    
    // Create dataSource.
    NSMutableArray *array  = [NSMutableArray array];
    for (int i = 0; i < self.tags.count; i++) {
        XBPlantagModel *model = self.tags[i];
        
        CGRect rect = [model.name boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                           options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}
                                           context:nil];
        
        CGFloat   value  = rect.size.width + 20.f;
        [array addObject:[BlueIrregularGridViewCell dataAdapterWithData:model.name type:0 itemWidth:value]];
    }
    
    // Create IrregularGridCollectionView.
    IrregularGridCollectionView *irregularGridView;
    irregularGridView = [IrregularGridCollectionView irregularGridCollectionViewWithFrame:CGRectMake(0, 300, Width, 0)
                                                                               flowLayout:nil
                                                                                 delegate:self
                                                                            registerCells:@[gridViewCellClassType([BlueIrregularGridViewCell class], nil, NO)]
                                                                          scrollDirection:UICollectionViewScrollDirectionVertical
                                                                        contentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                              lineSpacing:10
                                                                         interitemSpacing:10.f
                                                                               gridHeight:30.f];
    irregularGridView.tag      = 1002;
    irregularGridView.adapters = array;
    [irregularGridView resetSize];
    [self.view addSubview:irregularGridView];
    
    return irregularGridView;
}


#pragma mark - IrregularGridCollectionViewDelegate

- (void)irregularGridCollectionView:(IrregularGridCollectionView *)irregularGridCollectionView
                    didSelectedCell:(CustomIrregularGridViewCell *)cell
                              event:(id)event {
    
    IrregularGridCellDataAdapter *theEvent = event;
    NSInteger index = theEvent.indexPath.row;
    XBPlantagModel *model = self.tags[index];
    NSLog(@"event - %@", model.name);
    [self initDataWithTagId:model.ID];
    if (irregularGridCollectionView.tag == 1002) { // 垂直
        
        for (UIView *subView in irregularGridCollectionView.collectionView.subviews) {
            
            if ([subView isKindOfClass:[BlueIrregularGridViewCell class]]) {
                BlueIrregularGridViewCell *blueCell = (BlueIrregularGridViewCell *)subView;
                
                if (cell.indexPath.row == blueCell.indexPath.row) {
                    blueCell.button.selected = YES;
                } else {
                    blueCell.button.selected = NO;
                }
            }
        }
    }
}

@end
