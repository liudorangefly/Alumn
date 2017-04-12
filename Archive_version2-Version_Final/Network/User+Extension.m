//
//  User+Extension.m
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "User+Extension.h"
#import "MeViewModel.h"
#import "StaticData.h"

static User *user;


@implementation User (Extension)

+ (User*)getUser{
    static dispatch_once_t dec;
    
    dispatch_once(&dec, ^{
        user = [[User alloc] init];
        //   xrsf = [[NSString alloc] init];
    });
    
    return user;
}




//注册 post
+ (void)upLoadUserImg:(UIImage *)image method:(NSString *) method SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
    NSLog(@"已执行上传头像函数");
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *_encodedImageStr = [imageData base64Encoding];
    
    NSDictionary *postdata = [[NSDictionary alloc] initWithObjectsAndKeys: _encodedImageStr,@"base64ImgStr",[User getXrsf],@"_xsrf",[User getXrsf],@"random_num", nil];
    
    NSLog(@"注册最后一步－－－－－－－－－－－－上传头像参数: %@",postdata);
    
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/%@",[AFNetManager getMainURL],method];
    
    [[AFNetManager manager] POST:getFirstURL parameters:postdata progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"circle deatil: %@", responseObject);
        NSLog(@"circle deatil: %@", dic);
        successBlock(dic,YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
    }];
}


+(void) registerWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSString *registerURL = [[NSString alloc] initWithFormat:@"%@/register",[AFNetManager getMainURL]];
    NSDictionary *sendDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[self dictionaryToJson:parm],@"info_json", nil];
    
    [[AFNetManager manager]POST:registerURL parameters:sendDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"注册成功 %@",dic);
        
        successBlock(dic,YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"注册失败 %@",error);
        afnErrorblock(error);
        
    }];
    
    
}
//手机号验证 post
+(void) checkphoneWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
    [self getXrsfWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
        
        NSString *checkPhoneURL = [[NSString alloc] initWithFormat:@"%@/checkphone",[AFNetManager getMainURL]];
        
        NSDictionary *registerFirstDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[parm valueForKey:@"telephone"],@"telephone", nil];
        
        [[AFNetManager manager]POST:checkPhoneURL parameters:registerFirstDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSLog(@"检测手机号成功%@",dic);
            if([[dic valueForKey:@"code"] integerValue]== 3000){
                //----------------------------------------  #######获取界面所有注册信息
                NSDictionary *registerDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"南京",@"city",@"江苏省",@"state",@"中国",@"country",@"软件学院",@"faculty",@"韩雪滢",@"name",@"软件工程",@"major",@"the SEU",@"company",[NSNumber numberWithInt:2014],@"admission_year",@"15051839068",@"telephone",@"student",@"job",[NSNumber numberWithInt:0],@"gender",@"sheryl",@"password", nil];
                //---------------------------------------- ###########
                //  NSLog(@"注册全部信息%@",registerDic);
                
                successBlock(nil,YES);
            }
            else{
                //手机号码验证失败
                NSLog(@"手机号码验证操作失败");
                NSLog(@"%@",[dic valueForKey:@"code"]);
                if([[[NSString alloc] initWithFormat:@"%@",[dic valueForKey:@"code"]] isEqualToString:[[NSString alloc] initWithFormat:@"%d",3001]]){
                    NSLog(@"手机号码已经注册");
                }else{
                    NSLog(@"其他验证错误");
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"检测手机号失败%@",error);
            afnErrorblock(error);
        }];
        
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"令牌获取失败：%@",error);
    }];
    
}

