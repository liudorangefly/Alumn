//
//  RRCustomScrollView.m
//  SendNewsDemo
//
//  Created by 韩雪滢 on 8/30/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "RRCustomScrollView.h"

@implementation RRCustomScrollView


- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UIButton class]])
        return YES;
    return NO;
}



@end
