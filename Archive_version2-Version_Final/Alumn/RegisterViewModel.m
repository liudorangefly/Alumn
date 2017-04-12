//
//  RegisterViewModel.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/6/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "RegisterViewModel.h"
#import "MJExtension.h"
#import "Circle+Extension.h"
#import "Circle.h"

@implementation RegisterViewModel

- (User*)user{
    if(_user == nil){
        _user = [User getUser];
    }
    
    return _user;
}

+ (RegisterViewModel*)getRegisterVM{
    
    static dispatch_once_t dec;
    static RegisterViewModel *registerVM;
    
    dispatch_once(&dec, ^{
        registerVM = [[RegisterViewModel alloc] init];
        [registerVM initRAC];
    });
    
    return registerVM;
}

- (void)initRAC{
//    self.registerOneEnableSignal = [RACSignal combineLatest:@[RACObserve(self.user, telephone),RACObserve(self.user, password)] reduce:^id(NSString *telephone,NSString *password){
//        NSPredicate *telephone_predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^1[3|4|5|7|8][0-9]\\d{8}$"];
//        NSPredicate *pwd_predicate     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^.{6,}$"];
//        
//        return @([telephone_predicate evaluateWithObject:telephone] && [pwd_predicate evaluateWithObject:password]);
//        
//    }];
    
//    self.registerTwoEnableSignal = [RACSignal combineLatest:@[RACObserve(self.user, name),RACObserve(self.user, genderString)] reduce:^id(NSString *name,NSString *genderS){
//        
//        NSLog(@"检测name gender输入 %@   %@",name,genderS);
//        
//        NSPredicate *name_predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u4e00-\u9fa5]{2,4}$"];
//        if([genderS isEqualToString:@"女"]){
//            self.user.gender = 0;
//        }else{
//            self.user.gender = 1;
//        }
//        
//        return @([name_predicate evaluateWithObject:name] && (genderS != nil));
//        
//    }];
    
//    self.registerThreeEnableSignal = [RACSignal combineLatest:@[RACObserve(self.user, faculty),RACObserve(self.user,major),RACObserve(self.user,admission_year)] reduce:^id(NSString *faculty,NSString *major,NSString *admission_year){
//        return @((faculty != nil )&& ( major != nil)&& (admission_year != nil));
//    }];
//    
    
//    self.telephoneCheckCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        
//        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            
//            NSDictionary *phoneDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.user.telephone,@"telephone", nil];
//            
//            [User checkphoneWithParameters:phoneDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
//                
//                [subscriber sendNext:@"success"];
//                [subscriber sendCompleted];
//                
//            } AFNErrorBlock:^(NSError *error) {
//                NSLog(@"全部注册失败%@",error);
//                [subscriber sendNext:@"error"];
//                [subscriber sendCompleted];
//            }];
    
//            
//            return nil;
//        }];
//    }];
    //    self.registerFourEnableSignal = [RACSignal combineLatest:@[RACObserve(self.user, company),RACObserve(self.user, job),RACObserve(self.user, country),RACObserve(self.user, state),RACObserve(self.user, city)]reduce:^id(NSString *company,NSString *job,NSString *country,NSString *state,NSString *city){
    //        return @((company.length != 0) &&(job.length != 0)&& (country.length != 0) && (state.length != 0) && (city.length != 0));
    //    }];
    
    
//    self.registerFiveEnableSiganl = [RACSignal combineLatest:@[RACObserve(self.user, icon_url)] reduce:^id(NSString *icon_url){
//        return @(icon_url != nil);
//    }];
    
    
    //----------------------------------------------  注册命令
    
//    self.registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [User upLoadUserImg:self.user.userHeadImg method:@"upload_normal_img" SuccessBlock:^(NSDictionary *dict, BOOL success) {
//                NSLog(@"上传头像成功%@",dict);
//                NSMutableDictionary *registerdic = [[NSMutableDictionary alloc] init];
//                [registerdic setObject:[self.user valueForKey:@"city"] forKey:@"city"];
//                [registerdic setObject:[self.user valueForKey:@"state"] forKey:@"state"];
//                [registerdic setObject:[self.user valueForKey:@"country"] forKey:@"country"];
//                [registerdic setObject:[self.user valueForKey:@"faculty"] forKey:@"faculty"];
//                [registerdic setObject:[self.user valueForKey:@"name"] forKey:@"name"];
//                [registerdic setObject:[self.user valueForKey:@"major"] forKey:@"major"];
//                [registerdic setObject:[self.user valueForKey:@"company"] forKey:@"company"];
//                [registerdic setObject:[self.user valueForKey:@"admission_year"] forKey:@"admission_year"];
//                [registerdic setObject:[self.user valueForKey:@"telephone"] forKey:@"telephone"];
//                [registerdic setObject:[self.user valueForKey:@"job"] forKey:@"job"];
//                [registerdic setObject:[self.user valueForKey:@"gender"] forKey:@"gender"];
//                [registerdic setObject:[self.user valueForKey:@"password"] forKey:@"password"];
//                [registerdic setObject:[dict valueForKey:@"img_key"] forKey:@"icon_url"];
//                
//                [User registerWithParameters:registerdic SuccessBlock:^(NSDictionary *dict, BOOL success) {
//                    if([[dict valueForKey:@"code"] integerValue] == 2700)
//                    {
//                        NSLog(@"跳转到登录界面");
//                        [subscriber sendNext:@"success"];
//                        [subscriber sendCompleted];
//                    }
//                } AFNErrorBlock:^(NSError *error) {
//                    NSLog(@"注册失败");
//                    [subscriber sendNext:@"failued"];
//                    [subscriber sendCompleted];
//                }];
//                
//            } AFNErrorBlock:^(NSError *error) {
//                NSLog(@"上传头像失败");
//            }];
//            
//            return nil;
//        }];
//    }];
}


@end
