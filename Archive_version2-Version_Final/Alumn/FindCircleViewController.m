//
//  FindCircleViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/27.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "FindCircleViewController.h"
#import "Circle_FindVC.h"
#import "User.h"
#import "Circle+Extension.h"

@interface FindCircleViewController ()

@end

@implementation FindCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ self setButtonStyle:_OccupationButton ];
    [self setButtonStyle:_jobButton];
    [self setButtonStyle:_hobbyButton];
    [self setButtonStyle:_factulButton];
    [self setButtonStyle:_fieldButton];
    [self setButtonStyle:_ClubButton];
    
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

-(void)clickEffect :(UIButton *) BUTTON image:(UIImageView *) myimage
{
    
    //    if (flag) {
    [UIView animateWithDuration:0.8 animations:^{
        //myimage.transform = CGAffineTransformMakeRotation(M_PI);
        //_enterpriseImage.transform =CGAffineTransformMakeScale(-1.0, 1.0);
        myimage.transform = CGAffineTransformMakeScale(0.7,0.7);
        
        //        } completion:^(BOOL finished) {
        //            flag = NO;
        //        }];
        //    }
        //    else {
        //        [UIView animateWithDuration:0.5 animations:^{
        //           myimage.transform = CGAffineTransformMakeRotation(0);
        //        } completion:^(BOOL finished) {
        //            flag = YES;
        //        }];
    }];
}

-(void)setButtonStyle:(UIButton *)mybutton
{
    
    [mybutton.layer setBorderWidth:1];
    [mybutton.layer setBorderColor :[UIColor grayColor].CGColor] ;
}
- (IBAction)factulClicked:(id)sender {
    
    [self clickEffect:self.factulButton image:self.enterpriseImage];
    NSLog(@"you click factul.");
    NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:@"57bdcad0d0146385e6abb6be",@"t_cat_id",@"999",@"count",@"1",@"page", nil];
    NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
    NSLog (@"%@",postdic);
    [Circle getTypetopicWithParameters:postdic ID:@"57bdcad0d0146385e6abb6be" SuccessBlock:^(NSDictionary *dict, BOOL success) {
        Circle_FindVC *setprize = [[Circle_FindVC alloc]initWithNibName:@"Circle_FindVC" bundle:nil];
        setprize.ID =@"57bdcad0d0146385e6abb6be" ;
        [self.navigationController pushViewController:setprize animated:true];
    }AFNErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"findCircle" bundle:nil];
    // UIViewController *VC = [sb instantiateViewControllerWithIdentifier:@"Circle_FindVC"];
    //[self.navigationController pushViewController:VC animated:YES];
    
    
    
}

- (IBAction)ClubClicked:(id)sender {
    flag =YES;
    [self clickEffect:self.ClubButton image:self.softwareImage];
    NSLog(@"you click club");
    NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:@"57cd04e8ea77f7753a8f3c28",@"t_cat_id",@"999",@"count",@"1",@"page", nil];
    NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
    NSLog (@"%@",postdic);
    [Circle getTypetopicWithParameters:postdic ID:@"57cd04e8ea77f7753a8f3c28" SuccessBlock:^(NSDictionary *dict, BOOL success) {
        Circle_FindVC *setprize = [[Circle_FindVC alloc]initWithNibName:@"Circle_FindVC" bundle:nil];
        setprize.ID =@"57cd04e8ea77f7753a8f3c28" ;
        [self.navigationController pushViewController:setprize animated:true];
    }AFNErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (IBAction)jobClicked:(id)sender {
    [self clickEffect:self.jobButton image:self.InternshipImage];
    NSLog(@"you click job");
    NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:@"57cd04ba55c400f83aa1384d",@"t_cat_id",@"999",@"count",@"1",@"page", nil];
    NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
    NSLog (@"%@",postdic);
    [Circle getTypetopicWithParameters:postdic ID:@"57cd04ba55c400f83aa1384d" SuccessBlock:^(NSDictionary *dict, BOOL success) {
        Circle_FindVC *setprize = [[Circle_FindVC alloc]initWithNibName:@"Circle_FindVC" bundle:nil];
        setprize.ID =@"57cd04ba55c400f83aa1384d" ;
        [self.navigationController pushViewController:setprize animated:true];
    }AFNErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
- (IBAction)fieldClicked:(id)sender {
    [self clickEffect:self.fieldButton image:self.lawImage];
    NSLog(@"you click field");
    NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:@"57bdcae1b51b2d1717bd4e49",@"t_cat_id",@"999",@"count",@"1",@"page", nil];
    NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
    NSLog (@"%@",postdic);
    [Circle getTypetopicWithParameters:postdic ID:@"57bdcae1b51b2d1717bd4e49" SuccessBlock:^(NSDictionary *dict, BOOL success) {
        Circle_FindVC *setprize = [[Circle_FindVC alloc]initWithNibName:@"Circle_FindVC" bundle:nil];
        setprize.ID =@"57bdcae1b51b2d1717bd4e49";
        [self.navigationController pushViewController:setprize animated:true];
    }AFNErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (IBAction)hobbyClicked:(id)sender {
    [self clickEffect:self.hobbyButton image:self.ecoManImage];
    NSLog(@"you click hobby");
    NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:@"57cbd6747019c95ec2d856eb",@"t_cat_id",@"999",@"count",@"1",@"page", nil];
    NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
    NSLog (@"%@",postdic);
    [Circle getTypetopicWithParameters:postdic ID:@"57cbd6747019c95ec2d856eb" SuccessBlock:^(NSDictionary *dict, BOOL success) {
        Circle_FindVC *setprize = [[Circle_FindVC alloc]initWithNibName:@"Circle_FindVC" bundle:nil];
        setprize.ID =@"57cbd6747019c95ec2d856eb";
        [self.navigationController pushViewController:setprize animated:true];
    }AFNErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (IBAction)occupationButtonClicked:(id)sender {
    
    [self clickEffect:self.OccupationButton image:self.electricImage];
    NSLog(@"you click occupation");
    NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:@"57cd049d55c400f83aa1384c",@"t_cat_id",@"999",@"count",@"1",@"page", nil];
    NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
    NSLog (@"%@",postdic);
    [Circle getTypetopicWithParameters:postdic ID:@"57cd049d55c400f83aa1384c" SuccessBlock:^(NSDictionary *dict, BOOL success) {
        Circle_FindVC *setprize = [[Circle_FindVC alloc]initWithNibName:@"Circle_FindVC" bundle:nil];
        setprize.ID =@"57cd049d55c400f83aa1384c";
        [self.navigationController pushViewController:setprize animated:true];
    }AFNErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


@end
