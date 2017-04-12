//
//  UITableView+Improve.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#import "UITableView+Improve.h"

@implementation UITableView (Improve)
-(void)improveTableView
{
    self.tableFooterView = [[UIView alloc]init];  //删除多余的行
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {  //防止分割线显示不
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
