//
//  MyUiButton.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/26.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "MyUiButton.h"

@implementation MyUiButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)hidden{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 4;
    [self.layer addAnimation:animation forKey:nil];
    
    self.hidden = YES;
}

@end
