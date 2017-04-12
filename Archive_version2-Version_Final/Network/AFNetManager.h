//
//  AFNetManger.h
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNetManager : NSObject
#define kTimeOutInterval 30 // 请求超时的时间
typedef void (^SuccessBlock)(NSDictionary *dict, BOOL success); // 访问成功block
typedef void (^AFNErrorBlock)(NSError *error); // 访问失败block
typedef void (^uplpadSuccess) (NSString *str ,BOOL success );
+ (NSString*)getMainURL;
+(AFHTTPSessionManager *)manager;
+(NSString *)dictionaryToJson:(NSDictionary *)dic;
@end
