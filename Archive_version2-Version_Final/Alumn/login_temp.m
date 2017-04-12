//
//  login_temp.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/7.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "login_temp.h"
#import "User+Extension.h"
#import "Circle+Extension.h"

@interface login_temp ()

@end

@implementation login_temp

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [User loginWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
        NSLog(@"log in");
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
  

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (IBAction)maincircleGet:(id)sender {
//      [Circle getMainPageCircleWithParameters:nil];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
