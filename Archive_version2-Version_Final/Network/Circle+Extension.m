//
//  Circle+Extension.m
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "Circle+Extension.h"
#import "AFNetManager.h"
#import "User.h"
#import "circleDeatilVC.h"

@implementation Circle (Extension)

static Circle *circle;
+ (Circle*)getCircle{
    static dispatch_once_t dec;
    
    dispatch_once(&dec, ^{
       circle  = [[Circle alloc] init];
        //   xrsf = [[NSString alloc] init];
    });
    
    return circle;
}
+(void) getMainPageCircleWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/get_my_circle",[AFNetManager getMainURL]];
    NSLog(@"User+exten: %@", [User getXrsf]);
    extern NSString *xrsf;
    NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [User getXrsf],@"_xsrf", nil];
    NSLog(@"User+exten: %@", postdic);
    [[AFNetManager manager] POST:getFirstURL parameters:postdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"User+exten: %@", dic);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        
        NSLog(@"%@",plistPath1);
        //得到完整的路径名
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"MainPageCircle.plist"];
        NSDictionary *main = [dic objectForKey:@"Data"];
        NSDictionary *result = [main objectForKey:@"response"];
        NSDictionary *mainCilrcle = [result objectForKey:@"results"];
            NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
            
            [mainCilrcle writeToFile:fileName atomically:YES];
            NSLog(@"文件写入完成");
            successBlock(dic,YES);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
    }];
    
 
}
//获得分类里的圈子列表 名字，简介，图片等
+(void) circleIndexWithParameters :(NSDictionary *) parm
{
    
    
}
//申请加入圈子
+(void) joinCircleWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock

{
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/apply_circle",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"circle deatil: %@", responseObject);
        NSLog(@"circle deatil: %@", dic);
        successBlock(dic,YES);
        
    }
                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                             
                             NSLog(@"getxsrf failure");
                             
                         }];
}


//获得某个类型的圈子列表
+(void) getTypetopicWithParameters :(NSDictionary *) parm ID:(NSString *)Type_id SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
      NSString *getFirstURL = [NSString stringWithFormat:@"%@/gettypetopic",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"User+exten: %@", dic);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        NSString *plistName =[[NSString alloc] initWithFormat:@"TYPE_%@.plist",Type_id];
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:plistName];
        NSDictionary *main = [dic objectForKey:@"Data"];
        NSDictionary *result = [main objectForKey:@"response"];
        NSDictionary *mainCilrcle = [result objectForKey:@"results"];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
            
            [mainCilrcle writeToFile:fileName atomically:YES];
            NSLog(@"文件写入完成");
        }
        successBlock(dic,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
    }];
    

 
}

//获得圈子详情
+(void) circleDeatilsWithParameters :(NSDictionary *) parm
{
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/detail_circle",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"circle deatil: %@", dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
    }];

    
}

//获得圈子动态列表
+(void) circeDynamicListWithParameters:(NSDictionary *)parm page:(NSNumber *) pages SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    //得到完整的路径名
//    BOOL flag =false;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *plistName =[[NSString alloc] initWithFormat:@"DynamicList%@_Page%@.plist",[circleDeatilVC getIDinList],pages];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:plistName];
   
    NSFileManager *fm = [NSFileManager defaultManager];

    NSString *getFirstURL = [NSString stringWithFormat:@"%@/circle_feed",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"circle deatil: %@", responseObject);
        //NSLog(@"circle deatil: %@", dic);
        
        
        NSLog(@"%@",plistPath1);
        NSDictionary *main = [dic objectForKey:@"Data"];
        NSDictionary *result = [main objectForKey:@"response"];
        NSDictionary *list = [result objectForKey:@"results"];

        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
            [list writeToFile:fileName atomically:YES];
                        NSLog(@"文件写入完成");
            successBlock(dic,YES);
           
        }
        
       


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
    }];
    // flag=true;
//}
    
}



+(void) uploadPicture:(UIImage *)image method:(NSString *) method SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *_encodedImageStr = [imageData base64Encoding];
    
    NSDictionary *postdata = [[NSDictionary alloc] initWithObjectsAndKeys: _encodedImageStr,@"base64ImgStr",[User getXrsf],@"_xsrf",[User getXrsf],@"random_num", nil];
    //NSLog(@"circle deatil: %@",postdata);
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/%@",[AFNetManager getMainURL],method];
    
    [[AFNetManager manager] POST:getFirstURL parameters:postdata progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"circle deatil: %@", responseObject);
        NSLog(@"circle deatil: %@", dic);
        successBlock(dic,YES);
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
    }];}


+(void) createCircleWithParamenters :(NSDictionary *) parm
{
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/createTopic",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"circle deatil: %@", responseObject);
    NSLog(@"circle deatil: %@", dic);
            
        }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        NSLog(@"getxsrf failure");
        
    }];

}

//获取评论列表
+(void) getCommentWithParameters :(NSDictionary *) parm SuccessBlock:(SuccessBlock)successBlock AFNErrorBlock:(AFNErrorBlock) afnErrorblock

{
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/commentlist",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"circle deatil: %@", responseObject);
        NSLog(@"circle deatil: %@", dic);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        NSString *id= [NSString stringWithFormat:@"id_%@_comment.plist",[parm objectForKey:@"feed_id"]];
        NSLog(@"%@",plistPath1);
        //得到完整的路径名
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:id];
        NSDictionary *main = [dic objectForKey:@"Data"];
        NSDictionary *result = [main objectForKey:@"response"];
        NSDictionary *mainComment = [result objectForKey:@"results"];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
            
            [mainComment writeToFile:fileName atomically:YES];
            NSLog(@"文件写入完成");
        }

        
        successBlock(dic,YES);
        
    }
                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                             
                             NSLog(@"getxsrf failure");
                             
                         }];

    
}

+(void) pubcommentWithParameters :(NSDictionary * ) parm
{
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/pubcomment",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"circle deatil: %@", responseObject);
        NSLog(@"circle deatil: %@", dic);
        
    }
                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                             
                             NSLog(@"getxsrf failure");
                             
                         }];
    
}


+(void) greatWithParameters :(NSDictionary *) parm
{
    NSString *getFirstURL = [NSString stringWithFormat:@"%@/like",[AFNetManager getMainURL]];
    [[AFNetManager manager] POST:getFirstURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"circle deatil: %@", responseObject);
        NSLog(@"circle deatil: %@", dic);
        
    }
                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                             
                             NSLog(@"getxsrf failure");
                             
                         }];
    
}





@end
