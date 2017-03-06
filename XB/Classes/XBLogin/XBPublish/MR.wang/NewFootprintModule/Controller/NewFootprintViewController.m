//
//  NewFootprintViewController.m
//  whqFor
//
//  Created by Mr.Wang on 2017/2/26.
//  Copyright © 2017年 Mr.wang. All rights reserved.
//

#import "NewFootprintViewController.h"
#import "ImagePickerChooseView.h"
#import "PhotosViewController.h"
#import "TZImagePickerController.h"
#import "EditPhotosViewController.h"
#import "OEPopVideoController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "XBRelateTipsPageTabViewController.h"
#import "ShowImageViewController.h"

@interface NewFootprintViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, TZImagePickerControllerDelegate, OEPopVideoControllerDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
}

@property (nonatomic, strong) UITextView *reportStateTextView;
@property (nonatomic, strong) UILabel *pLabel;
@property (nonatomic, strong) UIButton *addPictureButton;
@property (nonatomic, strong) ImagePickerChooseView *IPCView;
@property (nonatomic, strong) AGImagePickerController *imagePicker;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSString *plan_res_id;
@property (nonatomic, copy) NSString *tip_id;
@property (nonatomic, copy) NSString *tipTitle;
@property (nonatomic, copy) NSString *rangeTitle;

@end

@implementation NewFootprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerTitle = @"新脚印";
    
    [self setupNavBar];
    [self.view addSubview:self.tableView];
    [self initHeaderView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reveiveImageArrNoti:) name:@"imageArrNoti" object:nil];
}

#pragma mark - customAction
- (void)setupNavBar {
    [self.eNaviBar.rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    
}

- (void)rightBarButtonClick:(UIButton *)button {
     ELog(@"发布新脚印===所有发布的图片数组为====%@", self.imagePickerArray);
}

-(void)reveiveImageArrNoti:(NSNotification *)noti {
    self.imagePickerArray = noti.userInfo[@"imageArr"];
    self.phAssetImageArr = noti.userInfo[@"phAssetImageArr"];
    [self.IPCView.tapView removeFromSuperview];
    //self.tapView = nil;
    [UIView animateWithDuration:0.25f animations:^{
        self.IPCView.frame = CGRectMake(0, screenHeight - 64, screenWidth, IPCViewHeight);
    } completion:^(BOOL finished) {
        [self.IPCView removeFromSuperview];
    }];
    [self initHeaderView];
}

-(void)initHeaderView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectZero];
    headView.backgroundColor = [UIColor whiteColor];
    UITextView *reportStateTextView = [[UITextView alloc]initWithFrame:CGRectMake(padding, padding, screenWidth - 2*padding, textViewHeight)];
    reportStateTextView.text = self.reportStateTextView.text;  //防止用户已经输入了文字状态
    reportStateTextView.returnKeyType = UIReturnKeyDone;
    reportStateTextView.font = [UIFont systemFontOfSize:15];
    self.reportStateTextView = reportStateTextView;
    self.reportStateTextView.delegate = self;
    [headView addSubview:reportStateTextView];
    
    UILabel *pLabel = [[UILabel alloc]initWithFrame:CGRectMake(padding+5, 2 * padding, screenWidth, 10)];
    pLabel.text = @"记录点什么~";
    pLabel.hidden = [self.reportStateTextView.text length];
    pLabel.font = [UIFont systemFontOfSize:15];
    pLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
    self.pLabel = pLabel;
    [headView addSubview:pLabel];
    
    NSInteger imageCount = [self.imagePickerArray count];
    for (NSInteger i = 0; i < imageCount; i++) {
        UIImageView *pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + (i%4)*(pictureHW+padding), CGRectGetMaxY(reportStateTextView.frame) + padding +(i/4)*(pictureHW+padding), pictureHW, pictureHW)];
        //用作放大图片
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [pictureImageView addGestureRecognizer:tap];
        
        //添加删除按钮
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
        dele.frame = CGRectMake(pictureHW - deleImageWH + 5, -10, deleImageWH, deleImageWH);
        [dele setImage:[UIImage imageNamed:@"deletePhoto"] forState:UIControlStateNormal];
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        [pictureImageView addSubview:dele];
        
        pictureImageView.tag = imageTag + i;
        pictureImageView.userInteractionEnabled = YES;
        pictureImageView.image = self.imagePickerArray[i];
        [headView addSubview:pictureImageView];
    }
    if (imageCount < MaxImageCount) {
        UIButton *addPictureButton = [[UIButton alloc]initWithFrame:CGRectMake(padding + (imageCount%4)*(pictureHW+padding), CGRectGetMaxY(reportStateTextView.frame) + padding +(imageCount/4)*(pictureHW+padding), pictureHW, pictureHW)];
        [addPictureButton setBackgroundImage:[UIImage imageNamed:@"addPictures"] forState:UIControlStateNormal];
        [addPictureButton addTarget:self action:@selector(addPicture) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:addPictureButton];
        self.addPictureButton = addPictureButton;
    }
    
    NSInteger headViewHeight = 120 + (10 + pictureHW)*([self.imagePickerArray count]/4 + 1);
    headView.frame = CGRectMake(0, 0, screenWidth, headViewHeight);
    self.tableView.tableHeaderView = headView;
}

