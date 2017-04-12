//
//  genderTextField.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "genderTextField.h"

@implementation genderTextField{
    UIToolbar *inputAccessoryView;
}
@synthesize genderArray;
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
    return [genderArray count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if([[genderArray objectAtIndex:row] isEqualToString:@"0"]){
        return @"女";
    }else{
        return @"男";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if([[genderArray objectAtIndex:row] isEqualToString:[NSString stringWithFormat:@"%d",0]]){
        self.text = @"女";
    }else{
        self.text = @"男";
    }
}


#pragma mark - inputAccessoryView with toolbar
- (BOOL)canBecomeFirstResponder{
    
    genderArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",0],[NSString stringWithFormat:@"%d",1], nil];
    
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