//获得xrsf Get方法
+(void) getXrsfWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSLog(@"getXrsfWithParameters");
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/",[AFNetManager getMainURL]];
    
    [[AFNetManager manager] GET:getFirstURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"令牌获取成功%@",dic);
        
        NSString *message = [dic objectForKey:@"message"];
        [User setXrsf:message];
        
        NSLog(@"User xsrf: %@",[User getXrsf]);
        
        //        NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:@"15896193612",@"telephone",@"cxh1234567",@"password", nil];
        //        NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",xrsf,@"_xsrf", nil];
        successBlock(nil,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"获取令牌失败%@",error);
        afnErrorblock(error);
    }];
}
//登陆，存储我的信息，圈子id获取，人脉
+(void) loginWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    //    NSString *getFirstURL = [NSString stringWithFormat:@"%@/login",[AFNetManager getMainURL]];
    //
    //    [self getXrsfWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
    //
    //        NSDictionary *loginDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[self dictionaryToJson:parm],@"info_json", nil];
    //
    //        NSLog(@"output the loginDic :%@",loginDic);
    //
    //        [[AFNetManager manager] POST:getFirstURL  parameters:loginDic progress:nil
    //          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    //             NSLog(@"%@", dic);
    //              successBlock(dic,YES);
    //         }
    //         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //                                 NSLog(@"登录失败");}];
    //    } AFNErrorBlock:^(NSError *error) {
    //
    //    }];
    
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/login",[AFNetManager getMainURL]];
    
    
    [self getXrsfWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
        
        NSString *userLogin = [self dictionaryToJson:parm];
        NSDictionary *loginDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",userLogin,@"info_json", nil];
        
        [[AFNetManager manager] POST:getFirstURL  parameters:loginDic progress:nil
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                                 NSLog(@"%@", dic);
                                 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                 NSString *plistPath1= [paths objectAtIndex:0];
                                 
                                 NSLog(@"%@",plistPath1);
                                 //得到完整的路径名
                                 NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"User.plist"];
                                 NSDictionary *main = [dic objectForKey:@"Data"];
                                 NSDictionary *user = [main objectForKey:@"response"];
                                 
                                 NSFileManager *fm = [NSFileManager defaultManager];
                                 if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
                                     
                                     [user writeToFile:fileName atomically:YES];
                                     NSLog(@"文件写入完成");
                                     successBlock(dic,YES);
                                 }
                                 
                             }
                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                 NSLog(@"失败");
                                 afnErrorblock(error);
                             }];
    } AFNErrorBlock:^(NSError *error) {
        
    }];
    
    
    
}


/* 我的 */

//我的页面圈子内容获取
+(void) MyAdminCirlceIntroduceWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
    NSString *myCircleURL = [[NSString alloc] initWithFormat:@"%@/get_my_filter_circle",[AFNetManager getMainURL]];
    
    NSString *circleType = [[self getUserDic] valueForKey:@"admin_circle_list"];
    
    NSLog(@"admin_list  %@",circleType);
    
    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",circleType,@"my_filter_circle", nil];
    
    NSLog(@"传给：%@",requestDic);
    
    
    [[AFNetManager manager] POST:myCircleURL parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"获取我加入的圈子内容成功 ：%@", dic);
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取我加入的圈子内容失败 ：%@",error);
        afnErrorblock(error);
    }];
}


+(void) MyCreateCirlceIntroduceWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    //    ******************
    
    
    //    ******************
    
    
    NSString *myCircleURL = [[NSString alloc] initWithFormat:@"%@/get_my_filter_circle",[AFNetManager getMainURL]];
    
    NSString *circleType = [[self getUserDic] valueForKey:@"create_circle_list"];
    
    NSLog(@"create_list  %@",circleType);
    
    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",circleType,@"my_filter_circle", nil];
    
    NSLog(@"传给：%@",requestDic);
    
    
    [[AFNetManager manager] POST:myCircleURL parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"获取我创建的圈子内容成功 ：%@", dic);
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取我创建的圈子内容失败 ：%@",error);
        afnErrorblock(error);
    }];
}


//收藏的名片获取
+(void) CardWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSString *myCardURL = [[NSString alloc] initWithFormat:@"%@/followslist",[AFNetManager getMainURL]];
    
    NSString *uid = [[self getUserDic] valueForKey:@"uid"];
    
    NSDictionary *cardDic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:30],@"count",[NSNumber numberWithInt:1],@"page",uid,@"uid", nil];
    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[self dictionaryToJson:cardDic],@"info_json", nil];
    
    NSLog(@"传给For Card：%@",requestDic);
    
    [[AFNetManager manager] POST:myCardURL parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"获取我Card内容成功 ：%@", dic);
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取我Card内容失败 ：%@",error);
        afnErrorblock(error);
    }];
    
}
//注销
+(void) logoutWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock{
    
    NSString *logoutURL = [[NSString alloc] initWithFormat:@"%@/logout",[AFNetManager getMainURL]];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf", nil];
    
    [[AFNetManager manager] POST:logoutURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"退出登录成功 ：%@", dic);
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"退出登录失败 ：%@",error);
        afnErrorblock(error);
    }];

}
//用户设置
+(void) userSettingWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
}


/*消息
 收到的评论*/
