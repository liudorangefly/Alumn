//
//  circleSettingVC.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/29.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "circleSettingVC.h"
#import "circleDeatilVC.h"

@interface circleSettingVC ()

@end

@implementation circleSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backItemClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    //[[circleDeatilVC.self button]setHidden:false];
    [self.dargbutton setHidden:false];
}

@end
