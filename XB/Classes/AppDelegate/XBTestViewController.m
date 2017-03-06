//
//  XBTestViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/11.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBTestViewController.h"

#import "IrregularGridCollectionView.h"
#import "IrregularPictureGridCell.h"
#import "BlueIrregularGridViewCell.h"

#import "UIImage+RoundRectImage.h"

#import "Math.h"

#import "LinearCarouselView.h"


@interface XBTestViewController () <iCarouselViewDelegate, IrregularGridCollectionViewDelegate> {

    LinearCarouselView *_lineCarouseView;
}

@property (nonatomic, strong) NSArray *imageUrlStrArr;

@end

@implementation XBTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.tabBarItem.badgeValue = @"2";
    
    
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    bt.backgroundColor = [UIColor cyanColor];
    bt.imageView.layer.cornerRadius = 25;
    bt.imageView.layer.masksToBounds = YES;
    
    [bt setImage:[UIImage imageNamed:@"colors"] forState:UIControlStateNormal];
//    [self.view addSubview:bt];
//    [self setUpLineCarouseView];
    [self createDirectionHorizontalType];
    [self createDirectionVerticalType]; // 字体标签混排
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 动态设置tab头像
    ELog(@"self.tabBarItem.title   %@   ", self.tabBarItem.title);
    UIImage *clip = [UIImage imageNamed:@"colors"];
    CGFloat min = MIN(clip.size.width, clip.size.height);
    UIImage *centerImg = [UIImage createRoundedRectImage:clip size:CGSizeMake(min, min) radius:min/2];
    
    if (!self.tabBarItem.title) {
        self.tabBarItem.selectedImage = centerImg;
        
        for (UIView *tabBarButton in self.tabBarController.tabBar.subviews) {
            if ([tabBarButton isKindOfClass:[UIControl class]]) {
                [tabBarButton removeFromSuperview];
            }
        }
        
    }
}




#pragma mark - 设置滑动GridCell

- (void)createDirectionHorizontalType {
    
    CGFloat edgeInsetTop    = 10.f;
    CGFloat gridHeight      = 150;
    CGFloat edgeInsetBottom = 10.f;
    
    // Create dataSource.
//    NSArray *images = self.imageUrlStrArr;
    

//    NSArray *images = @[[UIImage imageNamed:@"an_1.jpg"],
//                        [UIImage imageNamed:@"an_1.jpg"],
//                        [UIImage imageNamed:@"an_1.jpg"],
//                        [UIImage imageNamed:@"an_1.jpg"],
//                        [UIImage imageNamed:@"an_1.jpg"],
//                        [UIImage imageNamed:@"an_1.jpg"],
//                        [UIImage imageNamed:@"an_1.jpg"],
//                        [UIImage imageNamed:@"an_1.jpg"]];
    
    NSArray *images = @[[UIImage imageNamed:@"an_1.jpg"],
                        [UIImage imageNamed:@"1.jpg"],
                        [UIImage imageNamed:@"an_2.jpg"],
                        [UIImage imageNamed:@"2.jpg"],
                        [UIImage imageNamed:@"an_3.jpg"],
                        [UIImage imageNamed:@"3.jpg"],
                        [UIImage imageNamed:@"an_4.jpg"],
                        [UIImage imageNamed:@"4.jpg"]];
    
    NSMutableArray *arrays = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [arrays addObject:[IrregularPictureGridCell dataAdapterWithData:image itemWidth:[Math resetFromSize:image.size withFixedHeight:150].width]];
    }];
    
    // Create IrregularGridCollectionView.
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(101, 150);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10); // 上 左 下 右
    
    IrregularGridCollectionView *irregularGridView;
    CGFloat height    = edgeInsetTop + gridHeight + edgeInsetBottom; // EdgeInsetTop + GridHeight + EdgeInsetBottom
    irregularGridView = [IrregularGridCollectionView irregularGridCollectionViewWithFrame:CGRectMake(0, 100, Width, height)
                                                                               flowLayout:flowLayout
                                                                                 delegate:self
                                                                            registerCells:@[gridViewCellClassType([IrregularPictureGridCell class], nil, NO)]
                                                                          scrollDirection:UICollectionViewScrollDirectionHorizontal
                                                                        contentEdgeInsets:UIEdgeInsetsMake(edgeInsetTop, 10, edgeInsetBottom, 10)
                                                                              lineSpacing:0.f
                                                                         interitemSpacing:10.f
                                                                               gridHeight:gridHeight];
    irregularGridView.tag      = 1001;
    irregularGridView.adapters = arrays;
    [self.view addSubview:irregularGridView];
    
    // Debug frame.
    if (/* DISABLES CODE */ (0)) {
        
        irregularGridView.layer.borderWidth = 0.5f;
        irregularGridView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.35f].CGColor;
    }
}

- (void)createDirectionVerticalType {
    
    // Create dataSource.
    NSMutableArray *array  = [NSMutableArray array];
    NSArray        *titles = @[@"YouXianMing",
                               @"Debug",
                               @"Create",
                               @"Xcode8.1",
                               @"NSMutableArray",
                               @"UIColor",
                               @"UIFont",
                               @"WaterFall",
                               @"IrregularGridCollectionView",
                               @"AvenirLight",
                               @"PS4"];
    
    for (int i = 0; i < titles.count; i++) {
        
        NSString *string = titles[i];
        
        CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}
                                           context:nil];
        
        CGFloat   value  = rect.size.width + 20.f;
        [array addObject:[BlueIrregularGridViewCell dataAdapterWithData:string type:0 itemWidth:value]];
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
    
    // Debug frame.
