//
//  PeopleViewCell.m
//  PeopleListDemo
//
//  Created by 韩雪滢 on 8/27/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "PeopleViewCell.h"

@interface PeopleViewCell()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *majorLabel;
@property (strong, nonatomic) IBOutlet UILabel *classLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobClass;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userImg;

@end

@implementation PeopleViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString*)n{
    if(![n isEqualToString:_name]){
        _name=[n copy];
        self.nameLabel.text=_name;
    }
}
- (void)setMajor:(NSString*)n{
    if(![n isEqualToString:_major]){
        _major=[n copy];
        self.majorLabel.text=_major;
    }
}

- (void)setClassNum:(NSString*)n{
    if(![n isEqualToString:_classNum]){
        _classNum=[n copy];
        self.classLabel.text=_classNum;
    }
}

- (void)setJob:(NSString*)n{
    if(![n isEqualToString:_job]){
        _job=[n copy];
        self.jobClass.text=_job;
    }
}

- (void)setCity:(NSString*)n{
    if(![n isEqualToString:_city]){
        _city=[n copy];
        self.cityLabel.text=_city;
    }
}

- (void)setPeopleUrl:(NSString *)peopleUrl{
    _peopleUrl = [peopleUrl copy];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_peopleUrl]]];
    [self.userImg setImage:[self OriginImage:img scaleToSize:self.userImg.bounds.size]];
    self.userImg.layer.masksToBounds = YES;
    self.userImg.layer.cornerRadius = self.userImg.bounds.size.width / 2.0;
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
