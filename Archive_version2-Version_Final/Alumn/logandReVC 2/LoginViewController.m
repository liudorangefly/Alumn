//
//  LoginViewController.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoginViewModel.h"
#import "RegisterFirstViewController.h"


@interface LoginViewController ()
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

@property (nonatomic,strong) LoginViewModel *loginVM;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginVM = [LoginViewModel getLoginVM];
    
    // Do any additional setup after loading the view, typically from a nib.
    //---------------------------------------------   设置navigationBar透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    //----------------------------------------------  设置navigationBar透明
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    
    //-----------------------------------------------  控件设置
    self.headImage.image = [self OriginImage:[UIImage imageNamed:@"logohead"] scaleToSize:self.headImage.bounds.size];
    self.userLogoView.image = [self OriginImage:[UIImage imageNamed:@"userLogo"] scaleToSize:self.userLogoView.bounds.size];
    self.passwordLogo.image = [self OriginImage:[UIImage imageNamed:@"passwordLogo"] scaleToSize:self.passwordLogo.bounds.size];
    self.userLineView.image = [self OriginImage:[UIImage imageNamed:@"lineImg"] scaleToSize:self.userLineView.bounds.size];
    self.passwordLineView.image = [self OriginImage:[UIImage imageNamed:@"lineImg"] scaleToSize:self.passwordLineView.bounds.size];
    
    self.loginBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:209/255.0 blue:141/255.0 alpha:1.0];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 6.0;
    
    [self bindVM];
    
}

- (void)bindVM{
    RAC(self.loginVM.user,phone) = self.telephoneTextField.rac_textSignal;
    RAC(self.loginVM.user,pwd) = self.passwordTextField.rac_textSignal;
    
    RAC(self.loginBtn,enabled) = self.loginVM.loginEnableSignal;
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.loginVM.loginCommand execute:nil];
           }];
    
    [self.loginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        if([result isEqualToString:@"success"]){
            NSLog(@"跳转到登录成功界面");
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *VC = [sb instantiateViewControllerWithIdentifier:@"FiveTab"];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
            NSLog(@"登录失败");
        }
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
