//
//  OEPopVideoController.m
//  whqFor
//
//  Created by Mr.Wang on 2017/3/1.
//  Copyright © 2017年 Mr.wang. All rights reserved.
//

#import "OEPopVideoController.h"
#import <objc/runtime.h>
#import "ShootVideoBottomView.h"


@interface OEPopVideoController()<ShootVideoBottomViewDelegate,GPUImageVideoCameraDelegate>

/** 视频录像*/
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
/** 输出流*/
@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
/** 视频写入*/
@property (nonatomic, strong) GPUImageMovieWriter *movieWriter;
/** 流视图*/
@property (nonatomic, strong) GPUImageView *filterView;
/** timer*/
@property (nonatomic, strong) NSTimer *timer;
/** 弹出的view*/
@property (nonatomic, strong) UIView *popupView;
/** 底部view*/
@property (nonatomic, strong) UIView *maskView;
/** windows*/
@property (nonatomic, strong) UIWindow *applicationWindow;
/** 录制视频界面底部的view*/
@property (nonatomic, strong) ShootVideoBottomView *tabbar;
/** 当前时间*/
@property (nonatomic, assign) NSTimeInterval nowTime;
/** 动画是否消失*/
@property (nonatomic, assign) BOOL dismissAnimated;
/** topView(包括取消、切换摄像头等)*/
@property  (nonatomic, strong) UIView *topView;
/** 关闭录制小视频*/
@property (nonatomic, strong) UIButton *cancelBtn;
/** 切换摄像头btn*/
@property (nonatomic, strong) UIButton *switchCameraBtn;
/** 标题label*/
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation OEPopVideoController

- (UIWindow *)applicationWindow {
    return [[UIApplication sharedApplication] keyWindow];
}

-(void)setVideoMaxTime:(NSTimeInterval)videoMaxTime {
    _videoMaxTime = videoMaxTime;
    if (videoMaxTime > 0){
        _nowTime = videoMaxTime;
        self.tabbar.progressDuration = self.videoMaxTime;
        
    }
}
- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
        [self setupCameraView];
        [self setupTabbar];
        [self setupPopupAnimation];
    }
    return self;
}
#pragma mark - setup
- (void)setupView {
    self.popupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.popupView.clipsToBounds = YES;
    
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    [self.maskView addSubview:self.popupView];
    
}

- (void)setupCameraView {
    _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset352x288 cameraPosition:AVCaptureDevicePositionBack];
    [_videoCamera addAudioInputsAndOutputs];
    _videoCamera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    _filter = [[GPUImageSaturationFilter alloc] init];
    CGRect frame = CGRectMake(0, 60, screenWidth, screenHeight - 130);
    _filterView = [[GPUImageView alloc] initWithFrame:frame];
    _filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self.popupView addSubview: _filterView];
    
    [_videoCamera addTarget:_filter];
    [_filter addTarget:_filterView];
    [_videoCamera startCameraCapture];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        _videoCamera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
    }];
    
    
    [self.maskView addSubview:self.topView];
    [self.topView addSubview:self.cancelBtn];
    [self.topView addSubview:self.switchCameraBtn];
    [self.topView addSubview:self.titleLabel];
    

    
}

- (void)setupPopupAnimation {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationWillChange)
                                                 name:UIApplicationWillChangeStatusBarOrientationNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}
- (void)setupTabbar {
    
    CGRect rect = CGRectMake(0, screenHeight-70, screenWidth, 70);
    ShootVideoBottomView *tabbar = [[ShootVideoBottomView alloc] initWithFrame:rect];
    tabbar.delegate = self;
    tabbar.backgroundColor = [UIColor whiteColor];
    [self.popupView addSubview:tabbar];
    self.tabbar = tabbar;
    
}

//关闭录制小视频
- (void)cancelBtnOnClick {
    [self dismissPopupControllerAnimated:YES];
}

//切换摄像头
- (void)switchCameraBtnOnClick {
    [_videoCamera rotateCamera];
}

#pragma mark - ShootVideoBottomViewDelegate

-(void)tabbarDidCancelRecord {
    
    [self cancelCamre];
    if (self.videoMaxTime>0){
        [self stopTimer];
    }
}
-(void)tabbarDidRecordComplete {
    
    if (self.videoMaxTime > 0.0 && self.timer == nil){//时间到与手势完成重复执行了stopCamre方法 判断避免重复保存
        return;
    }
    [self stopCamre];
    if (self.videoMaxTime > 0.0){
        [self stopTimer];
    }

}
-(void)tabbarDidRecord {
    [self startCamre];
    if (self.videoMaxTime>0){
//        [self.tabbar progressStart];
        [self startTimer];
    }
}
#pragma mark - notifi

- (void)orientationWillChange {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.frame = self.applicationWindow.bounds;
        CGPoint center = CGPointMake(self.maskView.center.x, self.maskView.bounds.size.height-(self.popupView.bounds.size.height * 0.5));
        self.popupView.center = center;
    }];
}

- (void)orientationChanged {
    UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat angle =CNP_UIInterfaceOrientationAngleOfOrientation(statusBarOrientation);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.frame = self.applicationWindow.bounds;
        CGPoint center = CGPointMake(self.maskView.center.x, self.maskView.bounds.size.height-(self.popupView.bounds.size.height * 0.5));
        
        self.popupView.center = center;
        if (CNP_SYSTEM_VERSION_LESS_THAN(@"8.0")) {
            self.popupView.transform = transform;
        }
    }];
}


