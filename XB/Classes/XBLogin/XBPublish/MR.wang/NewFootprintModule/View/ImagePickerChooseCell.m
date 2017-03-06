//
//  ImagePickerChooseCell.m
//  whqFor
//
//  Created by Mr.Wang on 2017/2/26.
//  Copyright © 2017年 Mr.wang. All rights reserved.
//

#import "ImagePickerChooseCell.h"

@implementation ImagePickerChooseCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"ImagePickerChooseCell";
    
    //缓存中取
    ImagePickerChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //创建
    if (!cell)
    {
        cell = [[ImagePickerChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *imagePickerName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        imagePickerName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:imagePickerName];
        self.imagePickerName = imagePickerName;
    }
    return self;
}

@end
