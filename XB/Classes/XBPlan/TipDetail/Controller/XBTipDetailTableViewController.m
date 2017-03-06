//
//  XBTipDetailTableViewController.m
//  XB
//
//  Created by 王化强 on 2017/2/27.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBTipDetailTableViewController.h"
#import "XBTipDetailModel.h"
#import "XBTipDetailTabHeaderView.h"
#import "XBFeedStepModel.h"
#import "XBPlanTableViewCell.h"
#import "XBFootPrintTableViewCell.h"
#import "XBPlanCreatorTableViewCell.h"
#import "XBStepDetailTableViewController.h"
#import "XBCommenFootView.h"

static NSString *planListCell = @"planListCell";
static NSString *footPrintTabcell = @"footPrintTabcell";
static NSString *planCreatorCell = @"planCreatorCell";

@interface XBTipDetailTableViewController () <UIWebViewDelegate>

@property (nonatomic, strong) XBTipDetailModel *model;
@property (nonatomic, strong) NSNumber *allStepCount;
@property (nonatomic, strong) XBTipDetailTabHeaderView *tabHeaderView;
@property (nonatomic, strong) NSArray *stepModelArr;
@property (nonatomic, assign) BOOL showAllPlan;

@end

@implementation XBTipDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerTitle = @"某个小步页";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XBPlanTableViewCell" bundle:nil] forCellReuseIdentifier:planListCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBFootPrintTableViewCell" bundle:nil] forCellReuseIdentifier:footPrintTabcell];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBPlanCreatorTableViewCell" bundle:nil] forCellReuseIdentifier:planCreatorCell];
    
    
    _tabHeaderView = [XBTipDetailTabHeaderView tabHeaderView];
    _tabHeaderView.webView.delegate = self;
    _tabHeaderView.webView.scrollView.bounces = NO;
    _tabHeaderView.webView.scrollView.showsHorizontalScrollIndicator = NO;
    _tabHeaderView.webView.scrollView.scrollEnabled = NO;
    [_tabHeaderView.webView sizeToFit];
    
    [self initData];
}

- (void)initData
{
    if (!self.res_id) {
        return;
    }
    [[ENetwork sharedNetwork] POST:XBApiTipDetail parameters:@{@"res_id":self.res_id} success:^(id responseObject) {
        
//        ELog(@"XBApiTipDetail   %@   ", responseObject);
        self.model = [XBTipDetailModel yy_modelWithJSON:[responseObject objectForKey:@"content"]];
        
        NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", self.model.tip_info.content];
        [_tabHeaderView.webView loadHTMLString:htmlcontent baseURL:nil];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ELog(@"   %@   ", error);
    }];
}

- (void)loadStep
{
    if (!self.res_id) {
        return;
    }
    
    [[ENetwork sharedNetwork] POST:XBApiStepLists parameters:@{@"tip_res_id":self.res_id, @"pn":@1} success:^(id responseObject) {
        ELog(@"XBApiStepLists   %@   ", responseObject);
        
        self.stepModelArr = [NSArray yy_modelArrayWithClass:[XBFeedStepModel class] json:responseObject[@"items"]];
        self.allStepCount = [responseObject objectForKey:@"all_count"];
        [self addBottomView];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ELog(@"   %@   ", error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.model.from.count <= 2) {
            return self.model.from.count;
        } else {
            if (self.showAllPlan) {
                return self.model.from.count;
            } else {
                return 2;
            }
        }
    } else if (section == 1) {
        return 1;
    } else {
        return self.stepModelArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        XBPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:planListCell forIndexPath:indexPath];
        XBPlanListModel *model = self.model.from[indexPath.row];
        [cell setCellWithModel:model progressViewHidden:YES];
        
        return cell;
    } else if (indexPath.section == 1) {
        XBPlanCreatorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:planCreatorCell forIndexPath:indexPath];
        XBTipDetailUserInfoModel *model = self.model.user_info;
        [cell setCellWithModel:model];
        return cell;
    } else {
        
        XBFootPrintTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footPrintTabcell forIndexPath:indexPath];
        XBFeedStepModel *model = self.stepModelArr[indexPath.row];
        [cell setCellWithModel:model className:@"XBFootCustomIrregularGridViewCell" footType:FootTypeAttention];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        XBStepDetailTableViewController *VC = [[XBStepDetailTableViewController alloc] init];
        XBFeedStepModel *model = self.stepModelArr[indexPath.row];
        VC.res_id = model.step_res_id;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, Width - 30, 30)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:15];
    if (self.model.from.count > 0 && section == 0) {
        lab.text = @"这一小步来自一下计划";
    } else if (section == 1) {
        lab.text = @"计划发起人";
    } else if (section == 2 && self.stepModelArr.count > 0) {
        lab.text = [NSString stringWithFormat:@"这1小步的脚印（%@）", self.allStepCount];
    }
    [view addSubview:lab];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    if (section == 0 && self.model.from.count > 2) {
        UIButton *morePlanBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
        morePlanBt.centerX = Width/2;
        morePlanBt.backgroundColor = [UIColor cyanColor];
        [morePlanBt addTarget:self action:@selector(morePlanAction:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:morePlanBt];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, Width, 10)];
        [footView addSubview:lineView];
    }
    return footView;
}

