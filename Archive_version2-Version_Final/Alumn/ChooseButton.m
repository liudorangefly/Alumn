//
//  ChooseButton.m
//  PeopleListDemo
//
//  Created by 韩雪滢 on 8/28/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "ChooseButton.h"

@implementation ChooseButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addTapBlock:(ButtonBlock)block{
    _block = block;
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(UIButton*)button{
    _block(button);
}



@end