+(void) reciveCommentWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
    NSString *myCommentURL = [[NSString alloc] initWithFormat:@"%@/get_my_comment",[AFNetManager getMainURL]];
    NSDictionary *commentDic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:30],@"count",@"received",@"type",[NSNumber numberWithInteger:1],@"page", nil];
    
    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[self dictionaryToJson:commentDic],@"info_json", nil];
    
    [[AFNetManager manager] POST:myCommentURL parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"获取我Comment内容成功 ：%@", dic);
        
        NSArray *results = [[[dic valueForKey:@"Data"] valueForKey:@"response"] valueForKey:@"results"];
        
        //---------------------------------------------------------------------------  将收到的评论存入plist
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        
        NSLog(@"%@",plistPath1);
        //得到完整的路径名
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"commentList.plist"];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
            
            [results writeToFile:fileName atomically:YES];
            NSLog(@"commentList.plist文件写入完成");
        }
        successBlock(dic,YES);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取我Comment内容失败 ：%@",error);
        afnErrorblock(error);
    }];
    
    
}
//系统通知
+(void) systemMessageWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSString *myMessageURL = [[NSString alloc] initWithFormat:@"%@/getmessage",[AFNetManager getMainURL]];
    //    NSDictionary *messageDic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:30],@"count",@"received",@"type",[NSNumber numberWithInteger:1],@"page", nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    //得到完整的路径名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"User.plist"];
    NSDictionary *userInfo = [[NSDictionary alloc] initWithContentsOfFile:fileName];
    
    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[userInfo valueForKeyPath:@"my_circle_list"],@"my_circle_list", nil];
    
    NSLog(@"%@",requestDic);
    
    [[AFNetManager manager] POST:myMessageURL parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"获得的全部message %@",dic);
        
        NSArray *request = [[dic valueForKey:@"Data"] valueForKey:@"response"];
        
        //-------------------------------------------  将收到的message存入plist
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        
        NSLog(@"%@",plistPath1);
        //得到完整的路径名
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"messageList.plist"];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
            
            [request writeToFile:fileName atomically:YES];
            NSLog(@"messageList.plist文件写入完成 array个数 %ld",(long)request.count);
            
            //*********************************************************测试输出
            for(int i = 0;i < request.count ; i++)
            {
                NSLog(@"输出messageList.plist %@",request[i]);

            }
             successBlock(dic,YES);
    }

        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取我Message内容失败 ：%@",error);
        afnErrorblock(error);
    }];
    
}


//高级筛选
+(void) highSearchWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    
    NSString *peoplelistURL = [[NSString alloc] initWithFormat:@"%@/search_user",[AFNetManager getMainURL]];
    
    NSLog(@"发送到:%@",parm);
    
    [[AFNetManager manager] POST:peoplelistURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"高级筛选 获取人脉列表成功 ：%@", dic);
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"高级筛选 获取人脉列表失败 ：%@",error);
        afnErrorblock(error);
    }];
}

//模糊搜索
+ (void)uncertainSearchWithParameters:(NSDictionary *)parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock)afnErrorblock{
    
    NSString *peoplelistURL = [[NSString alloc] initWithFormat:@"%@/search_user",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:peoplelistURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"模糊搜索成功 ：%@", dic);
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"模糊搜索失败 ：%@",error);
        afnErrorblock(error);
    }];
    
}



+ (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//   人脉界面
+ (void)peopleListWithParameters:(NSDictionary *)parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock)afnErrorblock{
    
    
    NSLog(@"1.Page数 :%@  Size数 :%@",[NSNumber numberWithInteger:[StaticData getPeoplePage]],[NSNumber numberWithInteger:[StaticData getPeopleSize]]);
    
    if([StaticData getPeoplePage] > -1){
        
        NSString *peoplelistURL = [[NSString alloc] initWithFormat:@"%@/search_user",[AFNetManager getMainURL]];
        NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[NSNumber numberWithInt:0],@"filter_admission_year_min",[NSNumber numberWithInt:9999],@"filter_admission_year_max",@"[]",@"filter_major_list",@"[]",@"filter_city_list",[NSNumber numberWithInt:2],@"all_match",@"",@"query",[NSNumber numberWithInteger:[StaticData getPeoplePage]] ,@"page",[NSNumber numberWithInt:10],@"size",nil];
        
        NSLog(@"传输的内容：%@",requestDic);
        
        [[AFNetManager manager] POST:peoplelistURL parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil]];
            NSLog(@"获取人脉列表成功 ：%@", dic);
            
            // 获得人脉列表的总个数  &&  计算page数
            NSArray *peopleArray = [[[[dic valueForKey:@"Data"]valueForKey:@"response"]valueForKey:@"hits"]valueForKey:@"hits"];
            
            NSLog(@"人脉数组的个数 %@",[NSNumber numberWithInteger:peopleArray.count]);
            
            [StaticData setPeopleSize:peopleArray.count];
            
            
            NSLog(@"AFNetManager 返回的successBlock中的Size：%@ Page :%@",[NSNumber numberWithInteger:[StaticData getPeopleSize]],[NSNumber numberWithInteger:[StaticData getPeoplePage]]);
            
            
            NSMutableDictionary *saveDic = [[NSMutableDictionary alloc]init];
            [saveDic setObject:peopleArray forKey:@"peopleArray"];
            [saveDic setObject:[NSNumber numberWithInteger:[StaticData getPeopleSize]] forKey:@"peopleSize"];
            
            NSLog(@"获取人脉数组＋计算结果：%@",saveDic);
            
            successBlock(saveDic,YES);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"获取人脉列表失败 ：%@",error);
            afnErrorblock(error);
        }];
    }
    
}




