//
//  XBApi.h
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBApi : NSObject

UIKIT_EXTERN NSString *const XBAPIBaseURLStr;

UIKIT_EXTERN NSString *const XBApiIndexBest;                    // 首页/首面/精选
UIKIT_EXTERN NSString *const XBApiFeedFollow;                   // 首页/首面/关注
UIKIT_EXTERN NSString *const XBApiPopStep;                      // 首页/精选/热门脚印

UIKIT_EXTERN NSString *const XBApiIndexPlan;                    // 计划/计划
UIKIT_EXTERN NSString *const XBApiIndexTip;                     // 计划/1小步
UIKIT_EXTERN NSString *const XBApiPlanAllCat;                   // 计划/分类/标签
UIKIT_EXTERN NSString *const XBApiTipAllCat;                    // 计划/1小步/标签
UIKIT_EXTERN NSString *const XBApiPlanSearch;                   // 分类搜索计划
UIKIT_EXTERN NSString *const XBApiPlanDetail;                   // 某个计划
UIKIT_EXTERN NSString *const XBApiTipPlanTips;                  // 计划下的所有小步
UIKIT_EXTERN NSString *const XBApiTipDetail;                    // 某个小步
UIKIT_EXTERN NSString *const XBApiStepLists;                    // 计划或者一小步的脚印列表
UIKIT_EXTERN NSString *const XBApiStepDetail;                   // 某个脚印
UIKIT_EXTERN NSString *const XBApiCommentPlanList;              // 计划页的评论列表
UIKIT_EXTERN NSString *const XBApiCommentStepList;              // 脚印页的评论列表

UIKIT_EXTERN NSString *const XBApiFileUpload;                   // 文件上传
UIKIT_EXTERN NSString *const XBApiTipsMyJoin;                   // 加入计划的小步
UIKIT_EXTERN NSString *const XBApiTipsMyLike;                   // 我喜欢的小步

@end
