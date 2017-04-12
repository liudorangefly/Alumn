//
//  CircleGroup.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "CircleGroup.h"

@implementation CircleGroup
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        //[self setValuesForKeysWithDictionary:dict];
        self.icon = [dict objectForKey:@"icon_url"];
        self.pictures = [dict objectForKey:@"img_urls"];
        self.time =[dict objectForKey:@"create_time"];
        self.name = [dict objectForKey:@"name"];
        self.shuoshuoText =[dict objectForKey:@"content"];
        self.like_num =[dict objectForKey:@"liked_num"];
        self.page = [dict objectForKey:@"page"];
        
    }
    return self;
}

-(void)initcomment:(NSArray *)arry
{
    NSMutableArray *convert= [[NSMutableArray alloc]init];
    for(NSDictionary *dict in arry)
    {
        if (arry.count!=0)
        {
        NSDictionary *CREA = [dict objectForKey:@"creator"];
        NSString *cut = [CREA objectForKey:@"name"];
        NSString *name= [cut substringFromIndex:11];
        NSArray *content = [dict objectForKey:@"content"];
        NSString *comment =[[NSString alloc]initWithFormat:@"%@ :%@",name,content];
        NSLog(@"%@",comment);
        [convert addObject:comment];
        }
    }
    self.replys=convert;
}

+(id)circleGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
