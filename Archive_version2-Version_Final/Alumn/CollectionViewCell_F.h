//
//  CollectionViewCell.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/23.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CollectionViewCell_F : UICollectionViewCell

//cell中的图片；
@property(strong,nonatomic) UIImageView *imageView;
//cell中的描述文本；
@property(strong,nonatomic) UILabel *descLabel;
//cell右上角的删除按钮；
@property(nonatomic,strong)UIButton *deleteButton;

-(void)setDeleteButton;
@end


