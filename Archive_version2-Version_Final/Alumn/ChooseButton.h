//
//  ChooseButton.h
//  PeopleListDemo
//
//  Created by 韩雪滢 on 8/28/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(UIButton*);

@interface ChooseButton : UIButton

@property (nonatomic,copy)ButtonBlock block;
- (void)addTapBlock:(ButtonBlock)block;

@end