//    if (/* DISABLES CODE */ (1)) {
//        
//        irregularGridView.layer.borderWidth = 0.5f;
//        irregularGridView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.35f].CGColor;
//    }
}

#pragma mark - IrregularGridCollectionViewDelegate

- (void)irregularGridCollectionView:(IrregularGridCollectionView *)irregularGridCollectionView
                    didSelectedCell:(CustomIrregularGridViewCell *)cell
                              event:(id)event {
    
    IrregularGridCellDataAdapter *theEvent = event;
    NSLog(@"event -> %@", theEvent.indexPath);
    
    if (irregularGridCollectionView.tag == 1002) { // 垂直
        
        cell.backgroundColor = XBDefaultMainColor;
        
        
        BlueIrregularGridViewCell *blueCell = (BlueIrregularGridViewCell *)cell;
        
        ELog(@"cell   %zd   %zd", cell.indexPath.row, blueCell.button.selected);
        
        blueCell.button.selected = !blueCell.button.selected;
        
        
        
//        // 更新数据的动画
//        [irregularGridCollectionView.collectionView performBatchUpdates:^{
//            
//            [irregularGridCollectionView.adapters removeObjectAtIndex:cell.indexPath.row];
//            [irregularGridCollectionView.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.indexPath.row inSection:0]]];
//            
//        } completion:^(BOOL finished) {
//            
//            // 重置数据
//            [irregularGridCollectionView.collectionView reloadData];
//            [UIView animateWithDuration:0.35f animations:^{
//                
//                [irregularGridCollectionView resetSize];
//                
//                if (irregularGridCollectionView.adapters.count <= 0) {
//                    
//                    irregularGridCollectionView.alpha = 0.f;
//                }
//            }];
//        }];
    }
}




#pragma mark - 设置首页banner
- (void)setUpLineCarouseView
{
    _lineCarouseView          = [[LinearCarouselView alloc] initWithFrame:CGRectMake(0, 0, XBScreenWidth, 150)];
    _lineCarouseView.delegate = self;
    _lineCarouseView.alpha    = 0.f;
    _lineCarouseView.adapters = @[[self iCarouselAdapterWithImageName:self.imageUrlStrArr[0] index:0],
                                  [self iCarouselAdapterWithImageName:self.imageUrlStrArr[1] index:1],
                                  [self iCarouselAdapterWithImageName:self.imageUrlStrArr[2] index:2],
                                  [self iCarouselAdapterWithImageName:self.imageUrlStrArr[3] index:3],
                                  [self iCarouselAdapterWithImageName:self.imageUrlStrArr[4] index:4]];
    _lineCarouseView.centerY  = self.view.height * 0.25 + 6;
    [self.view addSubview:_lineCarouseView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_lineCarouseView reloadData];
    [UIView animateWithDuration:0.5f animations:^{
        
        _lineCarouseView.alpha   = 1.f;
    }];
}

- (iCarouselAdapter *)iCarouselAdapterWithImageName:(NSString *)name index:(NSInteger)index {
    
    iCarouselAdapter *adapter = [iCarouselAdapter new];
    adapter.data              = name;
    adapter.type              = index;
    
    
    return adapter;
}

- (void)iCarouselView:(iCarouselView *)iCarouselView didSelectCarouselAbsItemView:(iCarouselAbsItemView *)itemView adapter:(iCarouselAdapter *)adapter {
    ELog(@"   %ld  %@ ", (long)adapter.type, itemView);
}

- (NSArray *)imageUrlStrArr
{
    if (!_imageUrlStrArr) {
        _imageUrlStrArr = @[@"http://mmbiz.qpic.cn/mmbiz_gif/0ydq3X9ZuYOTNPv1hib73PUF0FkL6klTgBLRYNDTHte4DR6FwUquUpl6kDiaiaYIcmbooTHx9ibYoPoLQicvRszyJZw/0?wx_fmt=gif&wxfrom=5&wx_lazy=1", @"http://mmbiz.qpic.cn/mmbiz_gif/0ydq3X9ZuYOTNPv1hib73PUF0FkL6klTgmqjkXHatMRODHLuBbcAUnkVbrGEZYbARCEwXmSWe0KCzYOqnNJUjwA/0?wx_fmt=gif&wxfrom=5&wx_lazy=1", @"http://mmbiz.qpic.cn/mmbiz_gif/0ydq3X9ZuYOTNPv1hib73PUF0FkL6klTgBLRYNDTHte4DR6FwUquUpl6kDiaiaYIcmbooTHx9ibYoPoLQicvRszyJZw/0?wx_fmt=gif&wxfrom=5&wx_lazy=1", @"http://mmbiz.qpic.cn/mmbiz_gif/0ydq3X9ZuYOTNPv1hib73PUF0FkL6klTgmqjkXHatMRODHLuBbcAUnkVbrGEZYbARCEwXmSWe0KCzYOqnNJUjwA/0?wx_fmt=gif&wxfrom=5&wx_lazy=1", @"http://mmbiz.qpic.cn/mmbiz_gif/0ydq3X9ZuYOTNPv1hib73PUF0FkL6klTgmqjkXHatMRODHLuBbcAUnkVbrGEZYbARCEwXmSWe0KCzYOqnNJUjwA/0?wx_fmt=gif&wxfrom=5&wx_lazy=1"];
        
    }
    return _imageUrlStrArr;
}

@end
