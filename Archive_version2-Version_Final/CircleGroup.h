//
//  CircleGroup.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleGroup : NSObject
@property (strong,nonatomic)NSString *icon;  //头像
@property (strong,nonatomic)NSString *name;  //昵称
@property (strong,nonatomic)NSString *shuoshuoText; //说说
@property (strong,nonatomic)NSString *time;    //发表的时间,存的是nadate，应该要有时间操作
@property (strong,nonatomic)NSArray *pictures;   //发表的图片
@property (strong,nonatomic)NSMutableArray *replys;   //评论
@property (strong, nonatomic)NSNumber *like_num;
@property (strong, nonatomic) NSNumber *page;
@property Boolean like;
#pragma mark - 最后要考虑是暂存coredata里还是plist文件里
-(id)initWithDict:(NSDictionary *)dict;
-(void)initcomment:(NSArray *)arry;
@end
