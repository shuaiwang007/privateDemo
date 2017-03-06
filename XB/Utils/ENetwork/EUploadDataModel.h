//
//  EUploadDataModel.h
//  EFood
//
//  Created by 王化强 on 2016/12/4.
//  Copyright © 2016年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EUploadDataModel : NSObject

@property (nonatomic, strong) NSData *data;     // 文件数据
@property (nonatomic, copy) NSString *name;     // 参数名
@property (nonatomic, copy) NSString *fileName; // 文件名
@property (nonatomic, copy) NSString *mimeType; // 文件类型

- (instancetype)initWithData:(NSData *)data
                name:(NSString *)name
            fileName:(NSString *)fileName
            mineType:(NSString *)mineType;

@end
