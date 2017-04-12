//
//  YearpickerTextField.h
//  HighLevelSearchDemo
//
//  Created by 韩雪滢 on 9/2/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldSender.h"


@interface YearpickerTextField : UITextField
<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>{
    UIPickerView *pickView;
}

@property (nonatomic,strong) NSArray *yearArray;

@property (nonatomic,strong) TextFieldSender *sender;

- (void)setSelectRow:(NSInteger)index;

@end
