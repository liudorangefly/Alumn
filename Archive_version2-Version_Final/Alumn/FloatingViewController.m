//
//  FloatingViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/28.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//
// 屏幕高度
#define ScreenH [UIScreen mainScreen].bounds.size.height
// 屏幕宽度
#define ScreenW [UIScreen mainScreen].bounds.size.width
// 悬浮按钮的尺寸
#define floatSize 120

#import "FloatingViewController.h"
#import "UIDragButton.h"
#import "circleDeatilVC.h"

@interface FloatingViewController ()<UIDragButtonDelegate>

/**
 *  悬浮的window
 */
@property(strong,nonatomic)UIWindow *window;

/**
 *  悬浮的按钮
 */
@property(strong,nonatomic)UIDragButton *button;

@end

@implementation FloatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 将视图尺寸设置为0，防止阻碍其他视图元素的交互
    self.view.frame = CGRectZero;
    // 延时显示悬浮窗口
    [self performSelector:@selector(createButton) withObject:nil afterDelay:1];
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
    _window = [[UIWindow alloc]initWithFrame:CGRectMake(ScreenW-floatSize, ScreenH/2, floatSize, floatSize)];
    _window.windowLevel = UIWindowLevelAlert+1;
    _window.backgroundColor = [UIColor clearColor];
    _window.layer.cornerRadius = floatSize/2;
    _window.layer.masksToBounds = YES;
    // 将按钮添加到悬浮按钮上
    [_window addSubview:_button];
    //显示window
    [_window makeKeyAndVisible];
}

/**
 *  悬浮按钮点击
 */
- (void)dragButtonClicked:(UIButton *)sender {
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
    circleDeatilVC *sethideToview =[ [circleDeatilVC alloc]init].current;
    [sethideToview.setButton1 setHidden:false];
    [sethideToview.setButton2 setHidden:false];
    [sethideToview.setButton3 setHidden:false];
    
    
    
    
}
-(void)floatBtnClicked:(UIButton *)sender
{
    [_window resignKeyWindow];
    _window = nil;
}

@end