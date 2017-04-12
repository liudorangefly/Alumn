//
//  SelfChatViewController.m
//  ChatListDemo
//
//  Created by 韩雪滢 on 10/2/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "SelfChatViewController.h"
#import <CDChatManager.h>
#import "ChatListViewController.h"

@interface SelfChatViewController ()

@end

@implementation SelfChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[CDChatManager manager]openWithClientId:@"韩雪滢" callback:^(BOOL succeeded, NSError *error) {
        ChatListViewController * chatList = [[ChatListViewController alloc]init];
        [self.navigationController pushViewController:chatList animated:YES];
//         [self presentViewController:chatList animated:YES completion:nil];
    }];
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
