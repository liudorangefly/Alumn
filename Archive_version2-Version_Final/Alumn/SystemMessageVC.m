//
//  SystemMessageVC.m
//  Alumn
//
//  Created by 韩雪滢 on 10/6/16.
//  Copyright © 2016 刘龙飞. All rights reserved.
//

#import "SystemMessageVC.h"
#import "MessageDetailVM.h"
#import "MessageViewController.h"

@interface SystemMessageVC ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentLabel;

@property (strong,nonatomic) NSDictionary *messageDic;

@end

@implementation SystemMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.messageDic = [MessageDetailVM getMessageDic];
    
    self.timeLabel.text = [self.messageDic valueForKey:@"update_time"];
    
    NSNumber *type = [self.messageDic valueForKey:@"type"];
    NSString *content = [[NSString alloc] init];
    switch(type.integerValue){
        case 0:{
            content = @"您申请运营的圈子%@，已通过审核，您现在可以在 我的－管理的圈子 面板中找到它\n感谢您的支持！",[[self.messageDic valueForKey:@"message"]valueForKey:@"circle_name"];
            break;
        }
        case 1:{
            content = @"您申请运营的圈子%@，由于一些原因，未通过审核。\n感谢您的支持！",[[self.messageDic valueForKey:@"message"]valueForKey:@"circle_name"];
            break;
        }
        case 2:{
            content = @"%@加入%@",[[self.messageDic valueForKey:@"message"]valueForKey:@"apply_name"],[[self.messageDic valueForKey:@"message"]valueForKey:@"circle_name"];
            break;
        }
        case 3:{
            NSString *result = [[NSString alloc] init];
            NSNumber *nresult = [[self.messageDic valueForKey:@"message"]valueForKey:@"result"];
            if(nresult.integerValue == 1){
                result = @"已通过审核，欢迎您的加入。";
            }else if(nresult.integerValue == 2){
                result = @"未通过审核，感谢您的申请。";
            }
            
              content = [NSString stringWithFormat:@"您申请加入的圈子%@: %@",[[self.messageDic valueForKey:@"message"]valueForKey:@"circle_name"],result];
            break;
        }
    }
    
    self.contentLabel.text = content;
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
- (IBAction)okBtn:(id)sender {
    
    MessageViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"FiveTab"];
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
