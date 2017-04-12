//
//  circleDeatilVC.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/26.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

/****************************
 该控制器用于控制圈子详情页面的显示，
 通过creatbutton创建了一个浮动按钮
 通过附加子控制方法实现多视窗叠加
 Copyright © 2016年 刘龙飞. All rights reserved.
 ******************************/
#import "circleDeatilVC.h"
#import "RNTableViewController.h"
#import "RNContainerController.h"
#import "searchController.h"
#import "searchController.h"
#import "searchViewController.h"
#import "FloatingViewController.h"
#import "UIDragButton.h"
#import "circleSettingVC.h"
#import "RRSendMessageViewController.h"
#import "NameAndPicVC.h"
#import "UIViewController+PortalTransition.h"
#import "CYViewControllerTransitioningDelegate.h"
#import "SecondViewController.h"
#import   "UIImageView+WebCache.h"


#define floatSize 120

// 屏幕高度
#define ScreenH [UIScreen mainScreen].bounds.size.height
// 屏幕宽度
#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface circleDeatilVC ()<UIDragButtonDelegate>
/**
 *  悬浮的window
 */
@property(strong,nonatomic)UIWindow *window;
@property (nonatomic, strong) CYViewControllerTransitioningDelegate *viewControllerTransitionDelegate;


/**
 *  悬浮的按钮
 */


@end

@implementation circleDeatilVC


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];


    [self.NavBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self performSelector:@selector(createButton) withObject:nil afterDelay:1];
    //_floatview.frame = CGRectZero;
     [self.backgroundimage sd_setImageWithURL:[NSURL URLWithString:self.backgroundUrl] placeholderImage:[UIImage imageNamed:@"10.jpg"]];
    self.NavBar.layer.masksToBounds = YES;
    [self.NavBar setBackgroundColor:[UIColor clearColor]];
    [self.cicrleName setText:self.circleNameStr];
    [self.cicrleName endEditing:true];
   NSString *num =[[NSString alloc] initWithFormat:@"成员 %@人",self.number];
    [self.numbers setText:num];
   //[self.view bringSubviewToFront:_setButton];
    [self.ciecleDeatilMask2 setHidden:true];
    [self.setButton1 setHidden:true];
    [self.setButton2 setHidden:true];
    [self.setButton3 setHidden:true];
    [self.ExitButton setHidden:true];
  //  FloatingViewController *floatVc = [ [ FloatingViewController alloc]init];
    //[self addChildViewController:floatVc];
    //[self.view addSubview:floatVc.view];
    //_current =self;
  // self.viewControllerTransitionDelegate = [CYViewControllerTransitioningDelegate new];
    
    
    
    
    
    

    
}


//- (IBAction)setButtonCilcked:(id)sender {
//    
//    [self.button setHidden:true];
//    [self.searchButton setHidden:true];
//    [self.settingButton setHidden:true];
//    //self.setButton.hidden =YES;
//    [self.ciecleDeatilMask2 setHidden:false];
//    [self.setButton1 setHidden:false];
//    [self.setButton2 setHidden:false];
//    [self.setButton3 setHidden:false];
//    [self.ExitButton setHidden:false];
//}

- (IBAction)exitButtonClicked:(id)sender {
    [self.ciecleDeatilMask2 setHidden:true];
    //[self.setButton1 setHidden:true];
    self.setButton1.hidden =YES;
    [self.setButton2 setHidden:true];
    [self.setButton3 setHidden:true];
    [self.ExitButton setHidden:true];
    [self.button setHidden:false];
    [self.searchButton setHidden:false];
    [self.settingButton setHidden:false];

    
    
}
- (IBAction)back:(id)sender {
    // 返回之前storyboard定义界面
    //[self.navigationController popViewControllerAnimated:YES];
      //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [SecondViewController setPage:1];

    
}
- (IBAction)searchButtonClicked:(id)sender {
    searchViewController *ContmetViewController =[[searchViewController alloc] init];
  [self.view addSubview:[ContmetViewController init].view];
   

    
    //UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[[searchController alloc] init]];

    //[self.view addSubview:[nav init].view];
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    

    
}

/**
 *  创建悬浮窗口
 */
