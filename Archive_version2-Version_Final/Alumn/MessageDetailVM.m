//
//  MessageDetailVM.m
//  Alumn
//
//  Created by 韩雪滢 on 10/6/16.
//  Copyright © 2016 刘龙飞. All rights reserved.
//

#import "MessageDetailVM.h"

static NSDictionary *messageDic;

@implementation MessageDetailVM

+ (void)setMessageDic:(NSDictionary*)dic{
    
    messageDic = dic;
    
}

+ (NSDictionary*)getMessageDic{
    return messageDic;
}

@end
