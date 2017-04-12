//
//  TextSender.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "TextSender.h"

//static NSString *firstYear = nil;
//static NSString *secondYear = nil;
//static BOOL isFirstTextField = YES;

static NSInteger countryIndex = 0;
static NSInteger stateIndex = -1;
static NSInteger cityIndex = -1;

//----------------------------   设置faculty ， major
static NSString *facultyName = nil;
static BOOL isFaculty;



@implementation TextSender

+ (TextSender*)getSender{
    static TextSender *sender;
    static dispatch_once_t dec;
    
    dispatch_once(&dec,^{
        isFirstTextField = YES;
        isFaculty = nil;
        sender = [[TextSender alloc] init];
    });
    
    return sender;
}

- (void)setFirstYear:(NSString *)first{
    firstYear = first;
}

- (void)setSecondYear:(NSString *)second{
    secondYear = second;
}

- (NSString*)getFirstYear{
    NSString *tempFirst = firstYear;
    firstYear = nil;
    return tempFirst;
}

- (NSString*)getSecondYear{
    NSString *tempSecond = secondYear;
    secondYear = nil;
    return tempSecond;
}

- (NSString*)testFirstYear{
    return firstYear;
}

- (NSString*)testSecondYear{
    return secondYear;
}

- (BOOL)getCurrentText{
    if(isFirstTextField){
        NSLog(@"isFirstTextField");
    }else{
        NSLog(@"isSecondTextField");
    }
    return isFirstTextField;
}

- (void)setCurrentText:(BOOL)currentTextField{
    
    if(currentTextField){
        NSLog(@"currentTextField:YES");
    }else{
        NSLog(@"currentTextField:NO");
    }
    
    isFirstTextField = currentTextField;
    
    if(isFirstTextField){
        NSLog(@"isFirstTextField:YES");
    }else{
        NSLog(@"isFirstTextField:NO");
        NSLog(@"currentFirstYear  %@",self.testFirstYear);
    }
}

- (void)setPlaceTextFieldType:(NSString *)type{
    
    NSLog(@"setPlaceTextFieldType : %@",type);
    
    placeTextFieldType = type;
}

- (NSString*)getPlaceTextFieldType{
    
    NSLog(@"getPlaceTextFieldType : %@",placeTextFieldType);
    
    return placeTextFieldType;
}

- (void)setCountryIndex:(NSInteger)index{
    countryIndex = index;
    NSLog(@"setCountryIndex: %ld{long)",(long)countryIndex);
}

- (NSInteger)getCountryIndex{
    
    NSLog(@"getCountryIndex");
    
    NSLog(@"%ld,(long)",(long)countryIndex);
    
    return countryIndex;
}

- (void)setStateIndex:(NSInteger)index{
    stateIndex = index;
}

- (NSInteger)getStateIndex{
    
    NSLog(@"getStateIndex");
    
    NSLog(@"%ld,(long)",(long)countryIndex);
    
    NSLog(@"%ld,(long)",(long)stateIndex);
    
    return stateIndex;
}

- (void)setCityIndex:(NSInteger)index{
    cityIndex = index;
}

- (NSInteger)getCityIndex{
    
    NSLog(@"getCityIndex");
    
    NSLog(@"%ld,(long)",(long)countryIndex);
    
    NSLog(@"%ld,(long)",(long)stateIndex);
    
    NSLog(@"%ld,(long)",(long)cityIndex);
    
    NSInteger temp = countryIndex + stateIndex;
    
    return temp;
}

- (void)clear{
    
    countryIndex = 0;
    stateIndex = 0;
}


+ (void)SetIsFaculty:(BOOL)faculty{
    if(faculty){
        NSLog(@"getfaculty is YES");
    }else{
        NSLog(@"getfaculty is NO");
    }
    isFaculty = faculty;
    if(isFaculty){
        NSLog(@"isFaculty is YES");
    }else{
        NSLog(@"isFaculty is NO");
    }
    
}

+ (BOOL)getIsFaculty{
    if(isFaculty){
        NSLog(@"getIsF :YES");
    }else{
        NSLog(@"getIsF :NO");
    }
    return isFaculty;
}

+ (void)setFaculty:(NSString*)name{
    facultyName = name;
}

+ (NSString*)getFaculty{
    return facultyName;
}

@end

