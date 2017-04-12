//
//  FacultyAndMajorText.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "FacultyAndMajorText.h"
#import "TextSender.h"

static BOOL majorTurn;
static NSString *currentType;

@interface FacultyAndMajorText()

@property (nonatomic,strong) TextSender *sender;


@end

@implementation FacultyAndMajorText
{
}

@synthesize dataArray;

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
        [self.pickView selectRow:index inComponent:0 animated:YES];
    }
}
- (void)drawRect:(CGRect)rect{
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 120)];
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    self.inputView = self.pickView;
    self.text = @"";
    
    //    //----------------------------------------设置数据
    //    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"majorList" ofType:@"plist"];
    //    NSDictionary *facultiesAndMajors = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //    NSMutableArray *facultyArray = [[NSMutableArray alloc] init];
    //
    //    if([TextSender getIsFaculty]){
    //
    //        NSLog(@"现在是facultyTextfield");
    //
    //        for(NSString *key in facultiesAndMajors.allKeys){
    //            [facultyArray addObject:key];
    //        }
    //
    //        self.dataArray = [NSArray arrayWithArray:facultyArray];
    //    }else{
    //
    //        NSLog(@"现在是majorTextfield");
    //        if(![TextSender getIsFaculty]){
    //            NSLog(@"NO");
    //        }else{
    //            NSLog(@"YES");
    //        }
    //
    //
    //        if([TextSender getFaculty] == nil){
    //            self.dataArray = nil;
    //        }else{
    //            self.dataArray = [NSArray arrayWithArray:[facultiesAndMajors valueForKey:[TextSender getFaculty]]];
    //        }
    //    }
    
}

#pragma mark - UIPickerView dataSource,delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return dataArray.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.text = dataArray[row];
    if([TextSender getIsFaculty]){
        [TextSender setFaculty:dataArray[row]];
        //  [TextSender SetIsFaculty:NO];
    }
    //    }else{
    //        [TextSender SetIsFaculty:YES];
    //    }
    
}

#pragma mark - inputAccessoryView with toolbar
- (BOOL)canBecomeFirstResponder{
    //----------------------------------------设置数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"majorList" ofType:@"plist"];
    NSDictionary *facultiesAndMajors = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSMutableArray *facultyArray = [[NSMutableArray alloc] init];
    
    if([TextSender getIsFaculty]){
        
        NSLog(@"现在是facultyTextfield");
        
        for(NSString *key in facultiesAndMajors.allKeys){
            [facultyArray addObject:key];
        }
        
        self.dataArray = [NSArray arrayWithArray:facultyArray];
    }else{
        
        NSLog(@"现在是majorTextfield");
        if(![TextSender getIsFaculty]){
            NSLog(@"NO");
        }else{
            NSLog(@"YES");
        }
        
        
        if([TextSender getFaculty] == nil){
            self.dataArray = nil;
        }else{
            self.dataArray = [NSArray arrayWithArray:[facultiesAndMajors valueForKey:[TextSender getFaculty]]];
        }
    }
    
    
    return YES;
}

- (void)done:(id)sender{
    if([TextSender getIsFaculty]){
        [TextSender SetIsFaculty:NO];
    }else{
        [TextSender SetIsFaculty:YES];
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
