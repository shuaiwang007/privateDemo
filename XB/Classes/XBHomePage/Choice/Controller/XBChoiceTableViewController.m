//
//  XBChoiceTableViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/13.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBChoiceTableViewController.h"
#import "LinearCarouselView.h"   // H banner
#import "CycleScrollView.h"      // V banner
#import "XBVerticalBanner.h"     // V banner view
#import "XBPalnTableViewCell.h"
#import "XBGridCollectionView.h" // 水平滚动collectionView
#import "XBPlanHeapCollectionViewCell.h"
#import "XBTipsCollectionViewCell.h"
#import "XBStepCollectionViewCell.h"
#import "XBHeaderView.h"
#import "WaterfallLayoutController.h" // 脚印瀑布流
#import "XBHighStarViewController.h"
#import "XBChoiceModel.h"
#import "XBPlanPageListViewController.h"    // 全部计划
#import "XBPlanDetailPageViewController.h"  // 计划详情
#import "XBTipDetailTableViewController.h"  // 小步详情
#import "XBBaseH5ViewController.h"


static NSString *normalCell = @"normalCell";
static NSString *xbPlanTableViewCell = @"xbPlanTableViewCell";
static NSString *xbGridCollectionView = @"xbGridCollectionView";

@interface XBChoiceTableViewController () <iCarouselViewDelegate> {
    
    LinearCarouselView *_lineCarouseView;
    CycleScrollView *_mainScorllView;
}
@property (nonatomic, assign) CGFloat hotFootH;
@property (nonatomic, assign) NSInteger itemCount; // collection item 个数
@property (nonatomic, strong) XBChoiceModel *choiceModel;
@property (nonatomic, strong) WaterfallLayoutController *waterfallVC;

@end

@implementation XBChoiceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 1, Width, Height - XBNavigationBarHeight - XBTabBarHeight);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self registerCell];
    
    [self initData];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
//        if (self.itemCount > 0 && self.itemCount < 30) {
//            [self.tableView.mj_footer beginRefreshing];
            [self.waterfallVC loadMoreData];
//        }
    }];
}

- (void)initData
{
    [[ENetwork sharedNetwork] POST:XBApiIndexBest parameters:nil success:^(id responseObject) {
        ELog(@"XBApiIndexBest   %@   ", responseObject);
        
        self.choiceModel = [XBChoiceModel yy_modelWithJSON:responseObject[@"items"]];
        
        ELog(@"   %@   ", self.choiceModel);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self setHeaderView];
            [_lineCarouseView reloadData];
            [UIView animateWithDuration:0.5f animations:^{
                _lineCarouseView.alpha   = 1.f;
            }];
            
            [self.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)registerCell
{
    [self.tableView registerNib:[UINib nibWithNibName:@"XBPalnTableViewCell" bundle:nil] forCellReuseIdentifier:xbPlanTableViewCell];
    [self.tableView registerClass:[XBGridCollectionView class] forCellReuseIdentifier:xbGridCollectionView];
}

#pragma mark - 设置首页banner
- (void)setHeaderView
{
    
    CGFloat h = 0.0f;
    // 水平banner
    UIView *tableHeaderView = [[UIView alloc] init];
    
    if (self.choiceModel.best_banner.items.count > 0) {
        h = 150.f;
        _lineCarouseView          = [[LinearCarouselView alloc] initWithFrame:CGRectMake(0, 10, XBScreenWidth, h)];
        _lineCarouseView.delegate = self;
        _lineCarouseView.alpha    = 0.f;
        
        _lineCarouseView.adapters = [self iCarouselAdapterDataSource];
        [tableHeaderView addSubview:_lineCarouseView];
        h += 10;
    }
    
    if (self.choiceModel.best_Iamin.items.count > 0) {
        // 垂直banner
        NSMutableArray *viewsArray = [@[] mutableCopy];
        NSArray *arr = self.choiceModel.best_Iamin.items;
        for (int i = 0; i < arr.count; ++i) {
            
            XBBestIaminModel *model = arr[i];
            XBVerticalBanner *vBanner = [XBVerticalBanner verticalBanner];
            vBanner.frame = CGRectMake(0, 0, XBScreenWidth, 44);
            vBanner.desLab.text =  model.title;
            [viewsArray addObject:vBanner];
        }
        
        _mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, h + 20, XBScreenWidth, 44) animationDuration:2.5];
        __weak typeof(self) weakSelf = self;
        _mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            XBVerticalBanner *vBanner = viewsArray[pageIndex];
            XBBestIaminModel *model = weakSelf.choiceModel.best_Iamin.items[pageIndex];
            vBanner.progressValue = 1.0*[model.my_step_count integerValue]/[model.need_count integerValue];
            return vBanner;
        };
        
        _mainScorllView.totalPagesCount = ^NSInteger(void){
            return arr.count;
        };
        _mainScorllView.TapActionBlock = ^void(NSInteger pageIndex){
            XBBestIaminModel *model = weakSelf.choiceModel.best_Iamin.items[pageIndex];
            ELog(@"%@", model.title); // 进入计划分类列表页我加入的所有计划列表。
            XBPlanPageListViewController *VC = [[XBPlanPageListViewController alloc] init];
            VC.plan_cat_id = 0;
            [weakSelf.navigationController pushViewController:VC animated:YES];
            
        };
        [tableHeaderView addSubview:_mainScorllView];
        h = h + 54 + 6;
    }
    
    tableHeaderView.frame = CGRectMake(0, 0, XBScreenWidth, h + 10);
    self.tableView.tableHeaderView = tableHeaderView;
}

