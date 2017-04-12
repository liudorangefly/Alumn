//
//  RegisterFiveVC.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 8/29/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "RegisterFiveVC.h"
//#import "ReactiveCocoa/ReactiveCocoa.h"
#import "RegisterViewModel.h"
#import "Circle.h"
#import "Circle+Extension.h"

#import "User+Extension.h"
#import "User.h"

@interface RegisterFiveVC()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pickImgView;
@property (weak, nonatomic) IBOutlet UIButton *pickPhoto;

//--------------------------  获取头像
//@property (nonatomic,strong) UIActionSheet *actionSheet;

@property (strong,nonatomic) RegisterViewModel *registerVM;

@property (strong,nonatomic) User *user;

@end

@implementation  RegisterFiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [User getUser];
    
    self.registerVM = [RegisterViewModel getRegisterVM];
    
    //---------------------------------------------   设置navigationBar透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    //----------------------------------------------  设置navigationBar透明
    
    
    // self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    self.finishBtn.layer.masksToBounds = YES;
    self.finishBtn.layer.cornerRadius = 6.0;
    
    _pickImgView.image = [self OriginImage:[UIImage imageNamed:@"register_picking"] scaleToSize:_pickImgView.bounds.size];
    self.pickImgView.layer.masksToBounds = YES;
    self.pickImgView.layer.cornerRadius = self.pickImgView.bounds.size.width / 2.0;
    self.pickImgView.image = [self OriginImage:[UIImage imageNamed:@"Image"] scaleToSize:self.pickImgView.bounds.size];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:[UIImage imageNamed:@"bgImage"] scaleToSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)]];
    
    [self.pickPhoto setImage:[UIImage imageNamed:@"takePhoto"] forState:UIControlStateNormal];
    
    [self.pickPhoto addTarget:self action:@selector(callActionSheetFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
//    [self bindVM];
}

-(void)bindVM{
    //    self.registerVM.user.icon_url = @"icon_url here";
    //    RAC(self.finishBtn,enabled) = self.registerVM.registerFiveEnableSiganl;
    //
    //    [[self.finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    //        [self.registerVM.registerCommand execute:nil];
    //    }];
    //
    //    [self.registerVM.registerCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
    //        if([result isEqualToString:@"success"]){
    //            NSLog(@"register finish");
    //            NSDictionary *userDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.registerVM.user.password,@"password",self.registerVM.user.telephone,@"telephone", nil];
    //
    //            [User loginWithParameters:userDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
    //
    //                NSLog(@"注册后自动登录成功");
    //
    //                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //                UIViewController *VC = [sb instantiateViewControllerWithIdentifier:@"FiveTab"];
    //                [self.navigationController pushViewController:VC animated:YES];
    //
    //            } AFNErrorBlock:^(NSError *error) {
    //
    //                NSLog(@"注册后自动登录失败");
    //
    //            }];
    //
    //        }else{
    //            NSLog(@"register failed");
    //        }
    //    }];
}

-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (void)callActionSheetFunc:(id)sender{
    //------------------------------------  UIAlertControllerSheet
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        self.clipperType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self pickPhoto:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"📷" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        self.clipperType = UIImagePickerControllerSourceTypeCamera;
        [self pickPhoto:UIImagePickerControllerSourceTypeCamera];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)pickPhoto:(UIImagePickerControllerSourceType)type{
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    
    //------------------------  确定照片的来源是相册／拍照
    imgPicker.sourceType = type;
    
    imgPicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imgPicker.allowsEditing = YES;
    [self presentViewController:imgPicker animated:YES completion:nil];
    
}

//-------------------------------  实现ImagePickerController的代理方法

#pragma mark - UIImagePickerControllerdelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //系统方式裁剪
    NSString *imgKey = UIImagePickerControllerEditedImage;
    UIImage *image = [info objectForKey:imgKey];
    
    //--------------------------------------  自动保存裁剪完的相片到自定义相册
//    [self saveInSelfAlbum:image];
    
    self.user.userHeadImg = image;
    self.pickImgView.image = [self OriginImage:[info objectForKey:imgKey] scaleToSize:self.pickImgView.bounds.size];
    
    // －－－－－－－－－－－－－－－－－－－－－－ 显示完自动退出
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}


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
//    self.pickImgView.image = image;
//    self.pickImgView.layer.masksToBounds = YES;
//    self.pickImgView.layer.cornerRadius = self.pickImgView.bounds.size.width / 2.0;
//    
//    self.registerVM.user.userHeadImg = image;
//}
//- (IBAction)selectPhotoClicked:(id)sender {
//    
//    NSLog(@"--------------------------------Click selectPhotos");
//    
//    [self callActionSheetFunc];
//}

- (IBAction)finishRegist:(id)sender {
    
    [User upLoadUserImg:self.user.userHeadImg method:@"upload_normal_img" SuccessBlock:^(NSDictionary *dict, BOOL success) {
        NSLog(@"上传头像成功%@",dict);
        NSMutableDictionary *registerdic = [[NSMutableDictionary alloc] init];
        [registerdic setObject:[self.user valueForKey:@"city"] forKey:@"city"];
        [registerdic setObject:[self.user valueForKey:@"state"] forKey:@"state"];
        [registerdic setObject:[self.user valueForKey:@"country"] forKey:@"country"];
        [registerdic setObject:[self.user valueForKey:@"faculty"] forKey:@"faculty"];
        [registerdic setObject:[self.user valueForKey:@"name"] forKey:@"name"];
        [registerdic setObject:[self.user valueForKey:@"major"] forKey:@"major"];
        [registerdic setObject:[self.user valueForKey:@"company"] forKey:@"company"];
        [registerdic setObject:[self.user valueForKey:@"admission_year"] forKey:@"admission_year"];
        [registerdic setObject:[self.user valueForKey:@"telephone"] forKey:@"telephone"];
        [registerdic setObject:[self.user valueForKey:@"job"] forKey:@"job"];
        [registerdic setObject:[self.user valueForKey:@"gender"] forKey:@"gender"];
        [registerdic setObject:[self.user valueForKey:@"password"] forKey:@"password"];
        [registerdic setObject:[dict valueForKey:@"img_key"] forKey:@"icon_url"];
        
        NSLog(@"用户注册详细信息：%@",registerdic);
        
        [User registerWithParameters:registerdic SuccessBlock:^(NSDictionary *dict, BOOL success) {
            if([[dict valueForKey:@"code"] integerValue] == 2700)
            {
                NSLog(@"跳转到登录界面");
                //                [subscriber sendNext:@"success"];
                //                [subscriber sendCompleted];
                
                NSLog(@"register finish");
                NSDictionary *userDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.user.password,@"password",self.user.telephone,@"telephone", nil];
                
                NSLog(@"注册成功，自动登录信息检查：\n%@",userDic);
                
                [User loginWithParameters:userDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
                    
                    NSLog(@"注册后自动登录成功");
                    
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    UIViewController *VC = [sb instantiateViewControllerWithIdentifier:@"FiveTab"];
                    [self.navigationController pushViewController:VC animated:YES];
                    
                } AFNErrorBlock:^(NSError *error) {
                    
                    NSLog(@"注册后自动登录失败");
                    
                }];
                
                
            }
        } AFNErrorBlock:^(NSError *error) {
            NSLog(@"注册失败");
//            [subscriber sendNext:@"failued"];
//            [subscriber sendCompleted];
        }];
        
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"上传头像失败");
    }];
    
    
}




@end
