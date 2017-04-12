//
//  ChatListViewController.m
//  ChatListDemo
//
//  Created by 韩雪滢 on 10/2/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "ChatListViewController.h"
#import <CDChatManager.h>
#import "ChatRoomViewController.h"

@interface ChatListViewController ()<CDChatListVCDelegate>

@property (nonatomic,strong)UITextField *textField;

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.tableView.tableHeaderView = headerView;
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, self.view.bounds.size.width - 30, 25)];
    _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textField.layer.borderWidth = 1;
    [headerView addSubview:_textField];
    
    UIButton * startChat = [UIButton buttonWithType:UIButtonTypeSystem];
    startChat.frame = CGRectMake(60, 35, self.view.bounds.size.width - 120, 20);
    [startChat setTitle:@"开始聊天" forState:UIControlStateNormal];
    [headerView addSubview:startChat];
    [startChat addTarget:self action:@selector(startChatClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.chatListDelegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startChatClicked:(id)sender{
    if(_textField.text.length > 0)
    {
        [[CDChatManager manager] fetchConversationWithOtherId:_textField.text callback:^(AVIMConversation *conversation, NSError *error) {
            ChatRoomViewController * chatRoom = [[ChatRoomViewController alloc]initWithConversation:conversation];
            [self.navigationController pushViewController:chatRoom animated:YES];
        }];
    }}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.tabBarController.tabBar.hidden = NO;
//}

- (void)viewController:(UIViewController *)viewController didSelectConv:(AVIMConversation *)conv
{
    ChatRoomViewController * chatRoom = [[ChatRoomViewController alloc]initWithConversation:conv];
   [self.navigationController pushViewController:chatRoom animated:YES];
//    [self presentViewController:chatRoom animated:YES completion:nil];
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
