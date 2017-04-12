//
//  LoginViewController.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "LoginViewController.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoginViewModel.h"
#import "RegisterFirstViewController.h"
#import "Circle+Extension.h"
#import "User.h"
#import "User+Extension.h"


@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *userLogoView;
@property (weak, nonatomic) IBOutlet UIImageView *userLineView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordLogo;
@property (weak, nonatomic) IBOutlet UIImageView *passwordLineView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPwdBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneTextField;

//@property (nonatomic,strong) LoginViewModel *loginVM;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.loginVM = [LoginViewModel getLoginVM];
    
    // Do any additional setup after loading the view, typically from a nib.
    //---------------------------------------------   设置navigationBar透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
//    self.navigationController.navigationBar.layer.masksToBounds = YES;
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    //----------------------------------------------  设置navigationBar透明
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    
    //-----------------------------------------------  控件设置
    
    [self.passwordTextField setSecureTextEntry:YES];
    self.headImage.image = [self OriginImage:[UIImage imageNamed:@"logohead"] scaleToSize:self.headImage.bounds.size];
    self.userLogoView.image = [self OriginImage:[UIImage imageNamed:@"userLogo"] scaleToSize:self.userLogoView.bounds.size];
    self.passwordLogo.image = [self OriginImage:[UIImage imageNamed:@"passwordLogo"] scaleToSize:self.passwordLogo.bounds.size];
    self.userLineView.image = [self OriginImage:[UIImage imageNamed:@"lineImg"] scaleToSize:self.userLineView.bounds.size];
    self.passwordLineView.image = [self OriginImage:[UIImage imageNamed:@"lineImg"] scaleToSize:self.passwordLineView.bounds.size];
    
    self.loginBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:209/255.0 blue:141/255.0 alpha:1.0];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 6.0;
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)fingerTapped:(UITapGestureRecognizer*)gestureRecognizer{
    [self.view endEditing:YES];
}


- (void)bindVM{
    //    RAC(self.loginVM.user,phone) = self.telephoneTextField.rac_textSignal;
    //    RAC(self.loginVM.user,pwd) = self.passwordTextField.rac_textSignal;
    //
    //    RAC(self.loginBtn,enabled) = self.loginVM.loginEnableSignal;
    //    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    //        [self.loginVM.loginCommand execute:nil];
    //    }];
    //
    //    [self.loginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
    //        NSString *returnMessage = [[NSString alloc]init];
    //
    //        if([result isEqualToString:@"success"]){
    //            BOOL flag =false;
    //            NSLog(@"跳转到登录成功界面");
    //            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //            UIViewController *VC = [sb instantiateViewControllerWithIdentifier:@"FiveTab"];
    //            [self.navigationController pushViewController:VC animated:YES];
    //
    //
    //        }else
    //        {
    //            if([result isEqualToString:@"format error"]){
    //                returnMessage = @"输入格式错误";
    //            }else if([result isEqualToString:@"not register yet"]){
    //                returnMessage = @"您还没有注册，请先注册";
    //            }else  if([result isEqualToString:@"wrong pwd"]){
    //                returnMessage = @"输入的密码错误";
    //            }
    //
    //            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录错误" message:returnMessage preferredStyle:UIAlertControllerStyleAlert];
    //            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //                NSLog(@"登录错误确认");
    //            }];
    //            [alertController addAction:cancleAction];
    //            [self presentViewController:alertController animated:YES completion:nil];
    //        }
    //
    //    }];
    
    
    
}

- (IBAction)loginIn:(id)sender {
    
    NSLog(@"执行登录命令");
    
    NSDictionary *loginDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.telephoneTextField.text,@"telephone",self.passwordTextField.text,@"password", nil];
    
    [User loginWithParameters:loginDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
        
        if(([[dict valueForKey:@"code"] integerValue] == 1204) ||([[dict valueForKey:@"code"] integerValue] == 1205) || ([[dict valueForKey:@"code"] integerValue] == 1206)
           )
        {
            
            [Circle getMainPageCircleWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
                //                [subscriber sendNext:@"success"];
                //                [subscriber sendCompleted];
                
                NSLog(@"登录－－－－－－－得到圈子的详情并存储在plist");
                
                
            } AFNErrorBlock:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            //确认登陆跳转
            NSLog(@"跳转到登录成功界面");
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *VC = [sb instantiateViewControllerWithIdentifier:@"FiveTab"];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else {
            
            NSString *returnMessage = [[NSString alloc]init];
            
            if([[dict valueForKey:@"code"] integerValue] == 1201){
                // format error
                //                [subscriber sendNext:@"format error"];
                //                [subscriber sendCompleted];
                returnMessage = @"输入格式错误";
                
            }else if([[dict valueForKey:@"code"] integerValue] == 1202){
                //not register yet
                //                [subscriber sendNext:@"not register yet"];
                //                [subscriber sendCompleted];
                returnMessage = @"您还没有注册，请先注册";
                
                
            }else if([[dict valueForKey:@"code"] integerValue] == 1203){
                // wrong pwd
                //                [subscriber sendNext:@"wrong pwd"];
                //                [subscriber sendCompleted];
                returnMessage = @"输入的密码错误";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录错误" message:returnMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"登录错误确认");
            }];
            [alertController addAction:cancleAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
        
    } AFNErrorBlock:^(NSError *error) {
        //        [subscriber sendNext:@"error"];
        //        [subscriber sendCompleted];
        NSLog(@"登录请求错误");
    }];
    
    
}

- (IBAction)registerStart:(id)sender {
    RegisterFirstViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"registerFirstVC"];
    [self.navigationController showViewController:registerVC sender:nil];
    
}

-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
