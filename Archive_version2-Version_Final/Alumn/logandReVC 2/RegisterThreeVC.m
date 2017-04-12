//
//  RegisterThreeVC.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 8/29/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "RegisterThreeVC.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "RegisterViewModel.h"
#import "RegisterFourVC.h"
#import "RegisterFiveVC.h"
#import "EnrollYearTextField.h"
#import "TextSender.h"
#import "FacultyAndMajorText.h"


@interface RegisterThreeVC()
//@property (strong,nonatomic) RegisterVM *vm;

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (strong,nonatomic) FacultyAndMajorText *facultyText;
@property (strong,nonatomic) FacultyAndMajorText *majorText;
@property (strong,nonatomic) EnrollYearTextField *enrollYearText;

@property (strong,nonatomic) UIButton *inSchoolBtn;
@property (strong,nonatomic) UIButton *inJobBtn;

@property (strong,nonatomic) RegisterViewModel *registerVM;
@property (strong,nonatomic) TextSender *sender;


@end

@implementation RegisterThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.registerVM = [RegisterViewModel getRegisterVM];
    self.sender = [TextSender getSender];
    
    //---------------------------------------------   设置navigationBar透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    //----------------------------------------------  设置navigationBar透明
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    
    
    self.facultyText = [[FacultyAndMajorText alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5,8,self.inputView.frame.size.width / 2.2, 40)];
    self.facultyText.backgroundColor = [UIColor whiteColor];
    self.facultyText.alpha = 0.8;
    self.facultyText.placeholder = @"请输入您的院系";
    self.facultyText.layer.masksToBounds = YES;
    self.facultyText.layer.cornerRadius = 6.0;
    
    
    self.majorText = [[FacultyAndMajorText alloc] initWithFrame:CGRectMake((self.inputView.frame.size.width - self.inputView.frame.size.width / 2.2+ self.inputView.frame.size.width / 7.5),8,self.inputView.frame.size.width / 2.2, 40)];
    self.majorText.backgroundColor = [UIColor whiteColor];
    self.majorText.alpha = 0.8;
    self.majorText.placeholder = @"请输入您的专业";
    self.majorText.layer.masksToBounds = YES;
    self.majorText.layer.cornerRadius = 6.0;
    
    
    self.enrollYearText = [[EnrollYearTextField alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5, 54,self.inputView.frame.size.width, 40)];
    self.enrollYearText.backgroundColor = [UIColor whiteColor];
    self.enrollYearText.alpha = 0.8;
    self.enrollYearText.placeholder = @"请输入您的入学年份";
    self.enrollYearText.layer.masksToBounds = YES;
    self.enrollYearText.layer.cornerRadius = 6.0;
    
    
    self.inSchoolBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5, 120, self.inputView.frame.size.width, 40)];
    self.inSchoolBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:209/255.0 blue:141/255.0 alpha:1.0];
    [self.inSchoolBtn setTitle:@"我是在校生" forState:UIControlStateNormal];
    self.inSchoolBtn.layer.masksToBounds = YES;
    self.inSchoolBtn.layer.cornerRadius = 6.0;
    [self.inSchoolBtn addTarget:self action:@selector(inSchoolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.inJobBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.inputView.frame.size.width / 7.5, 186, self.inputView.frame.size.width, 40)];
    self.inJobBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:209/255.0 blue:141/255.0 alpha:1.0];
    [self.inJobBtn setTitle:@"我已工作" forState:UIControlStateNormal];
    self.inJobBtn.layer.masksToBounds = YES;
    self.inJobBtn.layer.cornerRadius = 6.0;
    [self.inJobBtn addTarget:self action:@selector(inJobBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.inputView addSubview:self.facultyText];
    [self.inputView addSubview:self.majorText];
    [self.inputView addSubview:self.enrollYearText];
    [self.inputView addSubview:self.inSchoolBtn];
    [self.inputView addSubview:self.inJobBtn];
    
    [self bindVM];
    
}


- (void)bindVM{

    
    RAC(self.registerVM.user,faculty) = self.facultyText.rac_textSignal;
    RAC(self.registerVM.user,major) = self.majorText.rac_textSignal;
    RAC(self.registerVM.user,admission_year) = self.enrollYearText.rac_textSignal;
    
    RAC(self.inJobBtn,enabled) = self.registerVM.registerThreeEnableSignal;
    if(self.registerVM.registerThreeEnableSignal){
        NSLog(@"对的哦");
    }
    
    self.inSchoolBtn.enabled = YES;
    self.inJobBtn.enabled = YES;
}

- (void)inSchoolBtnClick:(id)sender{
    self.registerVM.user.company = @"The SEU";
    self.registerVM.user.job = @"student";
    self.registerVM.user.country = @"中国";
    self.registerVM.user.state = @"江苏";
    self.registerVM.user.city = @"南京";
    RegisterFiveVC *registerFive = [self.storyboard instantiateViewControllerWithIdentifier:@"registerFive"];
    [self.navigationController pushViewController:registerFive animated:YES];
}

- (void)inJobBtnClick:(id)sender{
    NSLog(@"有没有执行？？？");
    
    RegisterFourVC *registerFour = [self.storyboard instantiateViewControllerWithIdentifier:@"registerFour"];
    [self.navigationController pushViewController:registerFour animated:YES];
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
