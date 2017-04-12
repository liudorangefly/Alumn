//
//  CellModel.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/23.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

//定义cell中的图片；
@property(nonatomic,strong) NSString *cellImage;
//定义cell中的描述文字；
@property(nonatomic,strong) NSString *cellDesc;
@property(nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *numbers;
@property (nonatomic,strong) NSNumber *Atpage;

+(id)modelWithDict:(NSDictionary *)dict;

@end
