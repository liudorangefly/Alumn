//
//  JIONVC.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/11.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "JIONVC.h"

@interface JIONVC ()

@end

@implementation JIONVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.userInteractionEnabled=true;
    //self.resonlablel.text = @"在此处填写您加入该圈子的理由";
    self.resonlablel.enabled =NO;
    self.reasoncontent.delegate=self;
    NSLog(@"1..%f %f %f %f",self.close.frame.origin.x,self.close.frame.origin.y,self.close.frame.size.width,self.close.frame.size.height);
    
    NSLog(@"2..%f %f %f %f",self.finish.frame.origin.x,self.finish.frame.origin.y,self.finish.frame.size.width,self.finish.frame.size.height);
   
    NSLog(@"3..%f %f %f %f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    
    
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)textViewDidChange:(UITextView *)textView {
    
self.resonlablel.hidden = textView.hasText;
    reasonContent=self.reasoncontent.text;
}

- (IBAction)close:(id)sender {
    NSLog(@"keyboard");
   [self.reasoncontent resignFirstResponder];
}
- (IBAction)finish:(id)sender {
     NSLog(@"单机");
}



@end
