//
//  MessageViewModel.h
//  scrollViewDamo
//
//  Created by 韩雪滢 on 9/11/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageViewModel : NSObject

//+ (void)messageListSaveInPlist:(NSArray*)response;
//+ (NSArray*)getApplyInCircle;
//+ (NSArray*)getApplyResult;
//+ (NSArray*)getNewMemberIn;
//+ (NSArray*)createSucccessArray;
//+ (NSArray*)createFailureArray;
//+ (void)commentListSaveInPlist:(NSDictionary*)response;


+ (NSArray*)commentListFromPlist;
+ (NSArray*)messageListFromPlist;



@end
