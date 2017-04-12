//
//  TransDetail.h
//  Alumn
//
//  Created by 韩雪滢 on 9/25/16.
//  Copyright © 2016 刘龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransDetail : NSObject

@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSInteger index;

+ (TransDetail*)getTrans;

@end
