//
//  XBFootCustomIrregularGridViewCell.m
//  XB
//
//  Created by 王化强 on 2017/2/21.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBFootCustomIrregularGridViewCell.h"
#import "UIView+AnimationProperty.h"

@interface XBFootCustomIrregularGridViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@end

@implementation XBFootCustomIrregularGridViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedEvent)];
    self.imgV.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)loadContent {
    
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:self.dataAdapter.data]];
}

- (void)willDisplay {
    self.imgV.alpha = 0.f;
    self.imgV.scale = 0.975f;
    
    [UIView animateWithDuration:0.75f animations:^{
    
        self.imgV.alpha = 1.f;
        self.imgV.scale = 1.f;
    }];
}

- (void)didEndDisplay {
    [self.imgV.layer removeAllAnimations];
}

@end
