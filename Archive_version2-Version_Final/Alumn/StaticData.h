//
//  StaticData.h
//  staticDemo
//
//  Created by 韩雪滢 on 10/3/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaticData : NSObject

+ (void)setPeopleSize:(NSInteger)size;
+ (void)setPeoplePage:(NSInteger)size;
+ (NSInteger)getPeopleSize;
+ (NSInteger)getPeoplePage;


@end
