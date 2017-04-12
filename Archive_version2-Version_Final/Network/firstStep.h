//
//  firstStep.h
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Circle.h"

@interface firstStep : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) User *user;
@property (nonatomic,strong) Circle *circle;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

@end
