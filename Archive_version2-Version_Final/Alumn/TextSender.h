//
//  TextSender.h
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *firstYear = nil;
static NSString *secondYear = nil;
static BOOL isFirstTextField = YES;

static NSString *placeTextFieldType = nil;

@interface TextSender : NSObject


+ (TextSender*)getSender;

//--------------------------------  about year
- (NSString*)getFirstYear;
- (NSString*)getSecondYear;
- (void)setFirstYear:(NSString*)first;
- (void)setSecondYear:(NSString*)second;
- (BOOL)getCurrentText;
- (void)setCurrentText:(BOOL)currentTextField;
- (NSString*)testFirstYear;
- (NSString*)testSecondYear;

//--------------------------------  about place

- (void)setPlaceTextFieldType:(NSString*)type;
- (NSString*)getPlaceTextFieldType;

- (void)setCountryIndex:(NSInteger)index;
- (NSInteger)getCountryIndex;
- (void)setStateIndex:(NSInteger)index;
- (NSInteger)getStateIndex;
- (void)setCityIndex:(NSInteger)index;
- (NSInteger)getCityIndex;

- (void)clear;

//--------------------------------  about major and faculty


+ (void)SetIsFaculty:(BOOL)faculty;
+ (BOOL)getIsFaculty;
+ (void)setFaculty:(NSString*)name;
+ (NSString*)getFaculty;



@end
