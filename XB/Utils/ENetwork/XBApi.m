//
//  XBApi.m
//  XB
//
//  Created by 王化强 on 2017/2/20.
//  Copyright © 2017年 whqfor. All rights reserved.
//

#import "XBApi.h"

@implementation XBApi

//NSString *const XBAPIBaseURLStr = @"http://apitest.xiaobu121.com/local/";
NSString *const XBAPIBaseURLStr = @"http://apitest.xiaobu121.com/1_0/";

NSString *const XBApiIndexBest             = @"Index/best";              // 首页/精选
NSString *const XBApiFeedFollow            = @"feed/Follow";             // 首页/关注
NSString *const XBApiPopStep               = @"index/pop_step";          // 首页/精选/热门脚印

NSString *const XBApiIndexPlan             = @"index/plan";              // 计划/计划
NSString *const XBApiIndexTip              = @"index/tip";               // 计划/1小步
NSString *const XBApiPlanAllCat            = @"Plan/all_cat";            // 计划/分类/标签
NSString *const XBApiTipAllCat             = @"tip/tags";                // 计划/1小步/标签
NSString *const XBApiPlanSearch            = @"Plan/search";             // 分类搜索计划
NSString *const XBApiPlanDetail            = @"Plan/detail";             // 某个计划
NSString *const XBApiTipPlanTips           = @"tip/plan_tips";           // 计划下的所有小步
NSString *const XBApiTipDetail             = @"tip/detail";              // 某个小步
NSString *const XBApiStepLists             = @"Step/lists";              // 计划的或一小步脚印列表

NSString *const XBApiStepDetail            = @"Step/detail";             // 某个脚印
NSString *const XBApiCommentPlanList       = @"Comment/plan_lists";      // 计划页的评论列表
NSString *const XBApiCommentStepList       = @"Comment/step_lists";      // 脚印页的评论列表

NSString *const XBApiFileUpload            = @"file/upload";             // 文件上传
NSString *const XBApiTipsMyJoin            = @"plan/myJoined";           // 加入计划的小步
NSString *const XBApiTipsMyLike            = @"Like/tip_mylike";         // 我喜欢的小步

@end
