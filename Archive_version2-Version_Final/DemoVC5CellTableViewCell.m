//
//  DemoVC5CellTableViewCell.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/28.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//



#import "DemoVC5CellTableViewCell.h"

#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import   "UIImageView+WebCache.h"

@implementation DemoVC5CellTableViewCell
{
    UIImageView *_view0;
    UILabel *_view1;
    UILabel *_time;
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
    
    UILabel *time = [UILabel new];
    time.textColor = [UIColor lightGrayColor];
    time.font = [UIFont systemFontOfSize:12];
    _time = time;
    
    UILabel *view2 = [UILabel new];
    view2.textColor = [UIColor grayColor];
    view2.font = [UIFont systemFontOfSize:16];
    _view2 = view2;
    
    UIImageView *view3 = [UIImageView new];
    view3.backgroundColor = [UIColor orangeColor];
    _view3 = view3;
    
    
    [self.contentView addSubview:view0];
    [self.contentView addSubview:view1];
    [self.contentView addSubview:time];
    [self.contentView addSubview:view3];
    [self.contentView addSubview:view2];
   

    
    
    
    _view0.sd_layout
    .widthIs(40)
    .heightIs(40)
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10);
    
    _view1.sd_layout
    .topEqualToView(_view0)
    .leftSpaceToView(_view0, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightRatioToView(_view0, 0.4);
    
    _time.sd_layout
    .topSpaceToView(_view1,2)
    .leftSpaceToView(_view0,5)
    .rightSpaceToView(self.contentView,10);
    
    _view2.sd_layout
    .topSpaceToView(_time, 10)
    .rightSpaceToView(self.contentView, 10)
    .leftEqualToView(_view1)
    .autoHeightRatio(0);
    
    _view3.sd_layout
    .topSpaceToView(_view2, 10)
    .leftEqualToView(_view2)
    .widthRatioToView(self.contentView, 0.8)
    .bottomSpaceToView(self,10);
    
    
}

- (void)setModel:(DemoVC5Model *)model
{
    _model = model;
    
    //_view0.image = [UIImage imageNamed:[model.image_urls objectForKey:@"item"]];
    _view1.text = model.name;
    _view2.text = model.content;
    _time.text= model.create_time;
    [_view0 sd_setImageWithURL:[NSURL URLWithString:self.model.icon_url ]];
    
   static CGFloat bottomMargin = 0;
    
    
    // 在实际的开发中，网络图片的宽高应由图片服务器返回然后计算宽高比。
    
    UIImageView *pic = [[UIImageView alloc]init];
    if(self.model.image_urls.count>0)
    {
//    [pic  sd_setImageWithURL:[NSURL URLWithString:[self.model.image_urls objectAtIndex:0]]];
//    NSLog(@"pictureurl%@",[self.model.image_urls objectAtIndex:1]);
    [pic sd_setImageWithURL:[self.model.image_urls objectAtIndex:0] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (pic.image.size.width > 0) {
            
            CGFloat scale = pic.image.size.height / pic.image.size.width;
            NSLog(@"pic de chang %f das%f scale %f",pic.image.size.height,pic.image.size.width,scale);
            _view3.sd_layout.autoHeightRatio(scale);
            //_view3.image=pic.image;
            bottomMargin = 40;
            [_view3 sd_setImageWithURL:[NSURL URLWithString:[self.model.image_urls objectAtIndex:0]]];
        } else {
            _view3.sd_layout.autoHeightRatio(0);
        }
 
    }];
    }

//    }else{
//        _view3.sd_layout.autoHeightRatio(0);
//    }

    //***********************高度自适应cell设置步骤************************
    
    [self setupAutoHeightWithBottomView:_view3 bottomMargin:bottomMargin];
}

@end
