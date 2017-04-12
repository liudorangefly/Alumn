//
//  PeopleVM.h
//  PeopleListDemo
//
//  Created by 韩雪滢 on 8/28/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleVM : NSObject

- (NSArray*)getPeople;
- (NSArray*)reGetPeople;
- (NSArray*)matchPeople:(NSArray*)choose;
- (NSArray*)searchPeople:(NSString*)message;

@end