- (void)morePlanAction:(UIButton *)bt
{
    _showAllPlan = !_showAllPlan;
    if (_showAllPlan) {
        [bt setTitle:@"打开" forState:UIControlStateNormal];
    } else {
        [bt setTitle:@"关闭" forState:UIControlStateNormal];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 85.f;
    } else if (indexPath.section == 1) {
        return 80.f;
    } else {
        return [self configStepCellHeightWithModel:self.stepModelArr[indexPath.row]];
    }
}

#pragma mark - 计算脚印Cell高度
- (CGFloat)configStepCellHeightWithModel:(XBFeedStepModel *)model
{
    CGFloat h = 60.0f; // 关注的cell用户信息头部
    if (model.pics.count == 1 || model.video) {
#warning 实际已宽高比为准
        h += 260.f;
    } else if (model.pics.count) {
        h += 190.f;
    }
    
    NSString *str = [NSString stringWithFormat:@"@%@%@", model.from.from, model.text];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12.f]};
    CGSize size =  [str boundingRectWithSize:CGSizeMake(Width - 20, 60) options:NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    h = h + size.height + 55.f;
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ((section == 0 && self.model.from.count > 0) || section == 1 || (section == 2 && self.stepModelArr.count > 0)) {
        return 40.f;
    } else {
        return 10.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 && self.model.from.count > 2) {
        return 50.f;
    } else {
        return 10.f;
    }
}

- (void)addBottomView
{
    self.tableView.frame = CGRectMake(0, 64, Width, self.view.height - 50 - 64);
    XBCommenFootView *bottomView = [XBCommenFootView commenFootView];
    bottomView.frame = CGRectMake(0, Height - 50, Width, 50);
    
    bottomView.addFootBlock = ^{
        ELog(@"   加脚印   ");
    };
    
    bottomView.shareBlock = ^{
        ELog(@"   分享   ");
    };
    
    bottomView.commentBlock = ^{
        ELog(@"   点赞   ");
        
    };
    [self.view addSubview:bottomView];
}

#pragma mark - webView相关
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.clientHeight"];
    float clientheight = [clientheight_str floatValue];
    //设置到WebView上
    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, clientheight);
    //获取WebView最佳尺寸（点）
    CGSize frame = [webView sizeThatFits:webView.frame.size];
    
    // 图片自适应
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    
    //获取内容实际高度（像素）
    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').clientHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
    float height = [height_str floatValue];
    //内容实际高度（像素）* 点和像素的比
    height = height * frame.height / clientheight;
    //再次设置WebView高度（点）
    ELog(@"webViewH   %.f  ", height);
    _tabHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, height + 110);
//    [self.tableView beginUpdates];
    self.tableView.tableHeaderView = _tabHeaderView;
//    [self.tableView endUpdates];
    
    [self loadStep];
}


@end
