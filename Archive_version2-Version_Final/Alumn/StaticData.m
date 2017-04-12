//
//  StaticData.m
//  staticDemo
//
//  Created by 韩雪滢 on 10/3/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "StaticData.h"

static NSInteger peoplePage = 1;
static NSInteger peopleSize = 0;

@implementation StaticData

+ (void)setPeopleSize:(NSInteger)size{
    peopleSize = peopleSize + size;
    [self setPeoplePage:peopleSize];
}

+ (void)setPeoplePage:(NSInteger)size{
    if(0 == size % 10){
        peoplePage = size / 10 + 1;
    }else{
        peoplePage = -1;
    }
}

+ (NSInteger)getPeopleSize{
    return peopleSize;
}

+ (NSInteger)getPeoplePage{
    return peoplePage;
}

@end
