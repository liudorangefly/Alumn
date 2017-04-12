//
//  ViewController.m
//  Setting
//
//  Created by 韩雪滢 on 10/4/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "SettingViewController.h"
#include "User.h"
#include "User+Extension.h"
#include "PlacepickerTextField.h"
#import "MyMainViewController.h"

@interface SettingViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *jobField;
@property (weak, nonatomic) IBOutlet PlacepickerTextField *countryField;
@property (weak, nonatomic) IBOutlet PlacepickerTextField *stateField;
@property (weak, nonatomic) IBOutlet PlacepickerTextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *companyField;
@property (weak, nonatomic) IBOutlet UITextField *industryField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextView *personalTextView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;


@property (weak, nonatomic) IBOutlet UIView *imgSetView;
@property (weak, nonatomic) IBOutlet UIView *jobSetView;
@property (weak, nonatomic) IBOutlet UIView *placeSetView;
@property (weak, nonatomic) IBOutlet UIView *companySetView;
@property (weak, nonatomic) IBOutlet UIView *phoneSetView;
@property (weak, nonatomic) IBOutlet UIView *industrySetView;
@property (weak, nonatomic) IBOutlet UIView *introducSetView;

@property (strong,nonatomic) UIButton *changeImgBtn;

@property (strong,nonatomic)User *user;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.user = [User getUser];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    [self initView];
}

- (void)initView{
    //用户信息 用[User getUserDic] 得到
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"User.plist"]];
    NSDictionary *userDic = [User getUserDic];
    
    //设置空间显示初始值
    self.nameLabel.text = [userDic valueForKey:@"name"];
    self.jobField.placeholder = [userDic valueForKey:@"job"];
    self.countryField.placeholder = [userDic valueForKey:@"country"];
    self.stateField.placeholder = [userDic valueForKey:@"state"];
    self.cityField.placeholder = [userDic valueForKey:@"city"];
    self.companyField.placeholder = [userDic valueForKey:@"company"];
    self.industryField.placeholder = @"职位";
    
    self.phoneField.placeholder = [userDic valueForKey:@"telephone"];
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.personalTextView.text = [userDic valueForKey:@"instroduction"];
    
    //设置saveBtn的样式
    self.saveBtn.layer.masksToBounds = YES;
    self.saveBtn.layer.cornerRadius = 6.0;
    
    //设置view的边
    self.imgSetView.layer.borderWidth = 0.4;
    self.imgSetView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.jobSetView.layer.borderWidth = 0.4;
    self.jobSetView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.placeSetView.layer.borderWidth = 0.4;
    self.placeSetView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.companySetView.layer.borderWidth = 0.4;
    self.companySetView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.phoneSetView.layer.borderWidth = 0.4;
    self.phoneSetView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.industrySetView.layer.borderWidth = 0.4;
    self.industrySetView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.introducSetView.layer.borderWidth = 0.4;
    self.introducSetView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //设置placetextfield
    self.countryField.tag = 51;
    self.stateField.tag = 52;
    self.cityField.tag = 53;
    
    
    //设置头像filed
 //   [self.userImg sd_setImageWithURL:[NSURL URLWithString:[userDic valueForKey:@"icon_url"]]];
    
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[userDic valueForKey:@"icon_url"]]]];
    [self.userImg setImage:[self OriginImage:img scaleToSize:self.userImg.bounds.size]];
    
    self.userImg.layer.masksToBounds = YES;
    self.userImg.layer.cornerRadius = self.userImg.bounds.size.width / 2.0;
    
    
    self.changeImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, 91, 30, 30)];
    [self.changeImgBtn addTarget:self action:@selector(callActionSheetFunc:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeImgBtn setTitle:@">" forState:UIControlStateNormal];
    [self.changeImgBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:201/255.0 blue:155/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:self.changeImgBtn];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)fingerTapped:(UITapGestureRecognizer*)gestureRecognizer{
    [self.view endEditing:YES];
}

//改变图片的大小适应image View的大小
-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (void)callActionSheetFunc:(id)sender{
    
    NSLog(@"选择新的头像");
    
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
    self.userImg.image = [self OriginImage:[info objectForKey:imgKey] scaleToSize:self.userImg.bounds.size];
    
    // －－－－－－－－－－－－－－－－－－－－－－ 显示完自动退出
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (IBAction)saveChange:(id)sender {
    [User upLoadUserImg:self.userImg.image method:@"upload_normal_img" SuccessBlock:^(NSDictionary *dict, BOOL success) {
        NSLog(@"上传头像成功%@",dict);
        
        NSString *job,*city,*state,*country,*company,*telephone,*introduction;
        
        if(self.jobField.text.length == 0){
            job = self.jobField.placeholder;
        }else{
            job = self.jobField.text;
        }
        
        if(self.cityField.text.length == 0){
            city = self.cityField.placeholder;
        }else{
            city = self.cityField.text;
        }
        
        if(self.stateField.text.length == 0){
            state = self.stateField.placeholder;
        }else{
            state = self.stateField.text;
        }
        
        if(self.countryField.text.length == 0){
            country = self.countryField.placeholder;
        }else{
            country = self.countryField.text;
        }
        
        if(self.companyField.text.length == 0){
            company = self.companyField.placeholder;
        }else{
            company = self.companyField.text;
        }
        
        if(self.phoneField.text.length == 0){
            telephone = self.phoneField.placeholder;
        }else{
            telephone = self.phoneField.text;
        }
        
       
        introduction = self.personalTextView.text;
        

        NSDictionary *phoneDic = [[NSDictionary alloc] initWithObjectsAndKeys:telephone,@"telephone", nil];
        
        NSDictionary *infoDic = [[NSDictionary alloc] initWithObjectsAndKeys:[dict valueForKey:@"img_key"],@"icon_url",job,@"job",city,@"city",state,@"state",country,@"country",company,@"company",[User dictionaryToJson:phoneDic],@"public_contact_list",introduction,@"introduction", nil];
        
        NSDictionary *changeDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[User dictionaryToJson:infoDic],@"info_json", nil];
        
        NSLog(@"上传的个人信息 %@",changeDic);
        
        [User changeSettingWithParameters:changeDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
            NSLog(@"上传更新的个人资料成功");
        } AFNErrorBlock:^(NSError *error) {
            NSLog(@"上传更新的个人资料失败");
        }];
        
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"上传头像失败");
    }];
    

}

- (IBAction)backMeVC:(id)sender {
    
    MyMainViewController *myMainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FiveTab"];
   // [self presentViewController:myMainVC animated:YES completion:nil];
    [self.navigationController pushViewController:myMainVC animated:YES];
}




@end
