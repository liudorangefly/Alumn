//
//  CircleViewController.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#import <UIKit/UIKit.h>
static int myIntstat;
static NSString *liked;
@interface CircleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *like_btn;
@property (weak, nonatomic) IBOutlet UIButton *reply_btn;
@property (weak, nonatomic) IBOutlet UILabel *numbers;
@property (weak, nonatomic) NSString *name;
@property (weak, nonatomic) NSString *icon_url;
@property (weak, nonatomic) NSString *time;
@property (weak,nonatomic) NSString *content;
@property (weak, nonatomic) NSArray *img_urls;


@end
