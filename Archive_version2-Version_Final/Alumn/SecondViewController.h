//
//  SecondViewController.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/23.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
static int page =1;
@interface SecondViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *view;

+(int) getPage;
+(void) setPage :(int) num;
+(void) setPageAdd1;
@end
