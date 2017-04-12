//
//  CircleViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#import "CircleViewController.h"
#import "HeaderContent.h"
#import "CircleGroupCell.h"
#import "ShowImageViewController.h"
#import "ReplyInputView.h"
#import "DemoVC5.h"
#import "Circle+Extension.h"
#include "UIView+SDAutoLayout.h"
#import "circleDeatilVC.h"
#include "User.h"



// 屏幕高度
#define ScreenH [UIScreen mainScreen].bounds.size.height
// 屏幕宽度
#define ScreenW [UIScreen mainScreen].bounds.size.width
@interface CircleViewController ()
@property (nonatomic,strong)NSMutableArray *circleGroupData;
@property (nonatomic,weak)UIButton *replyButton; //点击后弹出的评论按钮
@property (nonatomic,weak)UIButton *likeButton;
@property (nonatomic,weak)ReplyInputView *replyInputView;
@property (nonatomic,assign)BOOL flag;  //用于键盘出现时函数调用多次的情况
@property (weak, nonatomic) IBOutlet UITableView *circleTableView;


//用于view的移动，使评论框落在cell下面，没想到别的方法
@property (nonatomic,assign)float replyViewDraw;

//工具栏的高约束，用于当输入文字过多时改变工具栏的约束
@property (strong, nonatomic) NSLayoutConstraint *replyInputViewConstraintHeight;
@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.circleTableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if([[[DemoVC5 getCurrentCell] objectForKey:@"liked"] isEqualToString:@"True"])
    {
        [self.like_btn setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
    }else{
        [self.like_btn setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
    }
    self.flag = YES;
    //获取通知中心
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //注册为被通知者
    [notificationCenter addObserver:self selector:@selector(keyChange:) name:UIKeyboardDidShowNotification object:nil];

}

#define headViewHeight 200
#define headIconWidth 50
#define headIconHeight 50



#pragma mark - tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%lu",(unsigned long)[self.statusFrames count]);
    //return [self.circleGroupData count];
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //虽然返回1，但是每个indexpath的section为0
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircleGroupCell *cell = [CircleGroupCell cellWithTableView:tableView];
    cell.circleGroupFrame = self.circleGroupData[indexPath.row];
    [cell.replyButton addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self replyAction:_like_btn];
    [cell.likeButton addTarget:self action:@selector(likeButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
    cell.replyButton.tag = indexPath.row;   //评论时可以知道加到第几行
    cell.imageBlock = ^(NSArray *imageViews, NSInteger clickTag) {
        self.navigationController.navigationBarHidden = YES;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ShowImageViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ShowImage"];
        [vc setHidesBottomBarWhenPushed:YES]; //隐藏tabbar
        vc.clickTag = clickTag;
        vc.imageViews = imageViews;
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    return cell;
}

-(NSMutableArray *)circleGroupData
{
    if (!_circleGroupData) {
//        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"CircleGroup.plist" ofType:nil];
//        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:1];
//        for (NSDictionary *dict in dictArray) {
          NSLog(@"xiangqing  ---%@",[[DemoVC5 getCurrentCell] objectForKey:@"feed_id"]);
        //NSString *num=[[NSString alloc]initWithFormat:@"%@",[[DemoVC5 getCurrentCell] objectForKey:@"liked_num"]];
        NSNumber *convert= [[DemoVC5 getCurrentCell] objectForKey:@"liked_num"];
        NSLog(@"iueqiweiuiwuqe%@", [[DemoVC5 getCurrentCell] objectForKey:@"liked"]);
        NSString *num2=[[NSString alloc]initWithFormat:@"%@",convert];
        _numbers.text =num2;
        myIntstat = [convert intValue];
        if([[[DemoVC5 getCurrentCell] objectForKey:@"liked"] isEqualToString:@"True"])
        {
            [self.like_btn setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
        }else{
            [self.like_btn setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        }
        
        NSLog(@"hhhhhhhhhhh%@",[[DemoVC5 getCurrentCell] objectForKey:@"liked_num"]);
                    CircleGroup *circleGroup = [[CircleGroup alloc]initWithDict:[DemoVC5 getCurrentCell]];

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        NSString *plistName= [NSString stringWithFormat:@"id_%@_comment.plist",[[DemoVC5 getCurrentCell] objectForKey:@"feed_id"]];
        NSLog(@"circle Plsit of dynamic%@",plistName);
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:plistName];
        NSArray *commentArray = [NSArray arrayWithContentsOfFile:fileName];
        //NSDictionary *dict in commentArray;
        if (commentArray.count!=0)
        {[circleGroup initcomment:commentArray];}
        
            CircleGroupFrame *circleGroupFrame = [[CircleGroupFrame alloc]init];
            circleGroupFrame.circleGroup = circleGroup;
            
            [models addObject:circleGroupFrame];
//        }
        _circleGroupData = [models copy];
    }
    //NSLog(@"%lu",(unsigned long)[_statusFrames count]);
    return _circleGroupData;
}

-(void)replyAction:(UIButton *)sender
{
    CircleGroupCell *cell = (CircleGroupCell *)sender.superview.superview;
    
    self.replyViewDraw = [cell convertRect:cell.bounds toView:self.view.window].origin.y + cell.frame.size.height;
    
    NSIndexPath *indexPath = [self.circleTableView indexPathForCell:cell];
    CGRect rectInTableView = [self.circleTableView rectForRowAtIndexPath:indexPath];
    //NSLog(@"%f",rectInTableView.origin.y);
    CGRect replyButtonF = CGRectMake(sender.frame.origin.x , rectInTableView.origin.y+sender.frame.origin.y - 2, 80,25);
    CGRect likeButtonF =CGRectMake(sender.frame.origin.x-20, rectInTableView.origin.y+sender.frame.origin.y, 80, 25);
    NSLog(@"%f",self.replyButton.frame.origin.y);
    NSLog(@"%f",rectInTableView.origin.y+sender.frame.origin.y - 2);
    if (self.replyButton && self.replyButton.frame.origin.y != (rectInTableView.origin.y+sender.frame.origin.y - 2-padding)) {
        [self.replyButton removeFromSuperview];      //以防用户按了一个评论又按另一个
        //[self.likeButton removeFromSuperview];
        self.replyButton = nil;
    }
//    if(self.likeButton)
//    {
//        [self.likeButton removeFromSuperview];
//    }
    [self initReplyButton:replyButtonF like:likeButtonF];
    if (self.replyButton) {
        self.replyButton.tag = sender.tag;
        self.reply_btn.tag =sender.tag;
    }
}

-(void)initReplyButton:(CGRect)replyButtonF like:(CGRect)likeButtonF
{
    if (!self.replyButton) {
        UIButton *replyButton = [UIButton buttonWithType:0];
        replyButton.layer.cornerRadius = 5;
        replyButton.backgroundColor = [UIColor colorWithRed:33/255.0 green:37/255.0 blue:38/255.0 alpha:1.0];
        replyButton.frame = replyButtonF;
        [replyButton setTitleColor:[UIColor whiteColor] forState:0];
        replyButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        //[replyButton setImage:[UIImage  imageNamed:@"comment.png"]forState:UIControlStateNormal];
        [replyButton addTarget:self action:@selector(replyMessage:) forControlEvents:UIControlEventTouchUpInside];
        //[self.circleTableView addSubview:replyButton];
        self.replyButton = replyButton;
        
        [UIView animateWithDuration:0.25f animations:^{
            CGRect replyButtonDurF;
            replyButtonDurF.size.height = replyButtonF.size.height + 2*padding;
            replyButtonDurF.origin.y = replyButtonF.origin.y - padding+20;
            replyButtonDurF.origin.x = replyButtonF.origin.x - 60;
            replyButtonDurF.size.width = 60;
            replyButton.frame = replyButtonDurF;
        } completion:^(BOOL finished) {
            
        }];
            }
    else
    {
        [UIView animateWithDuration:0.25f animations:^{
            self.replyButton.frame = replyButtonF;    //只是为了有收缩的动画效果
           // self.likeButton.frame = replyButtonF;
        } completion:^(BOOL finished) {
            [self.replyButton removeFromSuperview];
            [self.likeButton removeFromSuperview];
            self.likeButton=nil;
            self.replyButton = nil;
        }];
        
    }
    if(!self.likeButton){
    UIButton *likeButton = [UIButton buttonWithType:0];
    likeButton.layer.cornerRadius = 5;
    likeButton.backgroundColor = [UIColor colorWithRed:33/255.0 green:37/255.0 blue:38/255.0 alpha:1.0];
    likeButton.frame = likeButtonF;
    [likeButton setTitleColor:[UIColor whiteColor] forState:0];
    likeButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    //[likeButton setImage:[UIImage  imageNamed:@"great.png"]forState:UIControlStateNormal];
    [likeButton addTarget:self action:@selector(likeButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
    //[self.circleTableView addSubview:likeButton];
    self.likeButton = likeButton;
    
    [UIView animateWithDuration:0.25f animations:^{
        CGRect likeButtonDurF;
        likeButtonDurF.size.height = likeButtonF.size.height + 2*padding;
        likeButtonDurF.origin.y = likeButtonF.origin.y - padding-2+20;
        likeButtonDurF.origin.x = likeButtonF.origin.x-90 ;
        likeButtonDurF.size.width = 60;
        likeButton.frame = likeButtonDurF;
    } completion:^(BOOL finished) {
           }];
    }else{
        [UIView animateWithDuration:0.25f animations:^{
                //只是为了有收缩的动画效果
            self.likeButton.frame = likeButtonF;
        } completion:^(BOOL finished) {
            [self.likeButton removeFromSuperview];
            self.likeButton=nil;
        }];
        
    }

}

-(void)likeButtonCliked:(UIButton*)sendr
{
    if(self.likeButton)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"真的要点赞吗？" message:@"你真的要为这条看起来很low的动态点赞吗?" delegate:self cancelButtonTitle:@"容你三思" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"要你管"];
        [alert show];
        [self.likeButton removeFromSuperview];
        [self.replyButton removeFromSuperview];
        self.replyButton=nil;
        self.likeButton=nil;
        
    }
}

-(void)replyMessage:(UIButton *)sender
{
    //[self.likeButton removeFromSuperview];
    if (self.replyButton) {
        [self initReplyInputView:sender.tag];
        [self.replyButton removeFromSuperview];
        [self.likeButton removeFromSuperview];
        self.replyButton = nil;
        self.likeButton =nil;
    }
}

-(void)initReplyInputView:(NSInteger) tag
{
    ReplyInputView *replyInputView = [[ReplyInputView alloc]initWithFrame:CGRectMake(0, self.view.bounds.origin.y + self.view.frame.size.height - 105, screenWidth, 54) andAboveView:self.view];
    
    self.flag = YES;
    //回调输入框的contentSize,改变工具栏的高度
    [replyInputView setContentSizeBlock:^(CGSize contentSize) {
        [self updateHeight:contentSize];
    }];
   // NSString *user=[[DemoVC5 getCurrentCell] objectForKey:@"name"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *plistName =[[NSString alloc] initWithFormat:@"User.plist"];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:plistName];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:fileName];
    NSString *user = [dict objectForKey:@"name"];
    NSString *name = [[NSString alloc]initWithFormat:@"%@ :",user ];
    [replyInputView setReplyAddBlock:^(NSString *replyText, NSInteger inputTag) {
            NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:[[DemoVC5 getCurrentCell] objectForKey:@"feed_id"],@"feed_id",replyText,@"content", nil];
        NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
        [Circle pubcommentWithParameters:postdic];
        replyText = [name stringByAppendingString:replyText];
        CircleGroupFrame *circleGroupFrameNeedChanged = self.circleGroupData[inputTag];
        CircleGroup *newCircleGroup = circleGroupFrameNeedChanged.circleGroup;
        //做个中转
        NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
        [mutaArray addObjectsFromArray:newCircleGroup.replys];
        [mutaArray addObject:replyText];
        newCircleGroup.replys = mutaArray;
        
        circleGroupFrameNeedChanged.replysF = nil;
        circleGroupFrameNeedChanged.picturesF = nil;
        circleGroupFrameNeedChanged.circleGroup = newCircleGroup;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:inputTag inSection:0];  //nsindexpath初始化方法
        [self.circleTableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];

    }];

    replyInputView.replyTag = tag;    //值为cell所在的行
    [self.view addSubview:replyInputView];
    self.replyInputView = replyInputView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircleGroupFrame *frame = self.circleGroupData[indexPath.row];
    return frame.cellHeight;
}

//更新replyView的高度约束
-(void)updateHeight:(CGSize)contentSize
{
    float height = contentSize.height + 20;
    CGRect frame = self.replyInputView.frame;
    frame.origin.y -= height - frame.size.height;  //高度往上拉伸
    frame.size.height = height;
    self.replyInputView.frame = frame;
}

//键盘出来的时候调整replyView的位置
-(void) keyChange:(NSNotification *) notify
{
    NSDictionary *dic = notify.userInfo;
    CGRect keyboardRect = [dic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    if (keyboardRect.size.height >250 && self.flag) {
        [UIView animateWithDuration:[dic[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            
            [UIView setAnimationCurve:[dic[UIKeyboardAnimationCurveUserInfoKey] doubleValue]];
            
            CGRect frame = self.replyInputView.frame;
            frame.origin.y = frame.origin.y - keyboardRect.size.height + 52;
            self.replyInputView.frame = frame;
            
            CGPoint point = self.circleTableView.contentOffset;
            
            point.y -= (frame.origin.y - self.replyViewDraw);
            self.circleTableView.contentOffset = point;
        }];
        self.flag = NO;

    }
}
- (IBAction)replyCliked:(id)sender {
    [self initReplyInputView:_reply_btn.tag];
    
}

-(void)showInfo:(UIButton *)sender
{
 
}

- (IBAction)back:(id)sender {
    NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:[[DemoVC5 getCurrentCell] objectForKey:@"ID"],@"topic_id",@"4",@"count",[[DemoVC5 getCurrentCell] objectForKey:@"page"],@"page",@"0",@"order", nil];
    NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [AFNetManager dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
    [Circle circeDynamicListWithParameters:postdic page:[[DemoVC5 getCurrentCell] objectForKey:@"page"] SuccessBlock:^(NSDictionary *dict, BOOL success) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

}



- (IBAction)likeButtonClik:(id)sender {
  
   
  
    [_like_btn setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
    //liked =@"Ture";
    
      NSNumber *temp = [[NSNumber alloc]initWithInt:myIntstat];
 
    
    NSString *Meth = [[NSString alloc]initWithFormat:@"POST"];
     if([[[DemoVC5 getCurrentCell] objectForKey:@"liked"] isEqualToString:@"True"])
    {
        Meth = @"DELETE";
        NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:Meth,@"method",[[DemoVC5 getCurrentCell] objectForKey:@"feed_id"],@"feed_id",[User getXrsf],@"_xsrf",nil];
        [Circle greatWithParameters:userInfo];
         [self.like_btn setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        myIntstat--;
        NSNumber *cn = [[NSNumber alloc]initWithInt:myIntstat];
        [DemoVC5 setCurrentCellLike:@"False"];
            NSString *num1=[[NSString alloc]initWithFormat:@"%@",cn];
         _numbers.text =num1;
    }else{
        NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:Meth,@"method",[[DemoVC5 getCurrentCell] objectForKey:@"feed_id"],@"feed_id",[User getXrsf],@"_xsrf",nil];
        [Circle greatWithParameters:userInfo];
        myIntstat++;
        NSNumber *cn = [[NSNumber alloc]initWithInt:myIntstat];
        [DemoVC5 setCurrentCellLike:@"True"];
         [self.like_btn setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
        NSString *num2=[[NSString alloc]initWithFormat:@"%@",cn];
        _numbers.text =num2;
    }
   
   
    
}
     
 - (NSString *)dictionaryToJson:(NSDictionary *)dic
 
{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
@end
