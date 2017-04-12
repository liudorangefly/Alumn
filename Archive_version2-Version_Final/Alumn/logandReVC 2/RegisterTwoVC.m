//
//  RegisterTwoVC.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 8/29/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "RegisterTwoVC.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "RegisterViewModel.h"
#import "RegisterThreeVC.h"
#import "genderTextField.h"


@interface RegisterTwoVC()

@property (strong, nonatomic) UITextField *nameText;
@property (strong, nonatomic) genderTextField *genderText;
@property (strong, nonatomic) UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIView *inputView;

@property (strong,nonatomic) RegisterViewModel *registerVM;

@end

@implementation RegisterTwoVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.registerVM = [RegisterViewModel getRegisterVM];
    
    //---------------------------------------------   设置navigationBar透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    //----------------------------------------------  设置navigationBar透明
    
    //----------------------------  设置界面
    self.nameText= [[UITextField alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5,8,self.inputView.frame.size.width, 40)];
    self.nameText.backgroundColor = [UIColor whiteColor];
    self.nameText.alpha = 0.8;
    self.nameText.placeholder = @"请输入您的姓名";
    self.nameText.layer.masksToBounds = YES;
    self.nameText.layer.cornerRadius = 6.0;
    
    self.genderText = [[genderTextField alloc] initWithFrame: CGRectMake(self.inputView.frame.size.width / 7.5, 54,self.inputView.frame.size.width, 40)];
    self.genderText.placeholder = @"请输入您的性别";
    self.genderText.backgroundColor = [UIColor whiteColor];
    self.genderText.alpha = 0.8;
    self.genderText.layer.masksToBounds = YES;
    self.genderText.layer.cornerRadius = 6.0;
    [self.genderText setSecureTextEntry:YES];
    
    self.nextBtn =[[UIButton alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5, 120, self.inputView.frame.size.width, 40)];
    self.nextBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:209/255.0 blue:141/255.0 alpha:1.0];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 6.0;
    [self.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.inputView addSubview:self.nameText];
    [self.inputView addSubview:self.genderText];
    [self.inputView addSubview:self.nextBtn];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    
    [self bindVM];
}

- (void)bindVM{
    RAC(self.registerVM.user,name) = self.nameText.rac_textSignal;
    RAC(self.registerVM.user,gender) = self.genderText.rac_textSignal;
    
    RAC(self.nextBtn,enabled) = self.registerVM.registerTwoEnableSignal;
}

- (void)nextBtnClick:(id)sender{
    RegisterThreeVC *registerThree = [self.storyboard instantiateViewControllerWithIdentifier:@"registerThree"];
    [self.navigationController pushViewController:registerThree animated:YES];
}


//改变图片的大小适应image View的大小
        
- (UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
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
