//
//  UIDragButton.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/28.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  代理按钮的点击事件
 */
@protocol UIDragButtonDelegate <NSObject>

- (void)dragButtonClicked:(UIButton *)sender;

@end

@interface UIDragButton : UIButton

/**
 *  悬浮窗所依赖的根视图
 */
@property (nonatomic, strong)UIView *rootView;

/**
 *  UIDragButton的点击事件代理
 */
@property (nonatomic, weak)id<UIDragButtonDelegate>btnDelegate;

@end
