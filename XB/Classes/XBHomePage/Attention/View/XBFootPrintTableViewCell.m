//
//  XBFootPrintTableViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/21.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBFootPrintTableViewCell.h"
#import "IrregularGridCollectionView.h"
#import "KSPhotoBrowser.h"
#import <MPMoviePlayerController+XCDOverlayView.h>

@interface XBFootPrintTableViewCell () <IrregularGridCollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *userImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *topUserNameLab;
@property (weak, nonatomic) IBOutlet UILabel *bottomKidNameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerHConstraint;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIButton *likeCountBt;
@property (weak, nonatomic) IBOutlet UIButton *commentCountBt;
@property (weak, nonatomic) IBOutlet UIButton *focusBt;


@property (nonatomic, strong) XBFeedStepModel *model;
@property (nonatomic, strong) UIView *overlayView_xcd;

@property (nonatomic, strong) IrregularGridCollectionView *irregularGridView;

@end

@implementation XBFootPrintTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.focusBt.hidden = YES;
    self.backView.layer.cornerRadius = 5;
}

- (void)setCellWithModel:(XBFeedStepModel *)model
               className:(NSString *)className
                footType:(FootType)footType
{
    self.model = model;
    [self setCellWithType:footType];
    
    if (!className) {
        self.centerHConstraint.constant = 0.01f;
    } else if (model.pics.count > 1) {
        self.centerHConstraint.constant = 190.f;
    } else if (model.pics.count == 1 || model.video){
        self.centerHConstraint.constant = 260.f;
    } else {
        self.centerHConstraint.constant = 0.f;
    }
    
    if (self.irregularGridView || (model.pics.count < 1 && !model.video)) {
        return;
        ELog(@"   ===irregularGridView===   ");
    }
    
    NSMutableArray *arrays = [NSMutableArray array];
    Class class = NSClassFromString(className);
    
    if (model.video) {
        [arrays addObject:[class dataAdapterWithData:model.video.video_cover itemWidth:Width - 20]];
    } else {
        [model.pics enumerateObjectsUsingBlock:^(id data, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat w = 0.f;
            if (model.pics.count == 1) {
                w = Width - 20;
            } else {
                w = 150;
            }
            XBFootPrintPic *pic = data;
            [arrays addObject:[class dataAdapterWithData:pic.url itemWidth:w]];
        }];
    }
    
    // Create IrregularGridCollectionView.
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 1, 0, 1);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    
    self.irregularGridView = [IrregularGridCollectionView irregularGridCollectionViewWithFrame:CGRectMake(0, self.topHConstraint.constant, Width - 20, self.centerHConstraint.constant)
                                                                                    flowLayout:flowLayout
                                                                                      delegate:self
                                                                                 registerCells:@[gridViewCellClassType([class class], nil, YES)]
                                                                               scrollDirection:UICollectionViewScrollDirectionHorizontal
                                                                             contentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                                                                                   lineSpacing:0.f
                                                                              interitemSpacing:5.f
                                                                                    gridHeight:self.centerHConstraint.constant];
    self.irregularGridView.adapters = arrays;
    
    [self.backView addSubview:self.irregularGridView];
    
    
    [self setCellWithModel:model];
}

- (void)irregularGridCollectionView:(IrregularGridCollectionView *)irregularGridCollectionView didSelectedCell:(CustomIrregularGridViewCell *)cell event:(id)event
{
    if (self.model.video) {
        // 播放视频
        [self showVideoWithCellFrame:cell.frame];
    } else {
        // 图片方法展示
        [self showPhoto];
    }
    
    
    ELog(@"   %@   ", cell.indexPath);
}

#pragma mark - 展示图片
- (void)showPhoto
{
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < self.model.pics.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        XBFootPrintPic *pic = self.model.pics[i];
        KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView imageUrl:[NSURL URLWithString:pic.url]];
        [items addObject:item];
    }
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:0];
    [browser showFromViewController:[XBCommonTool currentViewController]];
}

- (void)showVideoWithCellFrame:(CGRect)frame
{
//    if (self.player) {
//        [self.player pause];
//        self.player = nil;
//        return;
//    }
//    
//    if (!self.player) {
//        NSString *videoStr = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
//        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:videoStr]];
//        //初始化player对象
//        self.player = [[AVPlayer alloc] initWithPlayerItem:item];
//    }
//    //设置播放页面
//    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    //设置播放页面的大小
//    CGRect rect = [self convertRect:frame fromView:self.superview.superview];
//    layer.frame = CGRectMake(rect.origin.x + 10, 60, rect.size.width, rect.size.height);
//    //设置播放窗口和当前视图之间的比例显示内容
//    layer.videoGravity = AVLayerVideoGravityResizeAspect;
//    //添加播放视图到self.view
//    [self.layer addSublayer:layer];
//    //设置播放的默认音量值
//    self.player.volume = 1.0f;
//    [self.player play];
    
        NSString *videoStr = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
        MPMoviePlayerViewController *moviePlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:videoStr]];
        [[XBCommonTool currentViewController] presentMoviePlayerViewControllerAnimated:moviePlayerViewController];
        UIView *overlayView = [UIView new];
        // Add subviews to overlayView
        moviePlayerViewController.moviePlayer.overlayView_xcd = overlayView;
}

- (void)setCellWithModel:(XBFeedStepModel *)model
{
    [self.userImgV sd_setImageWithURL:[NSURL URLWithString:model.recorder_info.user_pic]];
    self.userNameLab.text = model.recorder_info.user_name;
    self.topUserNameLab.text = model.recorder_info.user_name;
    self.bottomKidNameLab.text = [NSString stringWithFormat:@"%@  来自%@", model.baby_info.baby_name, model.recorder_info.relation];
    #warning 小步页没有来自
    NSString *des = [NSString stringWithFormat:@"@%@%@", model.from.from, model.text];
    self.desLab.text = des;
    [self.likeCountBt setTitle:model.like_count forState:UIControlStateNormal];
    [self.commentCountBt setTitle:model.comment_count forState:UIControlStateNormal];
}

- (void)setCellWithType:(FootType)footType
{
    if (footType == FootTypeAttention) {
        self.timeLab.hidden = YES;
        self.topUserNameLab.hidden = YES;
        self.bottomKidNameLab.hidden = YES;
        self.topHConstraint.constant = 60;
    } else if (footType == FootTypeFootPrientDetail) {
        self.userNameLab.hidden = YES;
        self.timeLab.hidden = YES;
        self.topHConstraint.constant = 60;
        self.focusBt.hidden = NO;
    } else {
        self.topUserNameLab.hidden = YES;
        self.bottomKidNameLab.hidden = YES;
        self.topHConstraint.constant = 45;
    }
}

- (IBAction)shareAction:(UIButton *)sender {
    ELog(@"   分享   ");
}
- (IBAction)likeAction:(UIButton *)sender {
    ELog(@"   喜欢   ");
}
- (IBAction)commentAction:(UIButton *)sender {
    ELog(@"   评论   ");
}

- (IBAction)focusAction:(UIButton *)sender {
    ELog(@"   关注   ");
}


- (void)prepareForReuse
{
    [super prepareForReuse];
    ELog(@"  =================== pause   ");
    [self.player pause];
    self.player = nil;
    self.focusBt.hidden = YES;
}



@end
