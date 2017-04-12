//
//  EnrollYearTextField.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "EnrollYearTextField.h"

@implementation EnrollYearTextField{
    UIToolbar *inputAccessoryView;
}
@synthesize yearArray;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

- (void)setSelectRow:(NSInteger)index{
    if(index >= 0){
        [pickView selectRow:index inComponent:0 animated:YES];
    }
}

- (void)drawRect:(CGRect)rect{
    pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 120)];
    pickView.dataSource = self;
    pickView.delegate = self;
    self.inputView = pickView;
}


#pragma mark - UIPickerView dataSource,delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [yearArray count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [yearArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.text = [yearArray objectAtIndex:row];
}

#pragma mark - inputAccessoryView with toolbar
- (BOOL)canBecomeFirstResponder{
    
    //设置数据
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for(int i = 1905;i < 2017;i++){
        [tempArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    yearArray = [[NSArray alloc] initWithArray:tempArray];
    
    
    
    
    return YES;
}

- (void)done:(id)sender{
    
    [self resignFirstResponder];
    [super resignFirstResponder];
}

- (UIView*)inputAccessoryView{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return nil;
    }else{
        if(!inputAccessoryView){
            inputAccessoryView = [[UIToolbar alloc] init];
            inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;
            inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [inputAccessoryView sizeToFit];
            CGRect frame = inputAccessoryView.frame;
            frame.size.height = 30.0f;
            inputAccessoryView.frame = frame;
            
            UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
            UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            NSArray *array = [NSArray arrayWithObjects:flexibleSpaceLeft,doneBtn,nil];
            [inputAccessoryView setItems:array];
        }
        return inputAccessoryView;
    }
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
