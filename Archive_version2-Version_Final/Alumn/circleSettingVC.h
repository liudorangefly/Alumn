//
//  circleSettingVC.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/29.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDragButton.h"

@interface circleSettingVC : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property(strong,nonatomic)UIDragButton *dargbutton;
@property (weak, nonatomic) IBOutlet UITextField *circleName;
@property (weak, nonatomic) IBOutlet UITextField *cicrlceSetWorld;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel1;
@property (weak, nonatomic) IBOutlet UILabel *secondLable2;


@end
