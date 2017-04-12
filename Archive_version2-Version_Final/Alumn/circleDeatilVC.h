//
//  circleDeatilVC.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/26.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDragButton.h"
static NSString *IDinList;
@interface circleDeatilVC : UIViewController
//@property (weak, nonatomic) IBOutlet UIDragButton *setButton;
@property (weak, nonatomic) IBOutlet UIImageView *ciecleDeatilMask2;

@property (weak, nonatomic) IBOutlet UIButton *setButton1;
@property (weak, nonatomic) IBOutlet UIButton *setButton2;
@property (weak, nonatomic) IBOutlet UIButton *setButton3;
@property (weak, nonatomic) IBOutlet UIButton *ExitButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UINavigationBar *NavBar;
@property (weak, nonatomic) IBOutlet UILabel *cicrleName;
@property (weak, nonatomic) IBOutlet UILabel *numbers;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) circleDeatilVC *current;
//@property (weak, nonatomic) IBOutlet UIView *floatview;
@property(strong,nonatomic)UIDragButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundimage;
@property (weak, nonatomic) NSString *backgroundUrl;
@property (weak , nonatomic) NSString *number;
@property (weak , nonatomic)NSString *circleNameStr;
@property (weak , nonatomic) NSNumber *page;

-(void)hidden:(UIButton *) mybutton;

+(NSString *) getIDinList;
+(void) setIDinList :(NSString *) str;
@end
