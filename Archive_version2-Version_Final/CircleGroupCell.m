//
//  CircleGroupCell.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#import "CircleGroupCell.h"
#import "HeaderContent.h"
#import   "UIImageView+WebCache.h"
#define nameFont [UIFont systemFontOfSize:12]
#define textFont [UIFont systemFontOfSize:13]
#define timeFont [UIFont systemFontOfSize:10]
#define replyFont [UIFont systemFontOfSize:13]
@interface CircleGroupCell()
@property (weak,nonatomic)UIImageView *iconView;
@property (strong,nonatomic)NSMutableArray *picturesView;
@property (strong,nonatomic)NSMutableArray *replysView;
@property (weak,nonatomic)UILabel *nameLabel;
@property (weak,nonatomic)UILabel *timeLabel;
@property (weak,nonatomic)UILabel *shuoshuotextLabel;
@property (weak,nonatomic)UIImageView *replyBackgroundView;
@end
@implementation CircleGroupCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"CircleGroupCell";
    
    //缓存中取
    CircleGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //创建
    if (!cell)
    {
        cell = [[CircleGroupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //cell.userInteractionEnabled = NO;  //不让用户点击
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //让子定义cell和系统cell一样，一创建出来就有一些子控件给我们使用
        //创建头像
        self.selectionStyle = UITableViewCellSelectionStyleNone;   //cell选中时的颜色，无色
        
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        //创建昵称
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = nameFont;
        nameLabel.textColor = [UIColor colorWithRed:77/255.0 green:182/255.0 blue:172/255.0 alpha:1];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        

        //创建正文
        UILabel *shuoshuotextLabel = [[UILabel alloc]init];
        shuoshuotextLabel.font = textFont;
        shuoshuotextLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        shuoshuotextLabel.numberOfLines = 0;
        [self.contentView addSubview:shuoshuotextLabel];
        self.shuoshuotextLabel = shuoshuotextLabel;
        
        //创建配图要到后面，因为此时无法确定图片的张数
        /*if (!self.picturesView) {
         self.picturesView = [[NSMutableArray alloc]init];
         }
         for(int i = 0; i < 4; i++)   //图片个数这个时候没法确定
         {
         UIImageView *pictureView = [[UIImageView alloc]init];
         [self.contentView addSubview:pictureView];
         [self.picturesView addObject:pictureView];
         }*/
        
        //创建时间戳
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = timeFont;
        timeLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        //创建评论按钮
//        UIButton *replyButton = [UIButton buttonWithType:0];
//        [replyButton setImage:[UIImage imageNamed:@"reply"] forState:0];
//        [self.contentView addSubview:replyButton];
//        self.replyButton = replyButton;
        
        UIButton *likeButton = [UIButton buttonWithType:0];
        [likeButton setTitle:@"like" forState:0];
        [self.contentView addSubview:likeButton];
        self.likeButton = likeButton;
        
        //创建评论的背景
        UIImageView *replyBackgroundView = [[UIImageView alloc]init];
        replyBackgroundView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:0.0];
        [self.contentView addSubview:replyBackgroundView];
        self.replyBackgroundView = replyBackgroundView;
        
    }
    return self;
}

