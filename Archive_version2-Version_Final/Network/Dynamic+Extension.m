//
//  Dynamic+Extension.m
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "Dynamic+Extension.h"
#import "User+Extension.h"
#import "User.h"

@implementation Dynamic (Extension)

+(void) publishWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock{
    
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/myfeed/update",[AFNetManager getMainURL]];
    
    NSDictionary *postdata = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[User dictionaryToJson:parm],@"info_json",nil];
    NSLog(@"Publish ................%@",postdata);
    
    [[AFNetManager manager] POST:getFirstURL parameters:postdata progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"circle deatil: %@", responseObject);
        NSLog(@"发布公告返回值: %@", dic);
        successBlock(dic,YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"发布公告失败");
    }];
    
}

@end
