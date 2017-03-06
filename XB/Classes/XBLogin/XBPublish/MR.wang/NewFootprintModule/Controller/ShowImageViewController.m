//
//  ShowImageViewController.m
//  whqFor
//
//  Created by 王帅 on 2017/3/4.
//  Copyright © 2017年 Mr.wang. All rights reserved.
//

#import "ShowImageViewController.h"
#import "ShowImageView.h"

@interface ShowImageViewController ()

@end

@implementation ShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ShowImageView *showImageView = [[ShowImageView alloc] initWithFrame:self.view.bounds byClickTag:self.clickTag appendArray:self.imageViews];
    [self.view addSubview:showImageView];
    __weak ShowImageViewController *weakSelf = self;
    showImageView.removeImg = ^(){
        weakSelf.navigationController.navigationBarHidden = NO;
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

-(void)dealloc {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
