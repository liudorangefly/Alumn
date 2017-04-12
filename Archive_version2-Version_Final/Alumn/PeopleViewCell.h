//
//  PeopleViewCell.h
//  PeopleListDemo
//
//  Created by 韩雪滢 on 8/27/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleViewCell : UITableViewCell

@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *major;
@property (copy,nonatomic) NSString *classNum;
@property (copy,nonatomic) NSString *city;
@property (copy,nonatomic) NSString *job;
@property (nonatomic,strong) NSString *peopleUrl;


@end
