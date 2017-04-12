//
//  RegisterFourVC.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 8/29/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "RegisterFourVC.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "CountryAndStateAndCityTextField.h"
#import "TextSender.h"

@interface RegisterFourVC()
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (strong,nonatomic) CountryAndStateAndCityTextField *countryText;
@property (strong,nonatomic) CountryAndStateAndCityTextField *stateText;
@property (strong,nonatomic)CountryAndStateAndCityTextField *cityText;
@property (strong,nonatomic) UITextField *jobText;
@property (strong,nonatomic) UITextField *companyText;

@property (strong,nonatomic) UIButton *nextBtn;

@property (strong,nonatomic) TextSender *sender;


@end

@implementation RegisterFourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
      self.sender = [TextSender getSender];
    
    //---------------------------------------------   设置navigationBar透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    //----------------------------------------------  设置navigationBar透明
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];

    
    self.countryText = [[CountryAndStateAndCityTextField alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5,120,self.inputView.frame.size.width / 3.5, 40)];
    self.countryText.backgroundColor = [UIColor whiteColor];
    self.countryText.alpha = 0.8;
    self.countryText.placeholder = @"所在国家";
    self.countryText.layer.masksToBounds = YES;
    self.countryText.layer.cornerRadius = 6.0;
    
    
    
    
    self.cityText = [[CountryAndStateAndCityTextField alloc] initWithFrame:CGRectMake((self.inputView.frame.size.width - self.inputView.frame.size.width / 3.5+ self.inputView.frame.size.width / 7.5),120,self.inputView.frame.size.width / 3.5, 40)];
    self.cityText.backgroundColor = [UIColor whiteColor];
    self.cityText.alpha = 0.8;
    self.cityText.placeholder = @"所在城市";
    self.cityText.layer.masksToBounds = YES;
    self.cityText.layer.cornerRadius = 6.0;
    
    
    self.stateText = [[CountryAndStateAndCityTextField alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width - self.inputView.frame.size.width / 3.5+ self.inputView.frame.size.width / 7.5 - self.inputView.frame.size.width / 2.8,120,self.inputView.frame.size.width / 3.5, 40)];
    self.stateText.backgroundColor = [UIColor whiteColor];
    self.stateText.alpha = 0.8;
    self.stateText.placeholder = @"所在省份";
    self.stateText.layer.masksToBounds = YES;
    self.stateText.layer.cornerRadius = 6.0;
    
    
    self.jobText = [[UITextField alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5, 54,self.inputView.frame.size.width, 40)];
    self.jobText.backgroundColor = [UIColor whiteColor];
    self.jobText.alpha = 0.8;
    self.jobText.placeholder = @"请输入您的职务";
    self.jobText.layer.masksToBounds = YES;
    self.jobText.layer.cornerRadius = 6.0;
    
    
    self.companyText = [[UITextField alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5,8, self.inputView.frame.size.width, 40)];
    self.companyText.backgroundColor = [UIColor whiteColor];
    self.companyText.alpha = 0.8;
    self.companyText.placeholder = @"请输入您的公司";
    self.companyText.layer.masksToBounds = YES;
    self.companyText.layer.cornerRadius = 6.0;
    
    
    self.nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5, 186, self.inputView.frame.size.width, 40)];
    self.nextBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:209/255.0 blue:141/255.0 alpha:1.0];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 6.0;
    
    [self.inputView addSubview:self.companyText];
    [self.inputView addSubview:self.jobText];
    [self.inputView addSubview:self.countryText];
    [self.inputView addSubview:self.stateText];
    [self.inputView addSubview:self.cityText];
    [self.inputView addSubview:self.nextBtn];
    
    [self.countryText.rac_textSignal subscribeNext:^(id x) {
        if(self.countryText.isFirstResponder){
            NSLog(@"countryTextField");
            [self.sender setPlaceTextFieldType:@"country"];
        }
    }];
    
    [self.stateText.rac_textSignal subscribeNext:^(id x) {
        if(self.stateText.isFirstResponder){
            NSLog(@"stateTextField");
            [self.sender setPlaceTextFieldType:@"state"];
        }
    }];
    
    [self.cityText.rac_textSignal subscribeNext:^(id x) {
        if(self.cityText.isFirstResponder){
            NSLog(@"cityTextField");
            [self.sender setPlaceTextFieldType:@"city"];
        }
    }];

    
}

-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//- (void)bindVM{
//    RAC(self.vm.user,job) = self.jobText.rac_textSignal;
//    RAC(self.vm.user,company) = self.companyText.rac_textSignal;
//    
//    RAC(self.nextBtn,enabled) = self.vm.registerFourEnableSignal;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
