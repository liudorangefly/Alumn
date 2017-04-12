//
//  createaCircleStep1VC.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/8.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface createaCircleStep1VC : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *selectphoto;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UITextField *circleName;
@property (weak, nonatomic) IBOutlet UITextField *circleNameField;

@end

