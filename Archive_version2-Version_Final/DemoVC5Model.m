//
//  DemoVC5Model.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/28.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#import "DemoVC5Model.h"

@implementation DemoVC5Model
-(id)initWithDict:(NSDictionary *)dict page:(NSNumber *)page ID:(NSString *)id
{
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        self.content = [dict objectForKey:@"content"];
        self.create_time = [dict objectForKey:@"create_time"];
        self.image_urls = [dict objectForKey:@"image_urls" ];
        NSDictionary *creator = [dict objectForKey:@"creator"];
        //self.icon_url = [creator objectForKey:@"icon_url"];
        NSString *cut = [creator objectForKey:@"name"];
        self.name= [cut substringFromIndex:11];
        self.icon_url= [creator objectForKey:@"icon_url"];
        self.feed_id= [dict objectForKey:@"id"];
        NSDictionary *stat = [dict objectForKey:@"stats"];
        self.liked_num = [stat objectForKey:@"liked"];
        self.liked = [dict objectForKey:@"liked"];
        self.Atpage=page;
        self.ID =id;
        }
    return self;
}

+(id)modelWithDict:(NSDictionary *)dict page:(NSNumber *)page ID:(NSString*)id
{
    return [[self alloc]initWithDict:dict page:page ID:id];
}

@end
