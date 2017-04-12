//
//  createCircleStep2.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/8.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *reason;
static NSString *intro;
static NSString *creator_name;
@interface createCircleStep2 : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate>
{
    
    NSArray *_typeArray;
}

@property (weak ,nonatomic) UIImage *image;
@property (weak,nonatomic) NSString *circleName;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reasonlabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UITextView *reasaonTextView;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UITextView *introTextView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *finishItem;
@property (weak,nonatomic) NSString *uid;
@property (weak ,nonatomic) NSString *ID;
@property (weak ,nonatomic) NSArray *TYPE_id;

@property (weak , nonatomic) NSString *typeName;
@end
