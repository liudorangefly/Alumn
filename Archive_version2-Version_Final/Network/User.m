//
//  User.m
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "User.h"

@implementation User
+(NSString *) getXrsf
{
    extern NSString *xrsf;
    return xrsf;
}
+(void) setXrsf:str
{
    xrsf = str;
}

+ (MeViewModel*)meVM{
    MeViewModel *meVM = [[MeViewModel alloc] init];
    return meVM;
}


@end
