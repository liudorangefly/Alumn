//
//  ChatViewController.m
//  ChatDemo
//
//  Created by 韩雪滢 on 10/1/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "ChatViewController.h"
#import "MeInfoViewController.h"
#import "MeInfoViewModel.h"
#import "PeopleViewController.h"

@interface ChatViewController ()
    
    @property (nonatomic,strong)MeInfoViewModel *meInfoVM;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.meInfoVM = [MeInfoViewModel getMeInfoVM];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, headView.bounds.size.width / 5.0, 40)];
    [backBtn setTitle:@"< Back" forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn addTarget:self action:@selector(backToPerson:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    headView.backgroundColor = [UIColor colorWithRed:111/255.0 green:214/255.0 blue:157/255.0 alpha:1.0];
    [self.view addSubview:headView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    - (void)backToPerson:(id)sender{
        
        NSLog(@"返回人脉详情");
        
        [self dismissViewControllerAnimated:NO completion:nil];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        
        
        NSString *fileNameSecond = [plistPath1 stringByAppendingPathComponent:@"personalDetailInfoSecond.plist"];
        NSMutableDictionary *dictSecond = [NSMutableDictionary dictionaryWithContentsOfFile:fileNameSecond];
        [self.meInfoVM setIfFollowed:[[dictSecond valueForKey:@"response"]valueForKey:@"has_followed"]];
        
        
        NSString *fileNameFirst = [plistPath1 stringByAppendingPathComponent:@"personalDetailInfoFirst.plist"];
        NSMutableDictionary *dictFirst = [NSMutableDictionary dictionaryWithContentsOfFile:fileNameFirst];
        [self.meInfoVM setInfo:dictFirst];

                
        PeopleViewController *peopleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"peopleVC"];
        [self.navigationController pushViewController:peopleVC animated:YES];
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
