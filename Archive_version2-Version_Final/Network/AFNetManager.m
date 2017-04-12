//
//  AFNetManger.m
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "AFNetManager.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"


@implementation AFNetManager
#pragma mark - 创建请求者
+(AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    //设置允许接收返回数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    // manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    return manager;
}

//+ (void)getUserCarShopAndSalesDataForSalesWithUserId:(NSString *)userId date:(NSString *)date selectAreaType:(NSString *)areaType Success:(SuccessBlock)success fail:(AFNErrorBlock)fail
//{
//    // get请求也可以直接将参数放在字典里，AFN会自己讲参数拼接在url的后面，不需要自己凭借
//    NSDictionary *param = @{@"user_id":userId, @"sale_date":date, @"accessToken":@"e9c0e60318ebd07ec2fe", @"area_type":areaType};
//    // 创建请求类
//    AFHTTPSessionManager *manager = [self manager];
//    [manager GET:@"http://pm.yunhan-china.com/index.php/Api_sale/sales_get" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
//        // 这里可以获取到目前数据请求的进度
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        // 请求成功
//        if(responseObject){
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            success(dict,YES);
//        } else {
//            success(@{@"msg":@"暂无数据"}, NO);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        // 请求失败
//        fail(error);
//    }];
//}

//+ (void)loginWithUserAccount:(NSString *)account password:(NSString *)password success:(SuccessBlock)success fail:(AFNErrorBlock)fail
//{
//    // 将请求参数放在请求的字典里
//    NSDictionary *param = @{@"phoneNumber":account, @"password":@"f379eaf3c831b04de153469d1bec345e"};
//    // 创建请求类
//    AFHTTPSessionManager *manager = [self manager];
//    [manager POST:@"http://pm.yunhan-china.com/index.php/api_common/login" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
//        // 这里可以获取到目前数据请求的进度
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        // 请求成功
//        if(responseObject){
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            success(dict,YES);
//        } else {
//            success(@{@"msg":@"暂无数据"}, NO);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        // 请求失败
//        fail(error);
//    }];
//    
//}


//- (void)downLoadWithUrlString:(NSString *)urlString
//{
//    // 1.创建管理者对象
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    // 2.设置请求的URL地址
//    NSURL *url = [NSURL URLWithString:urlString];
//    // 3.创建请求对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    // 4.下载任务
//    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        // 下载进度
//        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        // 下载地址
//        NSLog(@"默认下载地址%@",targetPath);
//        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
//        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
//        return [NSURL fileURLWithPath:filePath]; // 返回的是文件存放在本地沙盒的地址
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        // 下载完成调用的方法
//        NSLog(@"%@---%@", response, filePath);
//    }];
//    // 5.启动下载任务
//    [task resume];
//}

+ (NSString*)getMainURL{
    
    NSLog(@"getMainURL");
    
    return @"http://139.196.207.155:8000";
//    return @"http://192.168.2.5:8000";
}


- (NSString *)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    static NSString *str = nil;

    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
                switch (status) {
            case AFNetworkReachabilityStatusUnknown:
               str=@"未知网络状态";
                break;
            case AFNetworkReachabilityStatusNotReachable:
               str= @"无网络";
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                str = @"蜂窝数据网";
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                str= @"WiFi网络";
                
                break;
                
            default:
                break;
        }
           }] ;
    return str;

}

+(NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
@end
