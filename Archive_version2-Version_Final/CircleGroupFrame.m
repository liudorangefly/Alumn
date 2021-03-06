//
//  CircleGroupFrame.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "CircleGroupFrame.h"
#import "HeaderContent.h"
#define nameFont [UIFont systemFontOfSize:15]
#define shuoshuotextFont [UIFont systemFontOfSize:14]
#define replytextFont [UIFont systemFontOfSize:14]

@implementation CircleGroupFrame

-(void)setCircleGroup:(CircleGroup *)circleGroup
{
    _circleGroup = circleGroup;
    
    //iconF头像
    CGFloat iconViewX = padding;
    CGFloat iconViewY = padding;
    CGFloat iconViewWidth = 40;
    CGFloat iconViewHeight = 40;
    self.iconF = CGRectMake(iconViewX, iconViewY, iconViewWidth, iconViewHeight);
    
    //nameF昵称
    CGFloat nameLabelX = CGRectGetMaxX(self.iconF) + padding;
    CGSize nameLabelSize = [self sizeWithString:self.circleGroup.name font:nameFont maxSize:CGSizeMake(MAXFLOAT,MAXFLOAT)];
    CGFloat nameLabelY = iconViewY;
    CGFloat nameLabelWidth = nameLabelSize.width;
    CGFloat nameLabelHeight = nameLabelSize.height;
    self.nameF = CGRectMake(nameLabelX, nameLabelY, nameLabelWidth, nameLabelHeight);
    
    //shuoshuotextF正文
    CGFloat shuoshuotextLabelX = nameLabelX;
    CGFloat shuoshuotextLabelY = CGRectGetMaxY(self.nameF) + padding/2;
    CGSize shuoshuotextLabelSize = [self sizeWithString:self.circleGroup.shuoshuoText font:shuoshuotextFont maxSize:CGSizeMake(screenWidth - nameLabelX - padding, MAXFLOAT)];
    CGFloat shuoshuotextLabelWidth = shuoshuotextLabelSize.width;
    CGFloat shuoshuotextLabelHeight = shuoshuotextLabelSize.height;
    self.shuoshuotextF = CGRectMake(shuoshuotextLabelX, shuoshuotextLabelY, shuoshuotextLabelWidth, shuoshuotextLabelHeight);
    
    //picturesF发的图片
    if ([self.circleGroup.pictures count]) {
        CGFloat picturesViewWidth;
        CGFloat picturesViewHeight;
        if ([self.circleGroup.pictures count] == 1) {   //图片会大点
            picturesViewWidth = 240;
            picturesViewHeight = 375;
        }
        else
        {
            picturesViewWidth = 80;
            picturesViewHeight = 80;
            
        }
        for (int i = 0; i < [self.circleGroup.pictures count]; i++) {
            CGFloat picturesViewX = nameLabelX + (i%3)*(picturesViewWidth + padding);
            CGFloat picturesViewY = CGRectGetMaxY(self.shuoshuotextF) + padding + (padding + picturesViewHeight)*(i/3);
            CGRect pictureF = CGRectMake(picturesViewX, picturesViewY, picturesViewWidth, picturesViewHeight);
            [self.picturesF addObject:[NSValue valueWithCGRect:pictureF]];   //NSValue可以封装c/c++类型，让ios数组能够添加
        }
        self.cellHeight = CGRectGetMaxY([(NSValue *)[self.picturesF lastObject] CGRectValue]) + padding;
    }
    else
    {
        self.cellHeight = CGRectGetMaxY(self.shuoshuotextF) + padding;
    }
    
    
    //时间戳
    CGFloat timeLabelWidth = 150;
    CGFloat timeLabelHeight = 15;
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = self.cellHeight;
    self.timeF = CGRectMake(timeLabelX, timeLabelY, timeLabelWidth, timeLabelHeight);
    //评论按钮
    CGFloat replyButtonWidth = 35;
    CGFloat replyButtonHeight = 25;
    CGFloat replyButtonX = screenWidth - padding - replyButtonWidth;
    CGFloat lileButtonX=screenWidth -padding -replyButtonWidth*2;
    CGFloat likeButtonY=self.cellHeight+5;
    CGFloat likeButtonWidth =35;
    CGFloat likeButtonHeight =25;
    CGFloat replyButtonY = self.cellHeight;
    //NSLog(@"%f",replyButtonY);
    self.replyF = CGRectMake(replyButtonX, replyButtonY, replyButtonWidth, replyButtonHeight);
    self.likeF = CGRectMake(lileButtonX, likeButtonY, likeButtonWidth,likeButtonHeight );
    
    self.cellHeight = CGRectGetMaxY(self.replyF) + padding;
    //评论
    if([self.circleGroup.replys count])
    {
        CGFloat replyLabelX = nameLabelX + padding/2;
        for (int i = 0; i < [self.circleGroup.replys count]; i++) {
            CGSize replyLabelSize = [self sizeWithString:[self.circleGroup.replys objectAtIndex:i] font:replytextFont maxSize:CGSizeMake(screenWidth - 2*padding - nameLabelX, MAXFLOAT)];
            CGFloat replyLabelY = self.cellHeight+15;
            CGFloat replyLabelWidth = replyLabelSize.width;
            CGFloat replyLabelHeight = replyLabelSize.height;
            self.cellHeight += padding +replyLabelHeight;
            CGRect replyF = CGRectMake(replyLabelX, replyLabelY, replyLabelWidth, replyLabelHeight);
            [self.replysF addObject:[NSValue valueWithCGRect:replyF]];
        }
        
        //评论的背景
        self.cellHeight = CGRectGetMaxY([(NSValue *)[self.replysF lastObject] CGRectValue]) + padding;
        CGFloat replyBackgroundWidth = screenWidth - 1.5*padding -nameLabelX;
        CGFloat replyBackgroundHeight = self.cellHeight - padding*2 - CGRectGetMaxY(self.replyF);
         self.replyBackgroundF = CGRectMake(nameLabelX, CGRectGetMaxY(self.replyF) + padding, replyBackgroundWidth, replyBackgroundHeight);

    }
}

-(NSMutableArray *)replysF
{
    if (!_replysF) {
        _replysF = [[NSMutableArray alloc]init];
    }
    return _replysF;
}

-(NSMutableArray *)picturesF
{
    if (!_picturesF) {
        _picturesF = [[NSMutableArray alloc]init];
    }
    return _picturesF;
}

/*  计算文本的高
 @param str   需要计算的文本
 @param font  文本显示的字体
 @param maxSize 文本显示的范围，可以理解为limit
 
 @return 文本占用的真实宽高
 */

-(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}


@end
