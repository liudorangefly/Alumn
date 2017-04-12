//
//  RegisterFiveVC.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 8/29/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "RegisterFiveVC.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "RegisterViewModel.h"

@interface RegisterFiveVC()

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pickImgView;

@property (strong,nonatomic) RegisterViewModel *registerVM;

@end

@implementation  RegisterFiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.registerVM = [RegisterViewModel getRegisterVM];
    
    //---------------------------------------------   设置navigationBar透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    //----------------------------------------------  设置navigationBar透明
    
    
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];

    
    self.view.backgroundColor = [UIColor blackColor];
    self.finishBtn.layer.masksToBounds = YES;
    self.finishBtn.layer.cornerRadius = 6.0;
    
    _pickImgView.image = [self OriginImage:[UIImage imageNamed:@"photo"] scaleToSize:_pickImgView.bounds.size];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self bindVM];
}

-(void)bindVM{
    self.registerVM.user.icon_url = @"icon_url here";
    RAC(self.finishBtn,enabled) = self.registerVM.registerFiveEnableSiganl;
    
    [[self.finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.registerVM.registerCommand execute:nil];
    }];
    
    [self.registerVM.registerCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        if([result isEqualToString:@"success"]){
            NSLog(@"register finish");
            NSDictionary *userDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.registerVM.user.password,@"password",self.registerVM.user.telephone,@"telephone", nil];
            NSDictionary *loginDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[self dictionaryToJson:userDic],@"info_json", nil];
            [User loginWithParameters:loginDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
                
                NSLog(@"注册后自动登录成功");
                
            } AFNErrorBlock:^(NSError *error) {
                
                NSLog(@"注册后自动登录失败");
                
            }];
            
        }else{
            NSLog(@"register failed");
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}



@end
