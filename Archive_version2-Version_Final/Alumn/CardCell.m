//
//  CardCell.m
//  scrollViewDamo
//
//  Created by 韩雪滢 on 8/25/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import "CardCell.h"
#import "View+MASAdditions.h"
#import   "UIImageView+WebCache.h"

@interface CardCell()

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *majorLabel;
@property (strong, nonatomic) IBOutlet UILabel *classLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobLabel;



@end

@implementation CardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setName:(NSString *)name{
    if(![_name isEqualToString:name]){
        _name= [name substringFromIndex:11];
        _nameLabel.text = _name;
    }
}

- (void)setJob:(NSString *)job{
    if(![_job isEqualToString:job]){
        _job = [job copy];
        _jobLabel.text = _job;
    }
}

- (void)setMajor:(NSString *)major{
    if(![_major isEqualToString:major]){
        _major = [major copy];
        _majorLabel.text = _major;
    }
}

- (void)setClassNum:(NSString *)classNum{
    if(![_classNum isEqualToString:classNum]){
        _classNum = [classNum copy];
        _classLabel.text = _classNum;
    }
}

- (void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    
    NSLog(@"我收藏的卡片的头像URL: %@",imgUrl);
    
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgUrl]]];
    [self.imgView setImage:[self OriginImage:img scaleToSize:self.imgView.bounds.size]];
  //  [self.imgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl]];
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = self.imgView.bounds.size.width / 2.0;
    
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
