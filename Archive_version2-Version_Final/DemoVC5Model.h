//
//  DemoVC5Model.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/28.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface DemoVC5Model : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSArray *image_urls;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *feed_id;
@property (nonatomic, copy) NSNumber *liked_num;
@property  (nonatomic, copy) NSString *liked;
@property (nonatomic ,copy) NSNumber *Atpage;
@property (nonatomic, copy) NSString *ID;

+(id)modelWithDict:(NSDictionary *)dict page:(NSNumber *)page ID:(NSString *)id;

@end
