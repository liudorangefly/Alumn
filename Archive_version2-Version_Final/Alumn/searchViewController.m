//
//  searchViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/26.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "searchViewController.h"
#import "RNContainerController.h"

@interface searchViewController ()

@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RNContainerController *ContmetViewController =[[RNContainerController alloc] init];
    [self.view addSubview:[ContmetViewController init].view];

    
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

@end
