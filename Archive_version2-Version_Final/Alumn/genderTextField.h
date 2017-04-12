//
//  genderTextField.h
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface genderTextField : UITextField
<UIPickerViewDataSource,UIPickerViewDelegate>{
    UIPickerView *pickView;
}

@property (nonatomic,strong) NSArray *genderArray;

- (void)setSelectRow:(NSInteger)index;



@end
