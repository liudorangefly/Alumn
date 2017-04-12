//
//  ShowImageViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "ShowImageViewController.h"
#import "ShowImageView.h"
@interface ShowImageViewController ()

@end

@implementation ShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ShowImageView *showImageView = [[ShowImageView alloc]initWithFrame:self.view.bounds byClickTag:self.clickTag appendArray:self.imageViews];
    //SDPhotoBrowser *showImageView = [[SDPhotoBrowser alloc]init];
    //[showImageView  =self.imageViews;
    [self.view addSubview:showImageView];
    showImageView.removeImg = ^(){
        self.navigationController.navigationBarHidden =NO;
        [self.navigationController popViewControllerAnimated:YES];
    };
     

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
