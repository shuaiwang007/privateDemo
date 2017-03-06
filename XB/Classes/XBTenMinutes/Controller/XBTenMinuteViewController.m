//
//  XBTenMinuteViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/18.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBTenMinuteViewController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

@interface XBTenMinuteViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

@property (weak, nonatomic) IBOutlet NewPagedFlowView *pageFlowView;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation XBTenMinuteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerTitle = @"10分钟";
    [self.eNaviBar.rightBtn setTitle:@"测试" forState:UIControlStateNormal];
    
    for (int index = 0; index < 5; index++) {
        UIImage *image = [UIImage imageNamed:@"1"];//[UIImage imageNamed:[NSString stringWithFormat:@"%d", index]];
        [self.imageArray addObject:image];
    }
    
    [self setupUI];
}

- (void)rightBarButtonClick:(UIButton *)button
{
    UIImage *image = [UIImage imageNamed:@"an_1"];
    
    NSData *imageData;
    //    if (UIImagePNGRepresentation(image)) {
    //        imageData = UIImagePNGRepresentation(image);
    //    }else {
    imageData = UIImageJPEGRepresentation(image, 1.0);
    //    }
    
    // "plan_res_id" = p58b1415b8f50079;
    // "step_res_id" = 2ewf;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"1" forKey:@"feeling"];
    [dict setObject:@"p58b1415b8f50079" forKey:@"plan_res_id"];
    [dict setObject:@"t58b1418521dcf229" forKey:@"tip_res_id"];
    [dict setObject:@[] forKey:@"pic_ids"];
    [dict setObject:@[] forKey:@"video_id"];
    [dict setObject:@"tett" forKey:@"text"];
    [dict setObject:@1 forKey:@"visible_value"];
    
    [[ENetwork sharedNetwork] POSTWithUrlStr:XBApiFileUpload parameters:dict fileData:imageData progress:^(NSProgress *progress) {
        ELog(@"progress   %@   ", progress);
        
    } success:^(NSDictionary *responseObject) {
        
        ELog(@"XBApiFileUpload  %@   ", responseObject);
    } failure:^(NSError *error) {
        ELog(@"   %@   ", error);
    }];
}

#pragma mark --滚动到指定的页数
- (void)gotoPage {
    
    //产生跳转的随机数
    int value = arc4random() % self.imageArray.count;
    NSLog(@"value~~%d",value);
    
    [self.pageFlowView scrollToPage:value];
}

- (void)setupUI {
    
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:self.pageFlowView.frame];
    pageFlowView.backgroundColor = XBDefaultBackGroundColor;
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.minimumPageScale = 0.85;
    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.isOpenAutoScroll = YES;
    //初始化pageControl
    //    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 24 - 8, Width, 8)];
    //    pageFlowView.pageControl = pageControl;
    //    [pageFlowView addSubview:pageControl];
    
    //    [self.view addSubview:pageFlowView];
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [pageFlowView reloadData];
    [bottomScrollView addSubview:pageFlowView];
    [self.view addSubview:bottomScrollView];
    
    [bottomScrollView addSubview:pageFlowView];
    
    self.pageFlowView = pageFlowView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Width - 84, self.pageFlowView.height);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Width - 84, self.pageFlowView.height)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    //在这里下载网络图片
    //[bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

//- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
//    
//    NSLog(@"TestViewController 滚动到了第%ld页",pageNumber);
//}

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

#pragma mark --旋转屏幕改变newPageFlowView大小之后实现该方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [coordinator animateAlongsideTransition:^(id context) { [self.pageFlowView reloadData]; } completion:NULL];
    }
}

- (void)dealloc {
    
    /****************************
     在dealloc或者返回按钮里停止定时器
     ****************************/
    
    [self.pageFlowView stopTimer];
}

@end
