//
//  ChatRoomViewController.m
//  Alumn
//
//  Created by 韩雪滢 on 10/2/16.
//  Copyright © 2016 刘龙飞. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "ChatListViewController.h"
#import "MessageViewController.h"
#import "TabBarController.h"

@interface ChatRoomViewController ()

@property (nonatomic,strong) UINavigationController *naviVC;

@end

@implementation ChatRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.naviVC = [[UINavigationController alloc] init];
    // Do any additional setup after loading the view.
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, headView.bounds.size.width / 5.0, 40)];
    [backBtn setTitle:@"< Back" forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn addTarget:self action:@selector(backToChatList:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    headView.backgroundColor = [UIColor colorWithRed:111/255.0 green:214/255.0 blue:157/255.0 alpha:1.0];
    [self.view addSubview:headView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backToChatList:(id)sender{
    
    //    [self dismissViewControllerAnimated:NO completion:nil];
    
    //    [[CDChatManager manager]openWithClientId:@"韩雪滢" callback:^(BOOL succeeded, NSError *error) {
    ////        ChatListViewController * chatList = [[ChatListViewController alloc]init];
    ////        //    [self.navigationController pushViewController:chatList animated:YES];
    ////
    ////        MessageViewController *messageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"messageVC"];
    ////
    //////        [self presentViewController:messageVC animated:YES completion:nil];
    ////        [self.navigationController pushViewController:messageVC animated:YES];
    //
    //        TabBarController *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FiveTab"];
    //         [self presentViewController:tabBarVC animated:YES completion:nil];
    //    }];
    
     MessageViewController *messageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"messageVC"];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *VC = [sb instantiateViewControllerWithIdentifier:@"FiveTab"];
    
    [self.navigationController pushViewController:VC animated:YES];

//     [self presentViewController:messageVC animated:YES completion:nil];
    
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
