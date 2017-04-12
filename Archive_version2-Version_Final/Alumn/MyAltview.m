//
//  MyAltview.m
//  MyAltview
//
//  Created by Dorangefly Liu on 16/8/31.
//  Copyright © 2016年 Dorangefly Liu. All rights reserved.
//

#import "MyAltview.h"
#import "UIView+SDAutoLayout.h"
#import <QuartzCore/QuartzCore.h>
#import "Circle_FindVC.h"
#import   "UIImageView+WebCache.h"
#import "JIONVC.h"
#import "User.h"
#import "Circle+Extension.h"
#define floatSize 300

// 屏幕高度
#define ScreenH [UIScreen mainScreen].bounds.size.height
// 屏幕宽度
#define ScreenW [UIScreen mainScreen].bounds.size.width
@implementation MyAltview
{
    
}
@synthesize view;
@synthesize altwidth;
@synthesize deleta;


-(void)CreatAlt:(UIImage*)backimg circleName:(NSString *) Name altTitle:(NSString *)Title  Content:(NSString *)content altButton:(NSArray *)altbtnArray altbtnTcolor:(UIColor *)color altselectbtnTcolor:(UIColor *)selectcolor icon:(NSString *)icon_urls creator_id:(NSString *)creatorID circle_ID:(NSString *)circleID
{
    self.circleName =Name;
    self.circlrurl=icon_urls;
    self.creatorid=creatorID;
    self.circleid=circleID;
    

    
    view=[UIView new];
    [view setFrame:CGRectMake(ScreenW/2, ScreenH/2, 350, 240)];
    view.sd_layout
    .widthIs(350)
    .heightIs(250);
    [view setBackgroundColor:[UIColor whiteColor]];
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
   
  
    
    
    UIImageView *CirclePic =[UIImageView new];
    [CirclePic  sd_setImageWithURL:[NSURL URLWithString:icon_urls] placeholderImage:[UIImage imageNamed:@"7"]];
    CirclePic.sd_layout
    .heightIs(view.height/1.6)
    .widthIs(altwidth)
    .topSpaceToView(view,0)
    .leftSpaceToView(view,0);
    [view addSubview:CirclePic];
    
    
    UIImageView *back = [UIImageView new];
    [back setImage:[UIImage imageNamed:@"circleDeatilMask"]];
    back.alpha=0.5;
    back.sd_layout
    .heightIs(view.height/1.6)
    .widthIs(altwidth)
    .topSpaceToView(view,0)
    .leftSpaceToView(view,0);
    [view addSubview:back];
    
    
    
    
    UIImageView *Ximg=[UIImageView new];
    //[Ximg setImage:[UIImage imageNamed:@"7"]];
    [Ximg sd_setImageWithURL:[NSURL URLWithString:icon_urls] placeholderImage:[UIImage imageNamed:@"7"]];
    [Ximg setUserInteractionEnabled:YES];
    //UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    //[Ximg addGestureRecognizer:singleTap];
    Ximg.sd_layout
    .heightIs(70)
    .widthIs(70)
    .topSpaceToView(back,-35)
    .centerXEqualToView(back);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:Ximg.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:Ximg.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = Ximg.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    Ximg.layer.mask = maskLayer;
    [Circle_FindVC animationAlert:Ximg];
    [view addSubview:Ximg];
    
    UILabel *circleName=[UILabel new];
    _name=Name;
    circleName.text=_name;
    [circleName setLineBreakMode: UILineBreakModeWordWrap];
    //CGSize size1 = [_name sizeWithFont:[UIFont systemFontOfSize:29.0f] constrainedToSize:CGSizeMake(MAXFLOAT, circleName.frame.size.height)];
    CGSize size1 = [_name  sizeWithFont:[UIFont systemFontOfSize:20.0f] constrainedToSize:CGSizeMake(altwidth-20, 700.0f) lineBreakMode:NSLineBreakByCharWrapping ];
    [circleName setNumberOfLines:0];
    [circleName setTextAlignment:NSTextAlignmentCenter];
    [circleName setFont:[UIFont systemFontOfSize:20]];
    [circleName setTextColor:[UIColor  blackColor]];
    [circleName setBackgroundColor:[UIColor clearColor]];
    circleName.sd_layout
    .widthIs(size1.width)
    .heightIs((int)size1.height+5)
    .topSpaceToView(Ximg,2)
    .centerXEqualToView(back);
    altheight +=size1.height+5;
    [view addSubview:circleName];
    

    
    
     UILabel *alttitle=[UILabel new];
    _str=Title;
    alttitle.text=_str;
    CGSize size2 = [_str sizeWithFont:alttitle.font constrainedToSize:CGSizeMake(MAXFLOAT, alttitle.frame.size.height)];
    [alttitle setNumberOfLines:1];
    [alttitle setTextAlignment:NSTextAlignmentCenter];
    [alttitle setFont:[UIFont systemFontOfSize:14]];
    [alttitle setTextColor:[UIColor  blackColor]];
    [alttitle setBackgroundColor:[UIColor clearColor]];
    [view addSubview:alttitle];
    alttitle.sd_layout
    .widthIs(size2.width)
    .heightIs(20)
    .topSpaceToView(circleName,5)
    .centerXEqualToView(back);
    
    UIImageView *king =[UIImageView new];
    [king setImage:[UIImage imageNamed:@"king"]];
    king.sd_layout
    .heightIs(15)
    .widthIs(15)
    .topSpaceToView(circleName,5)
    .leftSpaceToView(alttitle,0);
    [Circle_FindVC animationAlert:king];
    [view addSubview:king];
    
    UIImageView *line = [UIImageView new];
    [line setImage:[UIImage imageNamed:@"line.png"]];
    line.alpha=0.7;
    line.sd_layout.
    heightIs(2)
    .widthIs(altwidth-40)
    .centerXEqualToView(back)
    .topSpaceToView(alttitle,5);
    [view addSubview:line];
    
    UILabel *altcontent=[[UILabel alloc] init];
    [altcontent setText:content];
    [altcontent setNumberOfLines:0];
    [altcontent setFont:[UIFont systemFontOfSize:17.0f]];
    [altcontent setTextAlignment:NSTextAlignmentLeft];
    [altcontent setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    [altcontent setLineBreakMode:NSLineBreakByCharWrapping];
    
    CGSize size=[altcontent.text  sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(altwidth-20, 700.0f) lineBreakMode:NSLineBreakByCharWrapping ];
    //[altcontent setFrame:CGRectMake(altwidth-20, (int)size.height+5)];
    altcontent.sd_layout
    .widthIs(altwidth-20)
    .heightIs((int)size.height+5)
    .topSpaceToView(line ,5)
    .centerXEqualToView(alttitle);
    [altcontent setTextAlignment:NSTextAlignmentCenter];
    altcontent.numberOfLines = (int)size.height/20+1;
    altheight=255+altcontent.frame.size.height+circleName.frame.size.height;
    [view addSubview:altcontent];
    
    if(altbtnArray==nil)
    {
        
        UIButton *altbut=[UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *altbut1=[UIButton new];
        [altbut setTitle:@"申请加入" forState:UIControlStateNormal];
        //[altbut setTitle:@"取消" forState:UIControlStateHighlighted];
        [altbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [altbut setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [altbut setBackgroundColor:[UIColor colorWithRed:67/255.0 green:207/255.0 blue:118/255.0 alpha:1]];
        [altbut setTag:0];
        //[altbut setFrame:CGRectMake((altwidth/2-50)/2, altheight, 50, 35)];
        altbut.sd_layout
        .topSpaceToView(altcontent,1)
        .heightIs(altwidth/2-20)
        .widthIs(43);
        [altbut setFrame:CGRectMake(altwidth/2+5, altheight-4, altwidth/2-20, 43)];
//        altbut.sd_layout
//        .heightIs(45)
//        .widthIs(altwidth/2-20)
//        .topSpaceToView(altcontent,10)
//        .rightSpaceToView(altbut1,20);
        altbut.layer.borderWidth=0.5;
        altbut.layer.borderColor =[UIColor whiteColor].CGColor;
        [altbut.layer setMasksToBounds:YES];
        [altbut.layer setCornerRadius:8.0];
        [altbut addTarget:self action:@selector(checkbtn1:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        //UIButton *altbut1=[UIButton buttonWithType:UIButtonTypeCustom];
        [altbut1 setTitle:@"联系我" forState:UIControlStateNormal];
        //[altbut1 setTitle:@"确认" forState:UIControlStateHighlighted];
        [altbut1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [altbut1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [altbut1 setBackgroundColor:[UIColor colorWithRed:67/255.0 green:207/255.0 blue:118/255.0 alpha:1]];
        [altbut1 setTag:1];
        altbut1.sd_layout
        .widthIs(altwidth/2-20)
        .heightIs(45)
        .topSpaceToView(altcontent, 1)
        .rightSpaceToView(self.view,20);
        [altbut1 setFrame:CGRectMake(15, altheight+7, altwidth/2-20, 43)];
               [altbut1 addTarget:self action:@selector(checkbtn:) forControlEvents:UIControlEventTouchUpInside];
        altbut1.layer.borderWidth=0.5;
        altbut1.layer.borderColor =[UIColor whiteColor].CGColor;
        [altbut1.layer setMasksToBounds:YES];
        [altbut1.layer setCornerRadius:8.0];

        [view addSubview:altbut];
        [view addSubview:altbut1];
        altheight+=30;
        
    }
    else
    {
        
        
    }
    
    [view setFrame:CGRectMake((ScreenW-altwidth)/2, ([UIScreen mainScreen].bounds.size.height-altheight)/2, altwidth , altheight)];
     //[view setFrame:CGRectMake(ScreenH/3-120, ScreenW/3-120, altwidth , altheight)];
    view.sd_layout
    .heightIs(altheight)
    .widthIs(altwidth);
    if(backimg==nil)
    {
        [view setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        [view setBackgroundColor:[UIColor colorWithPatternImage:backimg]];
    }
    
    
}


-(void)alertview:(id)altview clickbuttonIndex:(NSInteger)index
{
    NSLog(@"abcderfv");
    [deleta alertview:self clickbuttonIndex:index];
}
-(void)showmessage
{
    NSLog(@"asd");
}
-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self hide];
}
-(void)checkbtn:(UIButton *)sender
{
    //[deleta showmessage];
    //[deleta alertview:self clickbuttonIndex:sender.tag];
    //    [self hide];
     NSLog(@"dadasdadaddafafgacza");
    
}

-(void)checkbtn1:(UIButton *)sender
{
    NSLog(@"dadasdadaddafaknlnlknlfgacza");
    //    [self hide];
//    JIONVC *vc = [[JIONVC alloc]init];
//    [vc.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
//    self.userInteractionEnabled=false;
//    [self.view addSubview:vc.view];
    NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",
                             self.circleName,@"circle_name",
                             self.circleid,@"circle_id",
                             self.circlrurl,@"circle_url",
                             @"",@"reason",
                             self.creatorid,@"creator_id",
                              nil];
    NSLog(@"hhghjghj%@",userInfo);
    [Circle joinCircleWithParameters:userInfo SuccessBlock:^(NSDictionary *dict, BOOL success) {
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已发送加入申请" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert1 show];
        [self hide];
    } AFNErrorBlock:^(NSError *error) {
        //NSLog(@"%@",error);
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送请求中出现了错误，请重试" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert2 show];
    }];
    
   
    
    
}
-(void)show
{
    if(view==nil)
    {
        view=[[UIView alloc] init];
    }
    [view setHidden:NO];
}
-(void)hide
{
    if(view==nil)
    {
        view=[[UIView alloc] init];
    }
    [view setHidden:YES];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code 
 } 
 */  

@end