-(void)settingtData
{
    CircleGroup *circleGroup = self.circleGroupFrame.circleGroup;
    
    //创建头像
    [self.iconView  sd_setImageWithURL:[NSURL URLWithString:circleGroup.icon] placeholderImage:[UIImage imageNamed:@"10.jpg"]];
    
    //创建昵称
    self.nameLabel.text = circleGroup.name;
    
    //创建正文
    self.shuoshuotextLabel.text = circleGroup.shuoshuoText;
    
    //创建配图
    for (int i = 0; i < [circleGroup.pictures count]; i++) {
        // NSLog(@"%lu",(unsigned long)[friendGroup.pictures count]);
        //NSLog(@"%@",[friendGroup.pictures objectAtIndex:i]);
        //NSLog(@"%lu",(unsigned long)[self.picturesView count]);
        UIImageView *pictureView = [[UIImageView alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [pictureView addGestureRecognizer:tap];
        pictureView.tag = imageTag + i;
        //NSLog(@"%ld",(long)pictureView.tag);
        pictureView.userInteractionEnabled = YES;
        [self.contentView addSubview:pictureView];
        [self.picturesView addObject:pictureView];
//        ((UIImageView *)[self.picturesView objectAtIndex:i]).image = [UIImage imageNamed:[circleGroup.pictures objectAtIndex:i]];
         [((UIImageView *)[self.picturesView objectAtIndex:i]) sd_setImageWithURL:[NSURL URLWithString:[circleGroup.pictures objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"10.jpg"]];
    }


    
    
    //时间戳
    self.timeLabel.text = circleGroup.time;
    NSLog(@"PLLLLLLL%@",[circleGroup.replys objectAtIndex:0]);
    //创建评论
    for (int i = 0; i < [circleGroup.replys count]; i++) {
        UILabel *replyLabel = [[UILabel alloc]init];
        replyLabel.font = replyFont;
        replyLabel.numberOfLines = 0;
        
        NSString *searchText = [circleGroup.replys objectAtIndex:i];
        //NSString *searchText = @"浮夸：哈哈dasdksajdk";
        //把评论的姓名变色，用正则表达式
        NSRange range = [searchText rangeOfString:@"([\u4e00-\u9fa5]|[a-zA-Z0-9])+：" options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:searchText];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:104/255.0 green:109/255.0 blue:248/255.0 alpha:1.0] range:NSMakeRange(0, range.length - 1)];
            replyLabel.attributedText = str;
        }
        else
        {
            replyLabel.text = [circleGroup.replys objectAtIndex:i];
        }
        [self.contentView addSubview:replyLabel];
        [self.replysView addObject:replyLabel];
    }
    
}

-(NSMutableArray *)picturesView
{
    if (!_picturesView) {
        _picturesView = [[NSMutableArray alloc]init];
    }
    return _picturesView;
    
}

-(NSMutableArray *)replysView
{
    if (!_replysView) {
        _replysView = [[NSMutableArray alloc]init];
    }
    return _replysView;
}
-(void)settingFrame
{
    self.iconView.frame = self.circleGroupFrame.iconF;
    
    self.nameLabel.frame = self.circleGroupFrame.nameF;
    
    self.shuoshuotextLabel.frame = self.circleGroupFrame.shuoshuotextF;
    
    for (int i = 0; i < [self.circleGroupFrame.picturesF count]; i++) {
        ((UIImageView *)[self.picturesView objectAtIndex:i]).frame = [((NSValue *)[self.circleGroupFrame.picturesF objectAtIndex:i]) CGRectValue];
    }
    for (int i = 0; i < [self.circleGroupFrame.replysF count]; i++) {
        ((UILabel *)[self.replysView objectAtIndex:i]).frame = [(NSValue *)[self.circleGroupFrame.replysF objectAtIndex:i] CGRectValue];
    }
    self.timeLabel.frame = self.circleGroupFrame.timeF;
    
    self.replyButton.frame = self.circleGroupFrame.replyF;
    
    self.likeButton.frame = self.circleGroupFrame.likeF;
    
    self.replyBackgroundView.frame = self.circleGroupFrame.replyBackgroundF;
}

-(void)setCircleGroupFrame:(CircleGroupFrame *)circleGroupFrame
{
    _circleGroupFrame = circleGroupFrame;
    [self removeOldPicturesAndReplys];
    [self settingtData];
    [self settingFrame];
}

//防止cell重叠
-(void)removeOldPicturesAndReplys
{
    for(int i = 0;i < [self.picturesView count];i++)
    {
        UIImageView *pictureView = [self.picturesView objectAtIndex:i];
        if (pictureView.superview) {
            [pictureView removeFromSuperview];
        }
    }
    for (int i = 0; i < [self.replysView count]; i++) {
        UILabel *replyView = [self.replysView objectAtIndex:i];
        if (replyView.superview) {
            [replyView removeFromSuperview];
        }
    }
    [self.picturesView removeAllObjects];
    [self.replysView removeAllObjects];
}

-(void)tapImageView:(UITapGestureRecognizer *)tap
{
    
   self.imageBlock(self.circleGroupFrame.circleGroup.pictures,tap.view.tag);
}
@end


