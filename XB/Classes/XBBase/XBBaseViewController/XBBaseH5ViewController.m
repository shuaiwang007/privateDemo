//
//  XBBaseH5ViewController.m
//  XB
//
//  Created by 王化强 on 2017/3/3.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBBaseH5ViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface XBBaseH5ViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate>
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

@end

@implementation XBBaseH5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerTitle = @"h5页面";
    
}

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:req];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, XBNavigationBarHeight, Width, Height - XBNavigationBarHeight)];
        _webView.delegate = _progressProxy;
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
        CGFloat progressBarHeight = 2.f;
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:_webView];
    }
    return _webView;
}



#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.headerTitle = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
