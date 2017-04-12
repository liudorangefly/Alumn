//
//  EnrollYearTextField.h
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnrollYearTextField : UITextField
<UIPickerViewDataSource,UIPickerViewDelegate>{
    UIPickerView *pickView;
}

@property (nonatomic,strong) NSArray *yearArray;

- (void)setSelectRow:(NSInteger)index;


@end
