//
//  MeInfoViewModel.h
//  MeInfoDemo
//
//  Created by 韩雪滢 on 9/1/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeInfoViewModel : NSObject

@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *job;
@property (copy,nonatomic) NSString *city;

@property (assign,nonatomic) BOOL followedOrNot;

@property (copy,nonatomic) NSString *uid;

@property (copy,nonatomic) NSString *school;
@property (copy,nonatomic) NSString *major;
@property (copy,nonatomic) NSString *classNum;
@property (copy,nonatomic) NSString *enrollYear;

@property (copy,nonatomic) NSString *company;
@property (copy,nonatomic) NSString *type;

@property (copy,nonatomic) NSString *user_icon;

- (void)setInfo:(NSDictionary*)personDic;
- (void)setIfFollowed:(NSString*)isFollowed;


+ (MeInfoViewModel*)getMeInfoVM;

@end
