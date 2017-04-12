//
//  FindCircleViewController.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/27.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindCircleViewController : UIViewController
{
     BOOL flag; 
}
@property (weak, nonatomic) IBOutlet UIButton *factulButton;
@property (weak, nonatomic) IBOutlet UIImageView *enterpriseImage;
@property (weak, nonatomic) IBOutlet UIImageView *softwareImage;
@property (weak, nonatomic) IBOutlet UIButton *ClubButton;
@property (weak, nonatomic) IBOutlet UIButton *jobButton;
@property (weak, nonatomic) IBOutlet UIImageView *InternshipImage;
@property (weak, nonatomic) IBOutlet UIImageView *lawImage;
@property (weak, nonatomic) IBOutlet UIButton *fieldButton;
@property (weak, nonatomic) IBOutlet UIImageView *ecoManImage;
@property (weak, nonatomic) IBOutlet UIButton *hobbyButton;
@property (weak, nonatomic) IBOutlet UIImageView *electricImage;
@property (weak, nonatomic) IBOutlet UIButton *OccupationButton;

-(void)clickEffect :(UIButton *) BUTTON image:(UIImageView *) myimage;

@end
