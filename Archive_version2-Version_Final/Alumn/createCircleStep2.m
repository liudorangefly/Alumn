//
//  createCircleStep2.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/8.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "createCircleStep2.h"
#import "AFNetManager.h"
#import "Circle+Extension.h"
#import "User.h"
#import "TabBarController.h"
@interface createCircleStep2 ()

@end

@implementation createCircleStep2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.finishItem setEnabled:true];
    self.view.userInteractionEnabled =YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapGesture];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *plistName =[[NSString alloc] initWithFormat:@"User.plist"];
    NSLog(@"circle Plsit of dynamic%@",plistName);
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:plistName];
    NSDictionary *dict  = [NSDictionary dictionaryWithContentsOfFile:fileName];
    NSLog(@"大bug%@",[dict objectForKey:@"name"]);
    creator_name = [dict objectForKey:@"name"];
    self.uid = [dict objectForKey:@"uid"];
    _typeArray = [NSArray arrayWithObjects:@"社团圈",@"职业圈",@"创业圈",@"地域圈",@"院系圈",@"兴趣圈",nil];
//    self.TYPE_id = [NSArray arrayWithObjects:@"57cd04e8ea77f7753a8f3c28",
//                                                          @"57cd04ba55c400f83aa1384d",
//                                                          @"57cd049d55c400f83aa1384c",
//                                                          @"57cbd6747019c95ec2d856eb",
//                                                          @"57bdcad0d0146385e6abb6be",
//                                                          @"57cbd6747019c95ec2d856eb",nil];
    // Do any additional setup after loading the view from its nib.
//    self.NameLabel.frame=CGRectMake(0, 106, 375, 34);
//    self.NameLabel.numberOfLines=0;
//    self.NameLabel.textAlignment=NSTextAlignmentCenter;
      [self.finishItem setEnabled:true];
     CGSize size =[self.circleName sizeWithFont:_NameLabel.font constrainedToSize:CGSizeMake(_NameLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    [self.NameLabel setFrame:CGRectMake(0, 106, 375, size.height)];
    NSLog(@"%@",self.circleName);
     self.NameLabel.text = self.circleName;
    self.reasonlabel.enabled = NO;
    self.introLabel.enabled =NO;
    self.reasonlabel.text = @"在此处填写您创建该圈子的理由";
    self.introLabel.text =@"在此处填写您对该圈子的介绍";
    self.pickerView.delegate=self;
    self.pickerView.frame = CGRectMake(0, 667, 375, 140);
    self.pickerView.hidden = YES;
    self.reasaonTextView.delegate =self;
    self.introTextView.delegate =self;
    if(self.reasaonTextView.text.length!=0&&self.introTextView.text.length!=0&&self.typeLabel.text!=0)
    {
        [self.finishItem setEnabled:false];
    }
    
    
    
    
    
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

#pragma mark pickerview function

//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回指定列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
     return [_typeArray count];
    
}
//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 25.0f;
}
//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component==0) {//iOS6边框占10+10
        return  self.view.frame.size.width;
    } else if(component==1){
        return  self.view.frame.size.width;
    }
    return  self.view.frame.size.width;
}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    text.textAlignment = NSTextAlignmentCenter;
    text.text = [_typeArray objectAtIndex:row];
    [view addSubview:text];
    
    return view;
}
//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = [_typeArray objectAtIndex:row];
    return str;
}
//显示的标题字体、颜色等属性
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = [_typeArray objectAtIndex:row];
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
    
    return AttributedString;
}//NS_AVAILABLE_IOS(6_0);

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"HANG%@",[_typeArray objectAtIndex:row]);
    self.typeLabel.text =[_typeArray objectAtIndex:row];
    self.typeName = [_typeArray objectAtIndex:row];
    
}

- (void)textViewDidChange:(UITextView *)textView {
//    if(self.reasaonTextView.text.length==0)
//    {
//        self.reasonlabel.text = @"在此处填写您创建该圈子的理由";
//    }else{
//        self.reasonlabel.text=@"";
//    }
//    if(self.introTextView.text.length==0)
//    {
//        self.introLabel.text =@"在此处填写您对该圈子的介绍";
//    }else
//    {
//        self.introLabel.text=@"";
//    }
    self.introLabel.hidden= self.introTextView.hasText;
    self.reasonlabel.hidden = self.reasaonTextView.hasText;
    intro = self.introTextView.text;
    reason =self.reasaonTextView.text;
}



- (IBAction)inView:(id)sender {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    self.pickerView.frame = CGRectMake(0, 245, 320, 260);
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
-(void)animationFinished{
    NSLog(@"动画结束!");
}

- (void)ViewAnimation:(UIView*)view willHidden:(BOOL)hidden {
    
    [UIView animateWithDuration:2 animations:^{
        if (hidden) {
            view.frame = CGRectMake(0, 560, 375, 140);
        }
    } completion:^(BOOL finished) {
        [view setHidden:hidden];
    }];
}

- (IBAction)popViewture:(id)sender {
    
    [self ViewAnimation:self.pickerView willHidden:NO];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)finish:(id)sender {
    NSLog(@"%@12334",self.typeName);
    //NSLog(@"%@3456",[self.TYPE_id objectForKey:self.typeName]);
    NSLog(@"%@4566",reason);
    NSLog(@"%@6789",intro);
    NSLog(@"dasdasdBUFf%@",creator_name);
    if(reason.length!=0&&intro.length!=0&&self.typeName.length!=0)
    {
    [Circle uploadPicture:self.image method:@"upload_normal_img" SuccessBlock:^(NSDictionary *dict, BOOL success) {
        NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",
                                 self.circleName,@"circle_name",
                                 [dict objectForKey:@"img_key"],@"circle_icon_url",
                                 self.uid,@"creator_uid",
                                 self.typeName,@"circle_type_name",
                                 reason,@"reason_message",
                                 intro,@"description",
                                 creator_name,@"creator_name",nil];
        NSLog (@"创建圈子%@",userInfo);
        [Circle createCircleWithParamenters:userInfo];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"bug %@",error);
    }];
    
//    TabBarController *vc =[[TabBarController alloc]init];
//  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
        
        }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确内容" message:@"请输入不为空的内容" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
  
    
    
}

- (void)reKeyBoard:(UITapGestureRecognizer *)gesture
{
    NSLog(@"单机");
    
    [self.introTextView resignFirstResponder];
    [self.reasaonTextView resignFirstResponder];
    
}




@end
