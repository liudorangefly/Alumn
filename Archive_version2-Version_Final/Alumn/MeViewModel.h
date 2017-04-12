//
//  MeViewModel.h
//  netdemo1
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 Dorangefly Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeViewModel : NSObject

- (void)getMyAdminCircleList:(NSDictionary *)Data;
- (void)getMyCreateCircleList:(NSDictionary *)Data;
- (void)getMyCardsList:(NSDictionary*)Data;

+ (NSArray*)adminCircleFromPlist;
+ (NSArray*)createCircleFromPlist;
+ (NSArray*)collectCardsFromPlist;

@end
