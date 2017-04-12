//
//  PeopleViewModel.h
//  netdemo1
//
//  Created by 韩雪滢 on 9/9/16.
//  Copyright © 2016 Dorangefly Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleViewModel : NSObject

+ (void)peoleListSaveInPlist:(NSDictionary*)Data;
+ (NSArray*)peopleArrayFromPlist;
+ (void)highSearchSaveInplist:(NSDictionary*)Data;
+ (NSArray*)highSearchFromPlist;

@end