//点击图片预览
-(void)tapImageView:(UITapGestureRecognizer *)tap {
    self.navigationController.navigationBarHidden = YES;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ShowImageViewController" bundle:[NSBundle mainBundle]];
    ShowImageViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ShowImage"];
    vc.clickTag = tap.view.tag;
    vc.imageViews = self.phAssetImageArr;;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - addPicture
-(void)addPicture
{
    if ([self.reportStateTextView isFirstResponder]) {
        [self.reportStateTextView resignFirstResponder];
    }
    self.tableView.scrollEnabled = NO;
    [self initImagePickerChooseView];
}

-(void)keyboardDismiss:(UITapGestureRecognizer *)tap {
    [self.reportStateTextView resignFirstResponder];
}

// 删除图片
-(void)deletePic:(UIButton *)btn
{
    if ([(UIButton *)btn.superview isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)(UIButton *)btn.superview;
        [self.imagePickerArray removeObjectAtIndex:(imageView.tag - imageTag)];
        [imageView removeFromSuperview];
    }
    [self initHeaderView];
}

#pragma mark - delegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    
    
    // 1.打印图片名字
    [self printAssetsName:assets];
    UIImage *image = [UIImage imageNamed:@"takePicture"];
    
    
    EditPhotosViewController *editPhotosVC = [[EditPhotosViewController alloc] initWithImage:image];
    editPhotosVC.assets = assets;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editPhotosVC];
//    [self.navigationController pushViewController:editPhotosVC animated:YES];
    if (self.navigationController) {
        [self.navigationController pushViewController:editPhotosVC animated:YES];
    } else {
        [self presentViewController:nav animated:YES completion:nil];
    }
}

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
        ELog(@"图片===============--:%@",assets);

}

//push到选择图片的控制器
- (void)pushImagePickerController {

    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.naviBgColor = [UIColor whiteColor];
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    imagePickerVc.previewBtnTitleStr = @"";

    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        ELog(@"   %@   ", photos);
        [self.imagePickerArray addObject:photos];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)initImagePickerChooseView {
    ImagePickerChooseView *IPCView = [[ImagePickerChooseView alloc] initWithFrame:CGRectMake(0, screenHeight - 64, screenWidth, IPCViewHeight) andAboveView:self.view];
    [self.view addSubview:IPCView];
    self.IPCView = IPCView;
    //去拍小视频
    IPCView.smallVideoBlock = ^(){
        OEPopVideoController *videoController = [[OEPopVideoController alloc] init];
        videoController.videoMaxTime = smallVideoTime;
        videoController.delegate = self;
        [videoController presentPopupControllerAnimated:YES];
        
    };
    [IPCView setImagePickerBlock:^{
        //去选照片
        [self pushImagePickerController];
        
    }];
    [UIView animateWithDuration:0.25f animations:^{
        IPCView.frame = CGRectMake(0, screenHeight - IPCViewHeight, screenWidth, IPCViewHeight);
    } completion:^(BOOL finished) {
    }];
    
    [self.IPCView addImagePickerChooseView];
}


#pragma mark - UIGesture Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark - Text View Delegate
-(void)textViewDidChange:(UITextView *)textView {
    self.pLabel.hidden = [textView.text length];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text]) {
        if ([self.reportStateTextView.text length]) {
            [self.reportStateTextView resignFirstResponder];
        }else {
            return NO;
        }
    }
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *iden = @"reportCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"相关小步";
        cell.detailTextLabel.text = @"选择关联小步";
    }else {
        cell.textLabel.text = @"谁可以看见";
        cell.detailTextLabel.text = @"选择可见范围";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XBRelateTipsPageTabViewController *VC = [[XBRelateTipsPageTabViewController alloc] init];
        VC.callBack = ^(NSString *plan_res_id, NSString *tip_id, NSString *title) {
            ELog(@"plan_res_id   %@   %@  %@", plan_res_id, tip_id, title);
            self.plan_res_id = plan_res_id;
            self.tip_id = tip_id;
            self.tipTitle = title;
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = title;
        };
        [self presentViewController:VC animated:YES completion:nil];
    } else {
        [self seeRange];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - OEPopVideoControllerDelegate
-(void)popVideoControllerDidSave:(NSString *)url{
    [self savePhoneLibrary:url];
}

-(void)popVideoControllerWillOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
}

-(void)savePhoneLibrary:(NSString *)url{
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    NSURL *movieURL = [NSURL fileURLWithPath:url];
    
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url)) {
        [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error) {
            
             if (error) {
                 [SVProgressHUD showErrorWithStatus:@"error"];
             } else {
                 [SVProgressHUD showSuccessWithStatus:@"success"];
             }
         }];
    }
}

#pragma mark - 设置可见范围
- (void)seeRange
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *common = [UIAlertAction actionWithTitle:@"小步用户可见" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.rangeTitle = @"小步用户可见";
    }];
    UIAlertAction *friend = [UIAlertAction actionWithTitle:@"好友(互相关注)可见" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.rangeTitle = @"好友(互相关注)可见";
    }];
    UIAlertAction *family = [UIAlertAction actionWithTitle:@"亲人可见" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.rangeTitle = @"亲人可见";
    }];
    UIAlertAction *own = [UIAlertAction actionWithTitle:@"自己可见" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.rangeTitle = @"自己可见";
    }];
    
    [common setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [friend setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [family setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [own setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alert addAction:common];
    [alert addAction:friend];
    [alert addAction:family];
    [alert addAction:own];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setRangeTitle:(NSString *)rangeTitle
{
    _rangeTitle = rangeTitle;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.detailTextLabel.text = rangeTitle;
}

-(NSMutableArray *)imagePickerArray
{
    if (!_imagePickerArray) {
        _imagePickerArray = [[NSMutableArray alloc]init];
    }
    return _imagePickerArray;
}

- (NSMutableArray *)phAssetImageArr {
    if (!_phAssetImageArr) {
        _phAssetImageArr = [NSMutableArray array];
    }
    return _phAssetImageArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
