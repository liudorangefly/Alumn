//
//  LoginViewModel.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "LoginViewModel.h"
#import "Circle+Extension.h"

@implementation LoginViewModel

- (User*)user{
    if(_user == nil){
        _user = [User getUser];
    }
    
    return _user;
}

+ (LoginViewModel*)getLoginVM{
    static dispatch_once_t dec;
    static LoginViewModel *loginVM;
    
    dispatch_once(&dec, ^{
        loginVM = [[LoginViewModel alloc] init];
   //     [loginVM initRAC];
    });
    
    return loginVM;
}

- (void)initRAC{
//    self.loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self.user, phone),RACObserve(self.user, pwd)] reduce:^id(NSString *telephone,NSString *password){
    
//        NSLog(@"测试输入");
//        
//        NSPredicate *telephone_predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^1[3|4|5|7|8][0-9]\\d{8}$"];
//        NSPredicate *pwd_predicate     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^.{6,}$"];
//        
//        
//        return @([telephone_predicate evaluateWithObject:telephone] && [pwd_predicate evaluateWithObject:password]);
    
//    }];
    
//    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            
//            NSLog(@"执行登录命令");
//            
//            NSDictionary *loginDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.user.phone,@"telephone",self.user.pwd,@"password", nil];
//            
//            [User loginWithParameters:loginDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
//                
//                
//                
//                if(([[dict valueForKey:@"code"] integerValue] == 1204) ||([[dict valueForKey:@"code"] integerValue] == 1205) || ([[dict valueForKey:@"code"] integerValue] == 1206)
//                   )
//                {
//                    
//                    [Circle getMainPageCircleWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
//                        [subscriber sendNext:@"success"];
//                        [subscriber sendCompleted];
//                        
//                    } AFNErrorBlock:^(NSError *error) {
//                        NSLog(@"%@",error);
//                    }];
//                    //确认登陆跳转
//                }else {
//                    if([[dict valueForKey:@"code"] integerValue] == 1201){
//                        // format error
//                        [subscriber sendNext:@"format error"];
//                        [subscriber sendCompleted];
//                        
//                        
//                    }else if([[dict valueForKey:@"code"] integerValue] == 1202){
//                        //not register yet
//                        [subscriber sendNext:@"not register yet"];
//                        [subscriber sendCompleted];
//                        
//                        
//                    }else if([[dict valueForKey:@"code"] integerValue] == 1203){
//                        // wrong pwd
//                        [subscriber sendNext:@"wrong pwd"];
//                        [subscriber sendCompleted];
//                        
//                    }
//                    
//                    
//                }
//                
//                
//            } AFNErrorBlock:^(NSError *error) {
//                [subscriber sendNext:@"error"];
//                [subscriber sendCompleted];
//            }];
//            
//            return nil;
//        }];
//    }];
}

@end
