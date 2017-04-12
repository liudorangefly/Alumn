//
//  RegisterTwoVC.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 8/29/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "RegisterTwoVC.h"
//#import "ReactiveCocoa/ReactiveCocoa.h"
#import "RegisterViewModel.h"
#import "RegisterThreeVC.h"
#import "genderTextField.h"
#import "User+Extension.h"
#import "User.h"


@interface RegisterTwoVC()

@property (strong, nonatomic) UITextField *nameText;
@property (strong, nonatomic) genderTextField *genderText;
@property (strong, nonatomic) UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIView *inputView;

@property (strong,nonatomic) RegisterViewModel *registerVM;
@property (strong,nonatomic) User *user;

@end

@implementation RegisterTwoVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    isViewWillLoad = NO;
    
    self.registerVM = [RegisterViewModel getRegisterVM];
    
    self.user = [User getUser];
    
    //---------------------------------------------   设置navigationBar透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    //----------------------------------------------  设置navigationBar透明
    
    //----------------------------  设置界面
    self.nameText= [[UITextField alloc] initWithFrame:CGRectMake(0,8,self.inputView.frame.size.width, 40)];
    self.nameText.backgroundColor = [UIColor whiteColor];
    self.nameText.alpha = 0.8;
    self.nameText.placeholder = @"请输入您的姓名";
    self.nameText.layer.masksToBounds = YES;
    self.nameText.layer.cornerRadius = 6.0;
    
    self.genderText = [[genderTextField alloc] initWithFrame: CGRectMake(0, 54,self.inputView.frame.size.width, 40)];
    self.genderText.placeholder = @"请输入您的性别";
    self.genderText.backgroundColor = [UIColor whiteColor];
    self.genderText.alpha = 0.8;
    self.genderText.layer.masksToBounds = YES;
    self.genderText.layer.cornerRadius = 6.0;
    
    self.nextBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 120, self.inputView.frame.size.width, 40)];
    self.nextBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:209/255.0 blue:141/255.0 alpha:1.0];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 6.0;
    [self.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.inputView addSubview:self.nameText];
    [self.inputView addSubview:self.genderText];
    [self.inputView addSubview:self.nextBtn];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    if(self.genderText.text == nil){
        NSLog(@"viewDidLoad gender初始值:nil");
    }else if([self.genderText.text isEqualToString:@""]){
        NSLog(@"viewDidLoad gender初始值: \"\"");
    }
    
    
    //    [self bindVM];
}

//- (void)bindVM{
//    [self.genderText.rac_textSignal subscribeNext:^(id x) {
//        NSLog(@"输出genderText %@",self.genderText.text);
//    }];
//
//
//    RAC(self.registerVM.user,name) = self.nameText.rac_textSignal;
//
//    RAC(self.registerVM.user,genderString) = self.genderText.rac_textSignal;
//
//    RAC(self.nextBtn,enabled) = self.registerVM.registerTwoEnableSignal;
//}

- (void)nextBtnClick:(id)sender{
    
    NSPredicate *name_predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u4e00-\u9fa5]{2,4}$"];
    if([self.genderText.text isEqualToString:@"女"]){
        self.user.gender = 0;
    }else{
        self.user.gender = 1;
    }
    
    if([name_predicate evaluateWithObject:self.nameText.text] && (self.genderText.text != nil)){
        
        self.user.name = self.nameText.text;
        
        RegisterThreeVC *registerThree = [self.storyboard instantiateViewControllerWithIdentifier:@"registerThree"];
        [self.navigationController pushViewController:registerThree animated:YES];
        
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您输入的格式错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"格式输入错误确认");
        }];
        [alertController addAction:cancleAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    self.nameText.text = @"";
    self.genderText.text= @"";
    if(isViewWillLoad){
        NSLog(@"ZHIXING");
    }
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
