////
////  firstStep.m
////  netdemo1
////
////  Created by Dorangefly Liu on 16/9/5.
////  Copyright © 2016年 Dorangefly Liu. All rights reserved.
////
//
//#import "firstStep.h"
//#import "User.h"
//#import "User+Extension.h"
//#import "Circle.h"
//#import "Circle+Extension.h"
//
//@interface firstStep ()
//
//@end
//
//@implementation firstStep
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//   
//    
//    [User loginWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
//        NSLog(@"log in");
//    } AFNErrorBlock:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//   
//    
//    
//
//    
//}
////- (IBAction)click:(id)sender {
////    [Circle getMainPageCircleWithParameters:nil];
////
////}
//
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//- (NSString *)dictionaryToJson:(NSDictionary *)dic
//
//{
//    
//    NSError *parseError = nil;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
//    
//    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//}
//
//- (void)callActionSheetFunc{
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
//    }else{
//        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
//    }
//    
//    self.actionSheet.tag = 1000;
//    [self.actionSheet showInView:self.view];
//}
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (actionSheet.tag == 1000) {
//        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        // 判断是否支持相机
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            switch (buttonIndex) {
//                case 0:
//                    //来源:相机
//                    sourceType = UIImagePickerControllerSourceTypeCamera;
//                    break;
//                case 1:
//                    //来源:相册
//                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                    break;
//                case 2:
//                    return;
//            }
//        }
//        else {
//            if (buttonIndex == 2) {
//                return;
//            } else {
//                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//            }
//        }
//        // 跳转到相机或相册页面
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//        imagePickerController.delegate = self;
//        imagePickerController.allowsEditing = YES;
//        imagePickerController.sourceType = sourceType;
//        
//        [self presentViewController:imagePickerController animated:YES completion:^{
//            
//        }];
//    }
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    self.mainImage.image = image;
//}
//- (IBAction)selectPhotoClicked:(id)sender {
//    
//    [self callActionSheetFunc];
//   
////}
////- (IBAction)uploadclick:(id)sender {
////     [Circle uploadPicture:self.mainImage.image];
////}
////- (IBAction)circleDeayil:(id)sender {
////    NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:@"57c69cbab9a9965edeffa3e7",@"topic_id", nil];
////    NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
////    NSLog (@"%@",postdic);
////    
////    [Circle circleDeatilsWithParameters:postdic];
////}
//
//
//
//
//
//@end
