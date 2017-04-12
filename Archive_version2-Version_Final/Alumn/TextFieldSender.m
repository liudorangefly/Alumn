//
//  TextFieldSender.m
//  HighLevelSearchDemo
//
//  Created by 韩雪滢 on 9/2/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "TextFieldSender.h"

//static NSString *firstYear = nil;
//static NSString *secondYear = nil;
//static BOOL isFirstTextField = YES;

static NSInteger countryIndex = 0;
static NSInteger stateIndex = -1;
static NSInteger cityIndex = -1;

@implementation TextFieldSender

+ (TextFieldSender*)getSender{
    static TextFieldSender *sender;
    static dispatch_once_t dec;
   
    dispatch_once(&dec,^{
        isFirstTextField = YES;
        sender = [[TextFieldSender alloc] init];
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
    placeTextFieldType = type;
}

- (NSString*)getPlaceTextFieldType{
    
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

- (void)setIsHighSearch:(BOOL)highSearch{
    isHighSearch = highSearch;
}

- (BOOL)getIsHighSearch{
    
    return isHighSearch;
}

@end
