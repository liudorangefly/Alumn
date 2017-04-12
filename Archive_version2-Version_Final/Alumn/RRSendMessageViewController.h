//
//  RRSendMessageViewController.h
//  SendNewsDemo
//
//  Created by 韩雪滢 on 8/30/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRMessageModel.h"
#import "UICollectionViewCellPhoto.h"

@protocol RRSendMessageDelegate;

@interface RRSendMessageViewController : UIViewController
<UICollectionViewDelegate,UICollectionViewDataSource, UITextViewDelegate>

@property (nonatomic, assign) id<RRSendMessageDelegate> delegate;
@property (nonatomic, assign) NSInteger numberPhoto;

@property (nonatomic,strong) NSString *topic_ids;



- (void) presentController:(UIViewController *) parentController :(void (^)(RRMessageModel *model, BOOL isCancel))completion;

@end


//------------------------------------------  RRSendMessageDelegate 定义
@protocol RRSendMessageDelegate <NSObject>

@optional
- (void) messageCancel;
- (void) getMessage:(RRMessageModel *)message;

@end
