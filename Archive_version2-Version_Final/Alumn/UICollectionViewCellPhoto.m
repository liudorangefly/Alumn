//
//  UICollectionViewCellPhoto.m
//  SendNewsDemo
//
//  Created by 韩雪滢 on 8/30/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "UICollectionViewCellPhoto.h"

@implementation UICollectionViewCellPhoto

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.photo = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.photo];
    return (self);
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.photo.image = nil;
    self.photo.frame = self.contentView.bounds;
}


@end
