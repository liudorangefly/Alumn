//
//  User+Extension.h
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "User.h"
#import "AFNetManager.h"
#import "AFHTTPSessionManager.h"
 static  NSString *picUrls=@"" ;
@interface User (Extension)

+(User*) getUser;
//注册 post
+ (void)upLoadUserImg:(UIImage *)image method:(NSString *) method SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
+(void) registerWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//手机号验证 post
+(void) checkphoneWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//获得xrsf Get方法
+(void) getXrsfWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//登陆，存储我的信息，圈子id获取，人脉
+(void) loginWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;

/* 我的 */

//我的页面圈子内容获取
+(void) MyAdminCirlceIntroduceWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
+(void) MyCreateCirlceIntroduceWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//收藏的名片获取
+(void) CardWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//注销
+(void) logoutWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//用户设置
+(void) userSettingWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;

/*消息
 收到的评论*/
+(void) reciveCommentWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//系统通知
+(void) systemMessageWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;


//高级筛选
+(void) highSearchWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//模糊搜索
+ (void)uncertainSearchWithParameters:(NSDictionary *)parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock)afnErrorblock;

//   人脉界面
+ (void)peopleListWithParameters:(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;

// 获得单独某人的人脉详情
+ (void)getPersonalInfo:(NSDictionary*) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;

// 收藏该名片
+ (void)collectTheCard:(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;


+ (NSDictionary*)getUserDic;

+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

+ (void)upLoadImages:(NSArray*)images UploadSuccess:(uplpadSuccess)uplpadSuccess AFNErrorBlock:(AFNErrorBlock)afnErrorblock;

//上传修改的个人资料
+ (void)changeSettingWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;
//审核申请
+ (void)checkApplyWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock;


@end
