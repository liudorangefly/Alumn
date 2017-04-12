//
//  CollectionReusableView.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/23.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{

  self = [super initWithFrame:frame];
  if (self) {

    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 20)];
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.title];
  }
  return self;
}

@end
