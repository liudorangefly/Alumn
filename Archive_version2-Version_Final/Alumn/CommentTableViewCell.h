//
//  CommentTableViewCell.h
//  scrollViewDamo
//
//  Created by 刘畅 on 9/11/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *comment;
@property (nonatomic,strong)NSString *updateTime;
@property (nonatomic,strong)NSString *imgUrl;

@end
