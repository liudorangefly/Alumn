//
//  Circle+Extension.h
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "Circle.h"
#import "AFNetManager.h"
@interface Circle (Extension)
+(Circle*) getCircle;
//获得圈子主页列表
+(void) getMainPageCircleWithParameters:(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//获得圈子详情
+(void) circleDeatilsWithParameters :(NSDictionary *) parm;
//获得分类里的圈子列表 名字，简介，图片等
+(void) circleIndexWithParameters :(NSDictionary *) parm;
//获得圈子动态列表
+(void) circeDynamicListWithParameters:(NSDictionary *)parm page:(NSNumber *) pages SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//申请加入圈子
+(void) joinCircleWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
;

//获得某个类型的圈子列表
+(void) getTypetopicWithParameters :(NSDictionary *) parm ID:(NSString *)Type_id SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
+(void) uploadPicture:(UIImage *)image method:(NSString *) method SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;

+(void) createCircleWithParamenters :(NSDictionary *) parm;
//获取评论列表
+(void) getCommentWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
// 发布评论
+(void) pubcommentWithParameters :(NSDictionary * ) parm;
//点赞
+(void) greatWithParameters :(NSDictionary *) parm;
@end
