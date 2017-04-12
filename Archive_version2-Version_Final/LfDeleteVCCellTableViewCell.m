//
//  LfDeleteVCCellTableViewCell.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/29.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//



#import "LfDeleteVCCellTableViewCell.h"

#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@implementation LfDeleteVCCellTableViewCell
{
    UIImageView *_view0;
    UILabel *_view1;
    UILabel *_view2;
    UIImageView *_view3;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIImageView *view0 = [UIImageView new];
    view0.backgroundColor = [UIColor redColor];
     _view0 = view0;
    
    UILabel *view1 = [UILabel new];
    view1.textColor = [UIColor lightGrayColor];
    view1.font = [UIFont systemFontOfSize:16];
    _view1 = view1;
    
    UILabel *view2 = [UILabel new];
    view2.textColor = [UIColor grayColor];
    view2.font = [UIFont systemFontOfSize:16];
    _view2 = view2;
    
    UIImageView *view3 = [UIImageView new];
    view3.backgroundColor = [UIColor orangeColor];
    _view3 = view3;
    
    
    [self.contentView addSubview:view0];
    [self.contentView addSubview:view1];
    [self.contentView addSubview:view2];
    [self.contentView addSubview:view3];

    
    
    
    _view0.sd_layout
    .widthIs(60)
    .heightIs(60)
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10);
    //使用使用CAShapeLayer和UIBezierPath设置圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_view0.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:_view0.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = _view0.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    _view0.layer.mask = maskLayer;
    
    _view1.sd_layout
    .topSpaceToView(self.contentView, 25)
    .leftSpaceToView(_view0, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightRatioToView(_view0, 0.4);
    
//    _view2.sd_layout
//    .topSpaceToView(_view1, 10)
//    .rightSpaceToView(self.contentView, 10)
//    .leftEqualToView(_view1)
//    .autoHeightRatio(0);
//    
//    _view3.sd_layout
//    .topSpaceToView(_view2, 10)
//    .leftEqualToView(_view2)
//    .widthRatioToView(_view2, 0.7);
    
    
}

- (void)setModel:(LfDeleteVCModel *)model
{
    _model = model;
    
    _view0.image = [UIImage imageNamed:model.iconName];
    _view1.text = model.name;
    //_view2.text = model.content;
    
    CGFloat bottomMargin = 0;
    
    
    // 在实际的开发中，网络图片的宽高应由图片服务器返回然后计算宽高比。
    
    UIImage *pic = [UIImage imageNamed:model.picName];
    if (pic.size.width > 0) {
        CGFloat scale = pic.size.height / pic.size.width;
        _view3.sd_layout.autoHeightRatio(scale);
        _view3.image = pic;
        bottomMargin = 10;
    } else {
        _view3.sd_layout.autoHeightRatio(0);
    }

  //  ***********************高度自适应cell设置步骤************************
    
    [self setupAutoHeightWithBottomView:_view0 bottomMargin:bottomMargin];
}

@end
