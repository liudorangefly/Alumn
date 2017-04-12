//
//  TabBarController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/23.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    // 设置TabBar tintColor
    //self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:222.0/255.0 green:124.0/255.0 blue:56.0/255.0 alpha:1];
    self.tabBar.tintColor = [UIColor colorWithRed:83.0/255.0 green:201.0/255.0 blue:139.0/255.0 alpha:1];
//    UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:0];
//    UIImage *imageSelected = [UIImage imageNamed:@"button_tab-bar2_pressed"];
//    UIImage *imageNormal = [UIImage imageNamed:@"button_tab-bar2_normal"];
//    
//    item.image = [imageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    item.selectedImage = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

}

@end

