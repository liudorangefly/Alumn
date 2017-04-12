//
//  DemoVC5.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/28.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSMutableDictionary *currentCell;
@interface DemoVC5 : UITableViewController
@property (weak,nonatomic) NSString* IDINlIST;
+(NSDictionary *)getCurrentCell;
+(void) setCurrentCellLike:(NSString *)str;

@end
