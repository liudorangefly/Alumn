//
//  RegisterViewModel.h
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/6/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "User+Extension.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RegisterViewModel : NSObject

//@property (nonatomic,strong) RACSignal *registerOneEnableSignal;
//@property (nonatomic,strong) RACSignal *registerTwoEnableSignal;
//@property (nonatomic,strong) RACSignal *registerThreeEnableSignal;
//@property (nonatomic,strong) RACSignal *registerFourEnableSignal;
//@property (nonatomic,strong) RACSignal *registerFiveEnableSiganl;

//@property (nonatomic,strong) RACCommand *telephoneCheckCommand;
//@property (nonatomic,strong) RACCommand *registerCommand;

@property (nonatomic,strong) User *user;

+ (RegisterViewModel*)getRegisterVM;
- (void)setTelephone:(NSString*)telephone;

@end
