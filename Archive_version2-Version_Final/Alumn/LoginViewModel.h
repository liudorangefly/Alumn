//
//  LoginViewModel.h
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User+Extension.h"
#import "User.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LoginViewModel : NSObject

//@property (nonatomic,strong) RACSignal *loginEnableSignal;
//@property (nonatomic,strong) RACCommand *loginCommand;

@property (nonatomic,strong) User *user;

+ (LoginViewModel*)getLoginVM;

@end
