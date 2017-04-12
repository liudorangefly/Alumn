//
//  TransDetail.m
//  Alumn
//
//  Created by 韩雪滢 on 9/25/16.
//  Copyright © 2016 刘龙飞. All rights reserved.
//

#import "TransDetail.h"

@implementation TransDetail


+ (TransDetail*)getTrans{
    
    static dispatch_once_t dec;
    static TransDetail *transDetail;

    
    dispatch_once(&dec, ^{
        transDetail = [[TransDetail alloc] init];
    });
    
    return transDetail;
}

@end
