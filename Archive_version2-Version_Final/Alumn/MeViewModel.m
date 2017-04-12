//
//  MeViewModel.m
//  netdemo1
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 Dorangefly Liu. All rights reserved.
//

#import "MeViewModel.h"

@implementation MeViewModel

- (void)getMyAdminCircleList:(NSDictionary *)Data{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    
    NSLog(@"%@",plistPath1);
    //得到完整的路径名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"myAdminCircle.plist"];
    NSArray *response = [Data objectForKey:@"response"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [response writeToFile:fileName atomically:YES];
        NSLog(@"myAdminCircle文件写入完成");
    }
    
}

- (void)getMyCreateCircleList:(NSDictionary *)Data{
    
    NSLog(@"查看创建的圈子:%@",Data);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    
    NSLog(@"%@",plistPath1);
    //得到完整的路径名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"myCreateCircle.plist"];
    NSArray *response = [Data objectForKey:@"response"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [response writeToFile:fileName atomically:YES];
        NSLog(@"myCreateCircle文件写入完成");
    }
    
}

- (void)getMyCardsList:(NSDictionary *)Data{
    NSLog(@"查看收藏的卡片:%@",Data);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    
    NSLog(@"%@",plistPath1);
    //得到完整的路径名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"myCollectCards.plist"];
    NSArray *response = [Data objectForKey:@"response"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [response writeToFile:fileName atomically:YES];
        NSLog(@"myCollectCards文件写入完成");
    }
}


+ (NSArray*)adminCircleFromPlist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"myAdminCircle.plist"];
    NSMutableDictionary *adminCirclesDic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
    NSArray *adminCiclesArray = [adminCirclesDic objectForKey:@"results"];
    return adminCiclesArray;
}

+ (NSArray*)createCircleFromPlist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"myCreateCircle.plist"];
    NSMutableDictionary *createCirclesDic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
    NSArray *createCiclesArray = [createCirclesDic objectForKey:@"results"];
    return createCiclesArray;
}

+ (NSArray*)collectCardsFromPlist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"myCollectCards.plist"];
    NSMutableDictionary *collectCardsDic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
    NSArray *collectCardsArray = [collectCardsDic objectForKey:@"results"];
    return collectCardsArray;
}

@end