- (iCarouselAdapter *)iCarouselAdapterWithImageName:(NSString *)name index:(NSInteger)index {
    
    iCarouselAdapter *adapter = [iCarouselAdapter new];
    adapter.data              = name;
    adapter.type              = index;
    return adapter;
}

#pragma mark - 顶部banner 数据源
- (NSArray *)iCarouselAdapterDataSource {
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.choiceModel.best_banner.items.count; i++) {
        XBBestBannerModel *model = self.choiceModel.best_banner.items[i];
        
        iCarouselAdapter *adapter = [iCarouselAdapter new];
        adapter.data              = model.pic;
        adapter.type              = i;
        [arr addObject:adapter];
    }
    return arr;
}

#pragma mark - 顶部banner视图点击事件
- (void)iCarouselView:(iCarouselView *)iCarouselView didSelectCarouselAbsItemView:(iCarouselAbsItemView *)itemView adapter:(iCarouselAdapter *)adapter {
    XBBestBannerModel *model = self.choiceModel.best_banner.items[adapter.type];
    ELog(@"顶部banner视图点击事件   %@", model.scheme);
    XBBaseH5ViewController *VC = [[XBBaseH5ViewController alloc] init];
    VC.urlStr = model.scheme;
    [self.navigationController pushViewController:VC animated:YES];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.choiceModel.best_recommond_plans.items.count + 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row < self.choiceModel.best_recommond_plans.items.count) {
            // 为你推荐计划
            XBPalnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xbPlanTableViewCell forIndexPath:indexPath];
            NSArray *modelArr = self.choiceModel.best_recommond_plans.items;
            [cell setCellWithRecommondPLanModel:modelArr[indexPath.row]];
            return cell;
        } else {
            // 所有计划
            XBGridCollectionView *cell = [tableView dequeueReusableCellWithIdentifier:xbGridCollectionView forIndexPath:indexPath];
            
            NSArray *modelArr = self.choiceModel.best_plan_cats.items;
            
            [cell setCellWithModelArr:modelArr class:@"XBPlanHeapCollectionViewCell" itemSize:CGSizeMake(100, 150) cellHeight:170];
            
            cell.actionBlock = ^void (NSIndexPath *indexPath) {
                XBBestPlanCatsModel *model = modelArr[indexPath.row];
                ELog(@"点击全部计划   %@  %zd ", model.title, indexPath.row);
                XBPlanPageListViewController *VC = [[XBPlanPageListViewController alloc] init];
                
                [self.navigationController pushViewController:VC animated:YES];
            };
            
            return cell;
        }
    } else if (indexPath.section == 1) {
        // 小步专家团
        XBGridCollectionView *cell = [tableView dequeueReusableCellWithIdentifier:xbGridCollectionView forIndexPath:indexPath];
        
        NSArray *modelArr = self.choiceModel.best_planer.items; // , model, model, model, model
        
        [cell setCellWithModelArr:modelArr class:@"XBTipsCollectionViewCell" itemSize:CGSizeMake((Width - 50)/4, 100) cellHeight:120];
        cell.actionBlock = ^(NSIndexPath *indexPath) {
            XBBestPlanCatsModel *model = modelArr[indexPath.row];
            ELog(@"小步专家团   %@  %zd ", model.title, indexPath.row);
            XBHighStarViewController *VC = [[XBHighStarViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        };
        
        return cell;
    } else if (indexPath.section == 2) {
        // 最受欢迎一小步
        XBGridCollectionView *cell = [tableView dequeueReusableCellWithIdentifier:xbGridCollectionView forIndexPath:indexPath];
        NSArray *modelArr = self.choiceModel.best_recommond_tips.items; // , model, model, model, model
        
        [cell setCellWithModelArr:modelArr class:@"XBStepCollectionViewCell" itemSize:CGSizeMake(320, 80) cellHeight:280];
        cell.actionBlock = ^(NSIndexPath *indexPath) {
            XBBestRecommondTipsModel *model = modelArr[indexPath.row];
            ELog(@"最受欢迎一小步   %@  %zd ", model.title, indexPath.row);
            XBTipDetailTableViewController *VC = [[XBTipDetailTableViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        };
        
        return cell;
    } else {
        // 热门脚印
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        [cell addSubview:self.waterfallVC.view];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {           // 计划
        if (indexPath.row < self.choiceModel.best_recommond_plans.items.count) {
            XBBestRecommondPlansModel *model = self.choiceModel.best_recommond_plans.items[indexPath.row];
            XBPlanDetailPageViewController *VC = [[XBPlanDetailPageViewController alloc] init];
            VC.res_id = model.plan_res_id;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}


- (WaterfallLayoutController *)waterfallVC
{
    if (!_waterfallVC) {
        _waterfallVC = [[WaterfallLayoutController alloc] init];
        __weak typeof(self) weakSelf = self;
        _waterfallVC.itemCountBlock = ^(CGFloat H) {
//            weakSelf.itemCount = count;
            weakSelf.hotFootH = H;
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
            if (weakSelf.itemCount < 30) {
                [weakSelf.tableView.mj_footer endRefreshing];
            } else {
                [weakSelf.tableView.mj_footer setState:MJRefreshStateNoMoreData];
            }
        };
        [self addChildViewController:_waterfallVC];
        
    }
    return _waterfallVC;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] init];
        return view;
    } else {
        XBHeaderView *header = [XBHeaderView headerView];
        header.forwardStr = @"全部";
        
        NSString *title = @"";
        switch (section) {
            case 0:
                title = @"为你推荐计划";
                break;
            case 2:
                title = @"最受欢迎一小步";
                break;
            case 3:
                title = @"热门脚印";
                break;
            default:
                break;
        }
        header.titleLab.text = title;
        
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [[UIView alloc] init];
    return foot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row < self.choiceModel.best_recommond_plans.items.count) {
            return 85;
        } else {
            return 170;
        }
    } else if (indexPath.section == 1) {
        return 110;
    } else if (indexPath.section == 2) {
        return 280;
    } else {
//        CGFloat h = (self.itemCount/2 + self.itemCount%2)*(10 + 1.0*(Width - 40)/2 * (1.0 * 20 / 14)) - 10;
//        ELog(@"   %.f   ", h);
        
        
        return self.hotFootH;//h > 0 ? h : 0.01f; // (Width - 40) + 10 ;//
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 1) {
        return 40.f;
    } else {
        return 0.01f;
    }
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    ELog(@"   %f ", scrollView.contentSize.height - scrollView.contentOffset.y);
//    if (scrollView.contentSize.height - scrollView.contentOffset.y < 600) {
//        self.hotFootH += 300;
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
//    }
//}

@end
