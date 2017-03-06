//
//  EUploadDataModel.m
//  EFood
//
//  Created by 王化强 on 2016/12/4.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import "EUploadDataModel.h"

@implementation EUploadDataModel

- (instancetype)initWithData:(NSData *)data
                name:(NSString *)name
            fileName:(NSString *)fileName
            mineType:(NSString *)mineType
{
    self = [super init];
    if (self) {
        self.data = data;
        self.name = name;
        self.fileName = fileName;
        self.mimeType = mineType;
    }
    return self;
}

@end
