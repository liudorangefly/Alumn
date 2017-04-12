//
//  RegisterFirstViewController.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "RegisterFirstViewController.h"

#import "ReactiveCocoa/ReactiveCocoa.h"
#import "RegisterViewModel.h"
#import "RegisterTwoVC.h"


@interface RegisterFirstViewController ()

@property (strong, nonatomic) UITextField *phoneText;
@property (strong, nonatomic) UIButton *phoneBtn;
@property (strong, nonatomic)   UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *inputView;

@property (strong,nonatomic) RegisterViewModel *registerVM;

@end

@implementation RegisterFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //--------------------------------------------   init registerVM
    self.registerVM = [RegisterViewModel getRegisterVM];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    //---------------------------------------------   设置navigationBar透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    //----------------------------------------------  设置navigationBar透明
    
    //----------------------------  设置界面
    self.phoneText= [[UITextField alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5,8,self.inputView.frame.size.width, 40)];
    self.phoneText.backgroundColor = [UIColor whiteColor];
    self.phoneText.alpha = 0.8;
    self.phoneText.placeholder = @"请输入您的手机号";
    self.phoneText.layer.masksToBounds = YES;
    self.phoneText.layer.cornerRadius = 6.0;
    
    self.passwordTextField = [[UITextField alloc] initWithFrame: CGRectMake(self.inputView.frame.size.width / 7.5, 54,self.inputView.frame.size.width, 40)];
    self.passwordTextField.placeholder = @"请输入您的密码";
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.alpha = 0.8;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.cornerRadius = 6.0;
    [self.passwordTextField setSecureTextEntry:YES];
    
    self.phoneBtn =[[UIButton alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5, 120, self.inputView.frame.size.width, 40)];
    self.phoneBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:209/255.0 blue:141/255.0 alpha:1.0];
    [self.phoneBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    self.phoneBtn.layer.masksToBounds = YES;
    self.phoneBtn.layer.cornerRadius = 6.0;
    
    [self.inputView addSubview:self.phoneText];
    [self.inputView addSubview:self.passwordTextField];
    [self.inputView addSubview:self.phoneBtn];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    
    
    
    [self bindVM];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//改变图片的大小适应image View的大小
-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (void)bindVM{
    RAC(self.registerVM.user,telephone) = self.phoneText.rac_textSignal;
    RAC(self.registerVM.user,password) = self.passwordTextField.rac_textSignal;
    RAC(self.phoneBtn,enabled) = self.registerVM.registerOneEnableSignal;
    
    [[self.phoneBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"rac_signalForControlEvents");
        
        [self.registerVM.telephoneCheckCommand execute:nil];
    }];
    
    [self.registerVM.telephoneCheckCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        NSLog(@"executionSignals");
        if([result isEqualToString:@"success"]){
            NSLog(@"regist success");
            RegisterTwoVC *registerTwo = [self.storyboard instantiateViewControllerWithIdentifier:@"registerTwo"];
            [self.navigationController pushViewController:registerTwo animated:YES];
            //       [self.navigationController popViewControllerAnimated:YES];
        }else if ([result isEqualToString:@"error"]){
            
            //提示用户输入手机号错误
            NSLog(@"executionSignals error");
        }
    }];
}

@end
