//
//  CollectionViewCell.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/23.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIView+SDAutoLayout.h"

#define UISCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define CELL_WIDTH (([[UIScreen mainScreen] bounds].size.width - 40) / 2)

@implementation CollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{

  self = [super initWithFrame:frame];
  if (self) {
    //这里需要初始化ImageView；
      //self.imageView = [[UIImageView alloc]init];
      self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - (UISCREEN_WIDTH - 40) / 2 +15, self.frame.size.width-(UISCREEN_WIDTH - 40) / 2 -0, 140, 140)];
      
    //[self.imageView setUserInteractionEnabled:true];
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width - (UISCREEN_WIDTH - 40) / 6 + 30, (UISCREEN_WIDTH - 40) / 3+60, 20)];
      //self.descLabel.backgroundColor= [UIColor whiteColor];
      //self.descLabel = [[UILabel alloc] init];
      //self.descLabel.sd_layout
      //.heightIs(20)
      //.widthIs(140)
      //.topSpaceToView(self.contentView,0)
     //.centerYEqualToView(self.imageView);
      self.descLabel.shadowColor= [UIColor whiteColor];
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.text = @"111";
    self.descLabel.font = [UIFont systemFontOfSize:16];
    self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(CELL_WIDTH -20, -5, 30, 30)];
    [self.deleteButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    //先设置不可见；
    [self.deleteButton setHidden:true];
    
    //self.layer.borderWidth = 0;
    [self addSubview:self.imageView];
    [self addSubview:self.descLabel];
    [self addSubview:self.deleteButton];
  }
  return self;
}



@end
