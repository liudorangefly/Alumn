//
//  CommentTableViewCell.m
//  scrollViewDamo
//
//  Created by 刘畅 on 9/11/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import "CommentTableViewCell.h"
#import   "UIImageView+WebCache.h"
@interface CommentTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *commentImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;

@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)name{
    NSString *cut =[name copy];
    _name= [cut substringFromIndex:11];
    _nameLabel.text = _name;
    
}
- (void)setComment:(NSString *)comment{
    _comment = [comment copy];
    _commentLabel.text = _comment;
}
- (void)setUpdateTime:(NSString *)updateTime{
    _updateTime = [updateTime copy];
    _updateLabel.text = _updateTime;
}

- (void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = [imgUrl copy];
  //  UIImage *circleImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgUrl]]];
    [self.commentImg sd_setImageWithURL:[NSURL URLWithString:_imgUrl]];
//    [self.commentImg setImage:[self OriginImage:circleImg scaleToSize:self.commentImg.bounds.size]];
    self.commentImg.layer.masksToBounds = YES;
    self.commentImg.layer.cornerRadius = self.commentImg.bounds.size.width / 2.0;
}

//改变图片的大小适应image View的大小
-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
