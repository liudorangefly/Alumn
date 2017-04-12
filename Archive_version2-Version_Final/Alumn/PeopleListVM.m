//
//  PeopleListVM.m
//  XDRefresh
//
//  Created by 韩雪滢 on 10/2/16.
//  Copyright © 2016 蔡欣东. All rights reserved.
//

#import "PeopleListVM.h"
#import "StaticData.h"


@implementation PeopleListVM

+ (void)saveInPlist:(NSDictionary *)dict{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    
    NSLog(@"%@",plistPath1);
    //得到完整的路径名
    
    //计算当前的文件个数
    NSInteger pageNum = [StaticData getPeopleSize] /10;
    if([StaticData getPeopleSize] % 10 != 0){
        pageNum += 1;
    }
    
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"peopleList_%@.plist",[NSNumber numberWithInteger:pageNum]]];
    NSArray *response = [dict objectForKey:@"peopleArray"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [response writeToFile:fileName atomically:YES];
        NSLog(@"peopleListCircle文件写入完成");
    }

}

+ (NSArray*)getFromPlist{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    
    //计算当前文件的个数
    
    NSLog(@"StaticData getPeopleSize的输出 %@",[NSNumber numberWithInteger:[StaticData getPeopleSize]]);
    
    NSInteger pageNum = [StaticData getPeopleSize] / 10;
    if([StaticData getPeopleSize] % 10 != 0){
        pageNum += 1;
    }
    
    for(int i = 0;i < pageNum ; i++){
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"peopleList_%@.plist",[NSNumber numberWithInteger:(i+1)]]];
        
        NSLog(@"文件名 %@",fileName);
        
        NSArray *temp = [NSArray arrayWithContentsOfFile:fileName];
        
        [result addObjectsFromArray:temp];
        
    }
    
    NSLog(@"result的个数为 %@",[NSNumber numberWithInteger:result.count]);

    return result;
}



@end
