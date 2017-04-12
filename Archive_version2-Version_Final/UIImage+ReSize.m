//
//  UIImage+ReSize.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#import "UIImage+ReSize.h"

@implementation UIImage (ReSize)
-(UIImage *)reSizeImagetoSize:(CGSize)reSize   
{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(reSize.width, reSize.height),NO,0.0);
    
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return reSizeImage;
    

}
@end
