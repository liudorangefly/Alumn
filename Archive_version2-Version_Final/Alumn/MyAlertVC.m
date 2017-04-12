////
////  MyAlertVC.m
////  Alumn
////
////  Created by Dorangefly Liu on 16/8/31.
////  Copyright © 2016年 刘龙飞. All rights reserved.
////
//
//#import "MyAlertVC.h"
//#import "UIView+SDAutoLayout.h"
//#import "MyAltview.h"
//// 屏幕高度
//#define ScreenH [UIScreen mainScreen].bounds.size.height
//// 屏幕宽度
//#define ScreenW [UIScreen mainScreen].bounds.size.width
//@interface MyAlertVC ()
//
//@end
//
//@implementation MyAlertVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    //在storyborad中使用push方法不拖线跳转
////    _backview.userInteractionEnabled =YES;
////     UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
////    [tapGesture setNumberOfTapsRequired:1];
////    [_backview addGestureRecognizer:tapGesture];
//    
//    
//    self.alt = [MyAltview new];
//    self.alt.altwidth=280;
//    [_alt CreatAlt:nil circleName:@"XXXXXppppppXXXXXXXXXXX" altTitle:@"XXXXXXXX" Content:@"asd阿速度发送地方fa阿vjasdasdsdsadasdasffsavavsfasfasfasfasfsafsafasfasfasfasfasfsafasfasfsafsafasfasfasfasfasfsafasfasfsafsafasfasfasfafasfsafas小大三大" altButton:nil altbtnTcolor:[UIColor redColor] altselectbtnTcolor:[UIColor whiteColor] icon];
//    _alt.sd_layout
//    .centerYEqualToView(self.view)
//    .centerXEqualToView(self.view);
//    [self.view addSubview:_alt.view];
//    [self.view bringSubviewToFront:_alt.view];
//    [_alt show];
//
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(UIImage*) imageWithColor:(UIColor*)color
//{
//    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//}
//
////-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)eventv
////{
////    [self dismissViewControllerAnimated:YES completion:nil];
////}
////
////- (void)event:(UITapGestureRecognizer *)gesture
////{
////    
////    NSLog(@"单机");
////}
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
