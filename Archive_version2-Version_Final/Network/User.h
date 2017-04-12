//
//  User.h
//  netdemo1
//
//  Created by Dorangefly Liu on 16/9/5.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MeViewModel.h"



static const NSString *xrsf;

@interface User : NSObject
@property (assign,nonatomic) NSInteger uid;
@property (strong,nonatomic) NSString *icon_url;
@property (assign,nonatomic) NSInteger admission_year;
@property (strong,nonatomic) NSString *faculty;
@property (strong,nonatomic) NSString *major;
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger gender;

@property (strong,nonatomic) NSString *genderString;

@property (strong,nonatomic) NSString *job;
@property (strong,nonatomic) NSString *city;
@property (strong,nonatomic) NSString *tags;
@property (strong,nonatomic) NSString *instroduction;
@property (strong,nonatomic) NSString *my_circle_list;
@property (strong,nonatomic) NSString *company;
@property (assign,nonatomic) NSInteger company_publicity_level;
@property (strong,nonatomic) NSString *public_contact_list;
@property (strong,nonatomic) NSString *protect_contact_list;
@property (strong,nonatomic) NSString *job_list;
@property (strong,nonatomic) NSString *job_list_level;
@property NSTimeInterval *last_update_time;
@property (strong,nonatomic) NSString *admin_circle_list;
@property (strong,nonatomic) NSString *create_circle_list;
@property (strong,nonatomic) NSString *state;
@property (strong,nonatomic) NSString *country;

//-----------------------------------------------   telephone for register
@property (strong,nonatomic) NSString *telephone;
@property (strong,nonatomic) NSString *password;

@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *pwd;
//-----------------------------------------------

@property (strong,nonatomic)UIImage *userHeadImg;

+(NSString *) getXrsf;
+(void) setXrsf :(NSString *) str;
+ (MeViewModel*)meVM;

@end
