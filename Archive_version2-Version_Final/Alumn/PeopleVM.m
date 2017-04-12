//
//  PeopleVM.m
//  PeopleListDemo
//
//  Created by 韩雪滢 on 8/28/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "PeopleVM.h"
//#import "PeopleViewModel.h"
#import "TextFieldSender.h"
#import "PeopleListVM.h"

@interface PeopleVM()

@property (copy,nonatomic) NSArray *people;
@property (copy,nonatomic) NSDictionary *me;
@property (strong,nonatomic) TextFieldSender *sender;

@end

@implementation PeopleVM

//- (NSArray*)getPeople{
//    _people = [[NSArray alloc] initWithArray:[PeopleViewModel peopleArrayFromPlist]];
//    
//    for(int i = 0;i < _people.count;i++)
//    {
//        NSLog(@"getPeople :%@",_people[i]);
//    }
//    
//    return _people;
//}

//- (NSArray*)reGetPeople{
//    _people = [[NSArray alloc] initWithArray:[PeopleViewModel highSearchFromPlist]];
//    
//    for(int i = 0;i < _people.count;i++)
//    {
//        NSLog(@"getPeople :%@",_people[i]);
//    }
//    
//    return _people;
//
//}

- (NSArray*)matchPeople:(NSArray *)choose{
    
    NSLog(@"执行查询匹配函数");
    
    NSMutableArray *matchResult = [[NSMutableArray alloc] init];
    _people = [[NSArray alloc] initWithArray:[PeopleListVM getFromPlist]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    //得到完整的路径名
    
    //###################################################    获取User的plist内容
    NSString *mePlistPath = [plistPath1 stringByAppendingPathComponent:@"User.plist"];

    _me = [[NSDictionary alloc] initWithContentsOfFile:mePlistPath];
    
    
    if([choose[0] isEqualToString:@"YES"]){
        //处理同院系的  不同年级的  不同城市的
        for(int i = 0;i < _people.count;i++){
            if([[[_people[i] valueForKey:@"_source"] valueForKey:@"faculty"] isEqualToString:[_me valueForKey:@"faculty"]]){
                [matchResult addObject:_people[i]];
            }
        }
        
        if([choose[1] isEqualToString:@"YES"]){
            //处理已经同院系的，选取同年级的  不同城市的
            for(int j = 0;j < matchResult.count; j++){
                if(![[[matchResult[j] valueForKey:@"_source"] valueForKey:@"major"] isEqualToString:[_me valueForKey:@"major"]]){
                    [matchResult removeObject:matchResult[j]];
                }
            }
            
            if([choose[2] isEqualToString:@"YES"]){
                //处理已经 同院系 同年级的，选取 同城市的
                for(int k = 0;k < matchResult.count;k++){
                    if(![[[matchResult[k] valueForKey:@"_source"] valueForKey:@"city"] isEqualToString:[_me valueForKey:@"city"]]){
                        [matchResult removeObject:matchResult[k]];
                    }
                }
            }
            
        }else if([choose[2] isEqualToString:@"YES"]){
            //处理已经同院系的，选取 同城市的 不同年级的
            for(int m =0 ;m < matchResult.count;m++){
                if(![[[matchResult[m] valueForKey:@"_source"] valueForKey:@"city"] isEqualToString:[_me valueForKey:@"city"]]){
                    [matchResult removeObject:matchResult[m]];
                }
            }
        }
        
    }else if([choose[1] isEqualToString:@"YES"]){
        //处理同年级的  不同院系的  不同城市的
        for(int n = 0;n < _people.count; n++){
            if([[[_people[n] valueForKey:@"_source"] valueForKey:@"major"] isEqualToString:[_me valueForKey:@"major"]]){
                [matchResult addObject:_people[n]];
            }
        }
        
        if([choose[2] isEqualToString:@"YES"]){
            //处理同年级的  不同院系的 同城市的
            for(int n1 = 0;n1 < matchResult.count;n1++){
                if(![[[matchResult[n1] valueForKey:@"_source"] valueForKey:@"city"] isEqualToString:[_me valueForKey:@"city"]]){
                    [matchResult removeObject:matchResult[n1]];
                }
            }
        }
        
    }else if([choose[2] isEqualToString:@"YES"]){
        //处理 不同年级的  不同院系的  同一城市的
        for(int b = 0;b < _people.count ; b++){
            if([[[_people[b] valueForKey:@"_source"] valueForKey:@"city"] isEqualToString:[_me valueForKey:@"city"]]){
                [matchResult addObject:_people[b]];
            }
        }
    }else{
         matchResult = [[NSMutableArray alloc] initWithArray:_people];

    }
    
    //不进行处理  不同院系  不同年级   不同城市
    
       
    
    //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  NSLog 输出  测试结果
    
    NSLog(@"匹配结果");
    
    for(int i = 0;i < matchResult.count;i++){
        NSLog(@"%@",matchResult[i]);
    }
    
    return matchResult;
}

- (NSArray*)searchPeople:(NSString *)message{
    NSMutableArray *result = [NSMutableArray alloc];
      _people = [[NSArray alloc] initWithArray:[PeopleListVM getFromPlist]];
    
    for(int i = 0;i < _people.count;i++){
        if([message isEqualToString:[_people[i] valueForKey:@"name"]]){
            [result addObject:_people[i]];
        }
        if([message isEqualToString:[_people[i] valueForKey:@"major"]]){
            [result addObject:_people[i]];
        }
        if([message isEqualToString:[_people[i] valueForKey:@"faculty"]]){
            [result addObject:_people[i]];
        }
        if([message isEqualToString:[_people[i] valueForKey:@"job"]]){
            [result addObject:_people[i]];
        }
        if([message isEqualToString:[_people[i] valueForKey:@"city"]]){
            [result addObject:_people[i]];
        }

    }
    
    return result;
}

@end
