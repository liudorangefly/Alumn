//
//  UserFactory.m
//  ChatListDemo
//
//  Created by 韩雪滢 on 10/2/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "UserFactory.h"

@interface CDUser : NSObject <CDUserModelDelegate>

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *avatarUrl;

@end

@implementation CDUser

@end

@implementation UserFactory

#pragma mark - UserDelegate


- (void)cacheUserByIds:(NSSet *)userIds block:    (AVBooleanResultBlock)block {
    block(YES, nil);
}

- (id <CDUserModelDelegate> )getUserById:(NSString *)userId {
    CDUser *user = [[CDUser alloc] init];
    user.userId = userId;
    //在cell中显示的聊天对象的名字
    user.username = userId;
    //聊天对象的头像
    user.avatarUrl = @"";
    return user;
}


@end
