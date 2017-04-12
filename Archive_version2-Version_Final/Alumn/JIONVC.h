//
//  JIONVC.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/11.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *reasonContent;
@interface JIONVC :UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *resonlablel;
@property (weak, nonatomic) IBOutlet UITextView *reasoncontent;
@property (weak, nonatomic) IBOutlet UIButton *close;
@property (weak, nonatomic) IBOutlet UIButton *finish;



@end