+ (NSDictionary*)getUserDic{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    
    NSLog(@"%@",plistPath1);
    //得到完整的路径名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"User.plist"];
    
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
    
    
    return [[NSDictionary alloc]initWithDictionary:userDic];
    
    
}

+ (void)upLoadImages:(NSArray *)images UploadSuccess:(uplpadSuccess)uplpadSuccess AFNErrorBlock:(AFNErrorBlock)afnErrorblock {
    bool flag =NO;
    int imgNum = 0;
    int countPics = 0;
    if(images.count >= 9){
        imgNum = 9;
    }else{
        imgNum = images.count;
    }
    
    
    if(!flag)
    {
        [User upLoadUserImg:images[0] method:@"upload_normal_img" SuccessBlock:^(NSDictionary *dict, BOOL success) {
            
            picUrls = [NSString stringWithFormat:@"%@%@",picUrls,[dict valueForKey:@"img_key"]];
            NSLog(@"picUrls input %@",picUrls);
            
        } AFNErrorBlock:^(NSError *error) {
            NSLog(@"第 %d 张图片上传失败,i");
        }];
        flag=YES;
    }
    
    if(flag){
        for(int i = 1 ;i < imgNum ; i++){
            NSLog(@"upLoadImages for %d: %@",i,picUrls);
            
            
            [User upLoadUserImg:images[i] method:@"upload_normal_img" SuccessBlock:^(NSDictionary *dict, BOOL success) {
                
                picUrls = [NSString stringWithFormat:@"%@;%@",picUrls,[dict valueForKey:@"img_key"]];
                NSLog(@"picUrls input %@",picUrls);
                
            } AFNErrorBlock:^(NSError *error) {
                NSLog(@"第 %d 张图片上传失败,i");
            }];
        }
    }
    
uplpadSuccess(picUrls,YES);

}

//收藏／取消收藏 卡片

+ (void)collectTheCard:(NSDictionary *)parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock)afnErrorblock{
    
    NSString *collectURL = [[NSString alloc] initWithFormat:@"%@/follow",[AFNetManager getMainURL]];
    
    [[AFNetManager manager] POST:collectURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"收藏名片成功 ：%@", dic);
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"收藏名片失败 ：%@",error);
        afnErrorblock(error);
    }];

}

//得到人脉的具体信息

+ (void)getPersonalInfo:(NSDictionary *)parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock)afnErrorblock{
    NSString *getInfoURL = [[NSString alloc] initWithFormat:@"%@/user_detail",[AFNetManager getMainURL]];
    
    [[AFNetManager manager] POST:getInfoURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"获得某个人脉详情成功 ：%@", dic);
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获得某个人脉详情失败 ：%@",error);
        afnErrorblock(error);
    }];

    
}


//上传个人信息修改的
+ (void)changeSettingWithParameters:(NSDictionary *)parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock)afnErrorblock{
    NSString *getInfoURL = [[NSString alloc] initWithFormat:@"%@/updateinfo",[AFNetManager getMainURL]];
    
    [[AFNetManager manager] POST:getInfoURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"更新个人资料成功 ：%@", dic);
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"更新个人资料失败 ：%@",error);
        afnErrorblock(error);
    }];
    
}

//审核申请
+ (void)checkApplyWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock{
    NSString *checkApplyURL = [[NSString alloc] initWithFormat:@"%@/circle_apply_result",[AFNetManager getMainURL]];
    
    [[AFNetManager manager] POST:checkApplyURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"更新个人资料成功 ：%@", dic);
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"更新个人资料失败 ：%@",error);
        afnErrorblock(error);
    }];

}


@end
