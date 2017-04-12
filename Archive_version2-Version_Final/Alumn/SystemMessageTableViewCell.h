//
//  SystemMessageTableViewCell.h
//  scrollViewDamo
//
//  Created by 刘畅 on 9/11/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemMessageTableViewCell : UITableViewCell

@property (nonatomic,strong) NSString *messageName;
@property (nonatomic,strong) NSString *messageContent;
@property (nonatomic,strong) NSString *updateTime;
@property (nonatomic,strong) NSString *circleURL;

@end
