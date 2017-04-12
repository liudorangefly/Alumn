//
//  PeopleListVM.h
//  XDRefresh
//
//  Created by 韩雪滢 on 10/2/16.
//  Copyright © 2016 蔡欣东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleListVM : NSObject

+ (void)saveInPlist:(NSDictionary*)dict;
+ (NSArray*)getFromPlist;

@end