- (void)startTimer {
    if (self.videoMaxTime == 0) {
        return;
    }
    if (self.timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
}
- (void)stopTimer {
    self.nowTime = self.videoMaxTime;
    [self.timer invalidate];
    self.timer = nil;
}
- (void)timerFired {
    self.nowTime--;
    if (self.nowTime == 1) {
        [self stopCamre];
        [self stopTimer];
    }
    
}
- (void)startCamre {
    if ([self.delegate respondsToSelector:@selector(popVideoControllerWillOutputSampleBuffer:)]) {
        _videoCamera.delegate = self;
    }
    
    if ([self.delegate respondsToSelector:@selector(popVideoControllerDidSave:)]) {
        NSURL *movieURL = [NSURL fileURLWithPath:OEPathToMovie];
        unlink([OEPathToMovie UTF8String]); // 如果已经存在文件，AVAssetWriter会有异常，删除旧文件
        _movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(screenWidth, screenHeight)];
        _movieWriter.encodingLiveVideo = YES;
        [_filter addTarget:_movieWriter];
        _videoCamera.audioEncodingTarget = _movieWriter;
        [_movieWriter startRecording];
    }
}
- (void)cancelCamre {
    _videoCamera.delegate = nil;
    [_filter removeTarget:_movieWriter];
    _videoCamera.audioEncodingTarget = nil;
    [_movieWriter cancelRecording];
    _movieWriter = nil;
}

- (void)stopCamre {
    
    if ([self.delegate respondsToSelector:@selector(popVideoControllerWillOutputSampleBuffer:)]) {
       _videoCamera.delegate = nil;
    }
    
    if ([self.delegate respondsToSelector:@selector(popVideoControllerDidSave:)]) {
        [_filter removeTarget:_movieWriter];
        _videoCamera.audioEncodingTarget = nil;
        [_movieWriter finishRecordingWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate popVideoControllerDidSave:OEPathToMovie];
            });
        }];
    }
}

CGFloat CNP_UIInterfaceOrientationAngleOfOrientation(UIInterfaceOrientation orientation) {
    CGFloat angle;
    
    switch (orientation)
    {
        case UIInterfaceOrientationPortraitUpsideDown:
            
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = -M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI_2;
            break;
        default:
            angle = 0.0;
            break;
    }
    
    return angle;
}

- (void)presentPopupControllerAnimated:(BOOL)flag {
    
    // Keep a record of if the popup was presented with animation
    self.dismissAnimated = flag;
    [self calculateContentSizeThatFits:CGSizeMake(self.maskView.bounds.size.width, self.maskView.bounds.size.height) andUpdateLayout:YES];
    self.popupView.center = CGPointMake(self.maskView.center.x, self.maskView.bounds.size.height + self.popupView.bounds.size.height);
    [self.applicationWindow addSubview:self.maskView];
    self.maskView.alpha = 0;
    
    [UIView animateWithDuration:flag?0.3:0.0 animations:^{
        self.maskView.alpha = 1.0;
        self.popupView.center =  CGPointMake(self.maskView.center.x, self.maskView.bounds.size.height-(self.popupView.bounds.size.height * 0.5));
    } completion:^(BOOL finished) {
        self.popupView.userInteractionEnabled = YES;
    }];
}

- (void)dismissPopupControllerAnimated:(BOOL)flag{
    self.dismissAnimated = flag;
    
    [UIView animateWithDuration:flag?0.3:0.0 animations:^{
        self.popupView.center = CGPointMake(self.maskView.center.x, self.maskView.frame.size.height+self.popupView.frame.size.height/2);
    } completion:^(BOOL finished) {
        self.maskView.alpha = 0.0;
        [self.maskView removeFromSuperview];
    }];
    
}

- (CGSize)calculateContentSizeThatFits:(CGSize)size andUpdateLayout:(BOOL)update {

    CGSize result = CGSizeMake(0, 0);
    for (UIView *view in self.popupView.subviews)
    {
        view.autoresizingMask = UIViewAutoresizingNone;
        if (!view.hidden)
        {
            CGSize _size = view.frame.size;
            if (CGSizeEqualToSize(_size, CGSizeZero))
            {
                _size = [view sizeThatFits:size];
                _size.width = size.width;
                if (update) view.frame = CGRectMake(0, result.height, _size.width, _size.height);
            }
            else {
                if (update) {
                    view.frame = CGRectMake(0, result.height, _size.width, _size.height);
                }
            }
            result.height += _size.height;
            result.width = MAX(result.width, _size.width);
        }
    }
    if (update) self.popupView.frame = CGRectMake(0, 0, result.width, result.height);
    return result;
}

#pragma mark - lazyLoading

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 60)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(10, 20, 50, 30);
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)switchCameraBtn {
    if (!_switchCameraBtn) {
        _switchCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchCameraBtn.frame = CGRectMake(screenWidth - 50, 20, 50, 30);
        [_switchCameraBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _switchCameraBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_switchCameraBtn setTitle:@"切换" forState:UIControlStateNormal];
        [_switchCameraBtn addTarget:self action:@selector(switchCameraBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _switchCameraBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2-50, 20, 100, 30)];
        _titleLabel.text = @"拍摄";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    }
    return _titleLabel;
}

- (void)dealloc {
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - GPUImageVideoCamreaDelegate
- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    if ([self.delegate respondsToSelector:@selector(popVideoControllerWillOutputSampleBuffer:)]) {
        [self.delegate popVideoControllerWillOutputSampleBuffer:sampleBuffer];
    }
}
@end
