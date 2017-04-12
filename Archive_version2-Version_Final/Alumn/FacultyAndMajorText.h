//
//  FacultyAndMajorText.h
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacultyAndMajorText : UITextField
<UIPickerViewDataSource,UIPickerViewDelegate>{
    
    UIToolbar *inputAccessoryView;
    
}


//@property (nonatomic,strong) NSMutableArray *facultyArray;
//@property (nonatomic,strong) NSDictionary *facultiesAndMajors;
@property (nonatomic,strong) UIPickerView *pickView;
@property (nonatomic,strong) NSArray *dataArray;


- (void)setSelectRow:(NSInteger)index;
- (void)setCurrentType:(NSString*)type;


@end
