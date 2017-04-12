//
//  YearpickerTextField.m
//  HighLevelSearchDemo
//
//  Created by 韩雪滢 on 9/2/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "YearpickerTextField.h"

@implementation YearpickerTextField{
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
    self.sender = [TextFieldSender getSender];
    

    int startYear = 1952;
    int endYear = 2016;
    
    if(self.tag == 31)
    {
        NSLog(@"Now is the firstSecondTextField");
        
        // 当前是第一个yearTextfield，判断是否已经选择了第二个范围参数
        if([self.sender testSecondYear] != nil){
            endYear = [[self.sender getSecondYear] intValue];
        }
    }else if(self.tag == 32){
        // 当前是第二个yearTextfield，判断是否已经选择了第一个参数
        if(![self.sender getCurrentText]){
            NSLog (@"%@",@"YTfield :NO");
            NSLog(@"secondYearTextField");
        }
        
        NSLog(@"Now is the secondTextField");
        
        if([self.sender testFirstYear] != nil){
            startYear = [[self.sender getFirstYear] intValue];
            NSLog(@"startYear %d",startYear);
        }
    }
    for(int i = startYear;i < endYear;i++){
        [tempArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    yearArray = [[NSArray alloc] initWithArray:tempArray];
    
    return YES;
}

- (void)done:(id)sender{
    if([self.sender getCurrentText]){
        [self.sender setFirstYear:self.text];
        [self.sender setCurrentText:NO];
        
        NSLog(@"done: %@",[self.sender testFirstYear]);
        
    }else{
        [self.sender setSecondYear:self.text];
        [self.sender setCurrentText:YES];
        
        NSLog(@"%@",[self.sender testSecondYear]);
    }

    
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

@end
