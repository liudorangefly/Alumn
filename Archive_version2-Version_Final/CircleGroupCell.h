//
//  CircleGroupCell.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CircleGroupFrame.h"
typedef void (^ImageBlock)(NSArray *imageViews,NSInteger clickTag);
@interface CircleGroupCell : UITableViewCell
@property (nonatomic,strong)CircleGroupFrame *circleGroupFrame;
@property (weak,nonatomic)UIButton *replyButton;
@property (weak,nonatomic)UIButton *likeButton;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (strong,nonatomic)ImageBlock imageBlock;
@end
