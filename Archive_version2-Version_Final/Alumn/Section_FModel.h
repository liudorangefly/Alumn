//
//  SectionModel.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/23.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section_FModel : NSObject

//定义Section头的名字；
@property(nonatomic,copy) NSString *sectionName;
//定义Section中的cell数组；
@property(nonatomic,strong) NSMutableArray *cellArray;//这里存放的是section中的每一个cell；

@end
