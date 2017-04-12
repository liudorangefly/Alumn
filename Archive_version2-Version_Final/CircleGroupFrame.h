//
//  CircleGroupFrame.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CircleGroup.h"
@interface CircleGroupFrame : NSObject
@property (nonatomic,assign)CGRect iconF;
@property (nonatomic,assign)CGRect nameF;
@property (nonatomic,assign)CGRect shuoshuotextF;
@property (nonatomic,strong)NSMutableArray *picturesF;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,assign)CGRect timeF;

@property (nonatomic,assign)CGRect replyF;
@property (nonatomic,assign)CGRect likeF;
@property (nonatomic,strong)NSMutableArray *replysF;
@property (nonatomic,assign)CGRect replyBackgroundF;
@property(nonatomic,strong)CircleGroup *circleGroup;
@end
