//
//  ApplyMessageVC.m
//  Alumn
//
//  Created by 韩雪滢 on 10/6/16.
//  Copyright © 2016 刘龙飞. All rights reserved.
//

#import "ApplyMessageVC.h"
#import "MessageDetailVM.h"
#import "User.h"
#import "User+Extension.h"
#import "MeInfoViewController.h"
#import "MeInfoViewModel.h"
#import "MessageViewController.h"

@interface ApplyMessageVC ()
@property (weak, nonatomic) IBOutlet UIButton *disagreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *applyerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *facultyLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *circleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *reasonLabel;

@property (strong,nonatomic) NSDictionary *messageDic;
@property (strong,nonatomic) NSDictionary *response;

@property (strong,nonatomic) MeInfoViewModel *meInfoVM;

@end

@implementation ApplyMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.disagreeBtn.layer setBorderWidth:0.8];
    self.disagreeBtn.layer.borderColor = [UIColor colorWithRed:99/255.0 green:212/255.0 blue:140/255.0 alpha:1.0].CGColor;

    self.messageDic = [MessageDetailVM getMessageDic];
    
    self.meInfoVM = [MeInfoViewModel getMeInfoVM];
    
    NSLog(@"获得的messageDic :%@",self.messageDic);
    
    NSDictionary *personalRequest = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[[self.messageDic valueForKey:@"message"]valueForKey:@"apply_uid"],@"uid", nil];
    
    NSLog(@"获得申请人详情的dic :%@",personalRequest);
    
    [User getPersonalInfo:personalRequest SuccessBlock:^(NSDictionary *dict, BOOL success) {
        
        NSLog(@"获得申请人详情成功");
        
        NSLog(@"申请人详情 %@",dict);
        
        self.response = [[dict valueForKey:@"Data"]valueForKey:@"response"];
        self.nameLabel.text = [[self.response valueForKey:@"name"] substringFromIndex:11];
        self.facultyLabel.text = [NSString stringWithFormat:@"%@%@",[[self.response valueForKey:@"custom"] valueForKey:@"fa"],[[self.response valueForKey:@"custom"] valueForKey:@"ay"]];
        self.majorLabel.text = [[self.response valueForKey:@"custom"] valueForKey:@"ma"];
        self.jobLabel.text = [[self.response valueForKey:@"custom"] valueForKey:@"jo"];
        self.circleNameLabel.text = [[self.messageDic valueForKey:@"message"]valueForKey:@"circle_name"];
        self.timeLabel.text = [self.messageDic valueForKey:@"update_time"];
        self.reasonLabel.text = [[self.messageDic valueForKey:@"message"]valueForKey:@"reason"];
      
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.response valueForKey:@"icon_url"]]]];
        [self.applyerImg setImage:[self OriginImage:img scaleToSize:self.applyerImg.bounds.size]];
        self.applyerImg.layer.masksToBounds = YES;
        self.applyerImg.layer.cornerRadius = self.applyerImg.bounds.size.width / 2.0;
        
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"获得申请人详情失败");
    }];
    // Do any additional setup after loading the view.
}

//改变图片的大小适应image View的大小
-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
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
- (IBAction)disagree:(id)sender {
    
    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[NSNumber numberWithInt:2],@"result",[[self.messageDic valueForKey:@"message"]valueForKey:@"apply_uid"],@"apply_user_id",[[self.response valueForKey:@"name"] substringFromIndex:11],@"apply_user_name",[[self.messageDic valueForKey:@"message"]valueForKey:@"circle_id"],@"circle_id",[[self.messageDic valueForKey:@"message"]valueForKey:@"circle_name"],@"circle_name",[[self.messageDic valueForKey:@"message"]valueForKey:@"circle_url"],@"circle_url",nil];
    
    NSLog(@"发送的拒绝request ：%@",requestDic);
    
    [User checkApplyWithParameters:requestDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
        NSLog(@"拒绝发送成功");
        MessageViewController *messageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FiveTab"];
        [self.navigationController pushViewController:messageVC animated:YES];

    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"拒绝发送失败");
    }];
    
    
}
- (IBAction)agree:(id)sender {
   NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[NSNumber numberWithInt:1],@"result",[[self.messageDic valueForKey:@"message"]valueForKey:@"apply_uid"],@"apply_user_id",[[self.response valueForKey:@"name"] substringFromIndex:11],@"apply_user_name",[[self.messageDic valueForKey:@"message"]valueForKey:@"circle_id"],@"circle_id",[[self.messageDic valueForKey:@"message"]valueForKey:@"circle_name"],@"circle_name",[[self.messageDic valueForKey:@"message"]valueForKey:@"circle_url"],@"circle_url",nil];
    
    NSLog(@"发送的同意request %@",requestDic);
    
    [User checkApplyWithParameters:requestDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
        NSLog(@"同意发送成功：%@",dict);
        MessageViewController *messageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FiveTab"];
        [self.navigationController pushViewController:messageVC animated:YES];
        
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"同意发送失败");
    }];

}
- (IBAction)detail:(id)sender {
    
        [self.meInfoVM setIfFollowed:[self.response valueForKey:@"has_followed"]];
    
        NSDictionary *source = [[NSDictionary alloc]initWithObjectsAndKeys:[[self.response valueForKey:@"custom"]valueForKey:@"ct"],@"city",[[self.response valueForKey:@"name"]substringFromIndex:11],@"name",[[self.response valueForKey:@"custom"]valueForKey:@"jo"],@"job",[[self.response valueForKey:@"custom"]valueForKey:@"fa"],@"faculty",[[self.response valueForKey:@"custom"]valueForKey:@"ma"],@"major",[[self.response valueForKey:@"custom"]valueForKey:@"ay"],@"admission_year",[self.response valueForKey:@"icon_url"],@"icon_url", nil];
    NSDictionary *allInfo = [[NSDictionary alloc] initWithObjectsAndKeys:source,@"_source",[[self.response valueForKey:@"custom"]valueForKey:@"uid"],@"_id", nil];
    
        [self.meInfoVM setInfo:allInfo];
    
        
        MeInfoViewController *meInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"meInfo"];
        [self.navigationController pushViewController:meInfoVC animated:YES];
        
}

@end
