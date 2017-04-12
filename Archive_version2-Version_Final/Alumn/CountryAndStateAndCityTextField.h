//
//  CountryAndStateAndCityTextField.h
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryAndStateAndCityTextField : UITextField
<UIPickerViewDataSource,UIPickerViewDelegate>{
    UIPickerView *pickView;
}

@property (nonatomic,strong)NSArray *countryArray;
@property (nonatomic,strong)NSArray *stateArray;
@property (nonatomic,strong)NSArray *cityArray;

- (void)setSelectRow:(NSInteger)index;


@end
