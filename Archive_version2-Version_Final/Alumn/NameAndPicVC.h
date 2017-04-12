//
//  NameAndPicVC.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/1.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameAndPicVC : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *selectphoto;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UITextField *circleName;

@end
