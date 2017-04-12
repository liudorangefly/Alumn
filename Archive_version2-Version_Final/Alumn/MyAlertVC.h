//
//  MyAlertVC.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/31.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAltview.h"

@interface MyAlertVC : UIViewController
@property (strong ,nonatomic) MyAltview *alt;
@property (weak, nonatomic) IBOutlet UIImageView *backview;

-(UIImage*) imageWithColor:(UIColor*)color;

@end
