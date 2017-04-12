//
//  MessageViewModel.m
//  scrollViewDamo
//
//  Created by 韩雪滢 on 9/11/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import "MessageViewModel.h"

@implementation MessageViewModel

//+ (void)messageListSaveInPlist:(NSArray *)response{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *plistPath1= [paths objectAtIndex:0];
//    
//    NSLog(@"%@",plistPath1);
//    //得到完整的路径名
//    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"messageList.plist"];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
//        
//        [response writeToFile:fileName atomically:YES];
//        NSLog(@"messageList.plist文件写入完成");
//    }
//}

+ (NSArray*)messageListFromPlist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"messageList.plist"];
    NSArray *messageArray = [NSArray arrayWithContentsOfFile:fileName];
    
    for(int i = 0; i < messageArray.count; i++){
        NSLog(@"从messagePlist中得到：%@",[messageArray[i] valueForKey:@"message"]);
    }
    
    return messageArray;
}

//+ (NSArray*)getApplyInCircle{
//    
//    NSMutableArray *applyInArray = [[NSMutableArray alloc] init];
//    
//    for (int i = 0;i < [self messageListFromPlist].count ; i++){
//        NSLog(@"getApplyINCircle :%d",i);
//        NSLog(@"messageType %@",[[self messageListFromPlist][i] valueForKey:@"type"]);
//        if([[[self messageListFromPlist][i] valueForKey:@"type"] intValue] == 4){
//            [applyInArray addObject:[self messageListFromPlist][i]];
//            NSLog(@"ApplyIn: %@",[[[self messageListFromPlist][i] valueForKey:@"message"]valueForKey:@"circle_name"]);
//        }
//    }
//    
//    return [[NSArray alloc] initWithArray:applyInArray];
//}
//
//+ (NSArray*)getApplyResult{
//    
//    NSMutableArray *applyResultsArray = [[NSMutableArray alloc] init];
//    for (int i = 0;i < [self messageListFromPlist].count ; i++){
//        if([[[self messageListFromPlist][i] valueForKey:@"type"] intValue] == 3){
//            [applyResultsArray addObject:[self messageListFromPlist][i]];
//            NSLog(@"ApplyResult: %@",[self messageListFromPlist][i]);
//        }
//    }
//    
//    return [[NSArray alloc] initWithArray:applyResultsArray];
//}
//
//+ (NSArray*)getNewMemberIn{
//    NSMutableArray *newMemberIn = [[NSMutableArray alloc] init];
//    for (int i = 0;i < [self messageListFromPlist].count ; i++){
//        if([[[self messageListFromPlist][i] valueForKey:@"type"] intValue] == 2){
//            [newMemberIn addObject:[self messageListFromPlist][i]];
//            NSLog(@"NewMemberIn: %@",[self messageListFromPlist][i]);
//        }
//    }
//    
//    return [[NSArray alloc] initWithArray:newMemberIn];
//    
//}
//
//+ (NSArray*)createSucccessArray{
//    NSMutableArray *createSuccess = [[NSMutableArray alloc] init];
//    for (int i = 0;i < [self messageListFromPlist].count ; i++){
//        if([[[self messageListFromPlist][i] valueForKey:@"type"] intValue] == 0){
//            [createSuccess addObject:[self messageListFromPlist][i]];
//            NSLog(@"CreateSuccess: %@",[self messageListFromPlist][i]);
//        }
//    }
//    
//    return [[NSArray alloc] initWithArray:createSuccess];
//}
//
//+ (NSArray*)createFailureArray{
//    
//    NSMutableArray *createFailure = [[NSMutableArray alloc] init];
//    for (int i = 0;i < [self messageListFromPlist].count ; i++){
//        if([[[self messageListFromPlist][i] valueForKey:@"type"] intValue] == 1){
//            [createFailure addObject:[self messageListFromPlist][i]];
//            NSLog(@"CreateFailure: %@",[self messageListFromPlist][i]);
//        }
//    }
//    
//    return [[NSArray alloc] initWithArray:createFailure];
//    
//}

//---------------------------------------- 评论
//+ (void)commentListSaveInPlist:(NSDictionary *)response{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *plistPath1= [paths objectAtIndex:0];
//    
//    NSLog(@"%@",plistPath1);
//    //得到完整的路径名
//    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"commentList.plist"];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
//        
//        [response writeToFile:fileName atomically:YES];
//        NSLog(@"commentList.plist文件写入完成");
//    }
//    
//}
+ (NSArray*)commentListFromPlist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"commentList.plist"];
    NSArray *commentList = [NSArray arrayWithContentsOfFile:fileName];
    return commentList;
}



@end
