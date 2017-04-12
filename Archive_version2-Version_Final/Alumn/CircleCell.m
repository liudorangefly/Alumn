//
//  CircleCell.m
//  scrollViewDamo
//
//  Created by 韩雪滢 on 8/26/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import "CircleCell.h"
#import "View+MASAdditions.h"
#import   "UIImageView+WebCache.h"


@interface CircleCell()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CircleCell

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
        _name = [name copy];
        _nameLabel.text = _name;
    }
}

- (void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgUrl]]];
    [self.imgView setImage:[self OriginImage:img scaleToSize:self.imgView.bounds.size]];
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

