//
//  PeopleViewModel.m
//  netdemo1
//
//  Created by 韩雪滢 on 9/9/16.
//  Copyright © 2016 Dorangefly Liu. All rights reserved.
//

#import "PeopleViewModel.h"

@implementation PeopleViewModel

+ (void)peoleListSaveInPlist:(NSDictionary *)Data{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    
    NSLog(@"%@",plistPath1);
    //得到完整的路径名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"peopleList.plist"];
    NSArray *response = [Data objectForKey:@"response"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [response writeToFile:fileName atomically:YES];
        NSLog(@"peopleListCircle文件写入完成");
    }
}

+ (NSArray*)peopleArrayFromPlist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"peopleList.plist"];
    NSMutableDictionary *peopleDic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
    NSArray *peopleList = [[peopleDic valueForKey:@"hits"]valueForKey:@"hits"];
    
    return peopleList;
}

+ (void)highSearchSaveInplist:(NSDictionary *)Data{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    
    NSLog(@"%@",plistPath1);
    //得到完整的路径名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"highSearchList.plist"];
    NSArray *response = [Data objectForKey:@"response"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [response writeToFile:fileName atomically:YES];
        NSLog(@"highSearchListCircle文件写入完成");
    }
    
}

+ (NSArray*)highSearchFromPlist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"highSearchList.plist"];
    NSMutableDictionary *highSearchDic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
    NSArray *highSearchList = [[highSearchDic valueForKey:@"hits"]valueForKey:@"hits"];
    
    return highSearchList;
}


@end