- (void)createButton
{
    // 悬浮按钮
    _button = [UIDragButton buttonWithType:UIButtonTypeCustom];
    [_button setImage:[UIImage imageNamed:@"circledeatilset"] forState:UIControlStateNormal];
    // 按钮图片伸缩充满整个按钮
    _button.imageView.contentMode = UIViewContentModeScaleToFill;
    _button.frame = CGRectMake(0, 0, floatSize, floatSize);
    // 按钮点击事件
    [_button addTarget:self action:@selector(floatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    // 按钮点击事件代理
    _button.btnDelegate = self;
    // 初始选中状态
    _button.selected = YES;
    // 禁止高亮
    _button.adjustsImageWhenHighlighted = NO;
    _button.rootView = self.view.superview;
    
    // 悬浮窗
    _window = [[UIWindow alloc]initWithFrame:CGRectMake(ScreenW-floatSize, ScreenH/3.3, floatSize, floatSize)];
    _window.windowLevel = UIWindowLevelAlert+1;
    _window.backgroundColor = [UIColor clearColor];
    _window.layer.cornerRadius = floatSize/2;
    _window.layer.masksToBounds = YES;
    // 将按钮添加到悬浮按钮上
    [_window addSubview:_button];
    //显示window
    [_window makeKeyAndVisible];
}

-(void)dragButtonClicked:(UIButton *)sender {
    // 按钮选中关闭切换
    sender.selected = !sender.selected;
    //    if (sender.selected) {
    //        [sender setImage:[UIImage imageNamed:@"add_rotate"] forState:UIControlStateNormal];
    //    }else{
    //        [sender setImage:[UIImage imageNamed:@"add_button"] forState:UIControlStateNormal];
    //    }
    // 关闭悬浮窗
    //    [_window resignKeyWindow];
    //    _window = nil;
    [self.button setHidden:true];
    [self.searchButton setHidden:true];
    [self.settingButton setHidden:true];
    //self.setButton.hidden =YES;
    [self.ciecleDeatilMask2 setHidden:false];
    [self.setButton1 setHidden:false];
    [self.setButton2 setHidden:false];
    [self.setButton3 setHidden:false];
    [self.ExitButton setHidden:false];
    
    
    
}

-(void)floatBtnClicked:(id)sender
{
    [self.button setHidden:true];
    [self.searchButton setHidden:true];
    [self.settingButton setHidden:true];
    //self.setButton.hidden =YES;
    [self.ciecleDeatilMask2 setHidden:false];
    [self.setButton1 setHidden:false];
    [self.setButton2 setHidden:false];
    [self.setButton3 setHidden:false];
    [self.ExitButton setHidden:false];
}


- (IBAction)settingButoonClicked:(id)sender {
//    [self.button setHidden: true];
//    circleSettingVC *viewVC = [[circleSettingVC alloc]init];
//       [self.navigationController pushViewController:viewVC animated:YES];
//    viewVC.dargbutton =self.button;
    [self dismissViewControllerAnimated:YES completion:nil];
    [SecondViewController setPage:1];

}

- (IBAction)sendMessage:(id)sender {
    
    RRSendMessageViewController *controller = [[RRSendMessageViewController alloc] init];
    controller.topic_ids =[circleDeatilVC getIDinList];
    NSLog(@"top_id %@",controller.topic_ids);
    
    [controller presentController:self :^(RRMessageModel *model, BOOL isCancel) {
        if (isCancel == true) {
            NSLog(@" ");
        }
        else {
            NSLog(@"message :%@",model.text);
        }
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];

}

- (IBAction)setButton3Clicked:(id)sender {

    NameAndPicVC *newVC = [NameAndPicVC new];
    newVC.modalPresentationStyle = UIModalPresentationCustom;
    self.viewControllerTransitionDelegate.viewController = newVC;
    //[self presentViewController:newVC animated:YES completion:nil];
    //Or you can call this catogory method
   [self presentPortalTransitionViewController:newVC completion:nil];

    
////    
//    NameAndPicVC *vc = [[NameAndPicVC alloc] init];
//     [self.navigationController pushPortalTransitionViewController:vc completion:nil];
    
}

+(NSString *) getIDinList
{
    extern NSString *IDinList;
    return IDinList;
    
}
+(void) setIDinList :(NSString *) str
{
    IDinList = str;
}

@end
