//
//  Circle_FindVC.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/30.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAltview.h"
@interface Circle_FindVC : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (strong ,nonatomic) MyAltview *alt;
@property (strong,nonatomic) UIView *darkview;
@property (strong ,nonatomic) NSString *ID;

+(void) animationAlert:(UIView *)view;

@end
