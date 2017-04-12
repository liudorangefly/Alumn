//
//  ViewController.m
//  XDRefresh
//
//  Created by 韩雪滢 on 2016/7/27.
//  Copyright © 2016年 韩雪滢. All rights reserved.
//

#import "PeopleViewController.h"
#import "XDRefresh.h"
#import "User+Extension.h"
#import "User.h"
#import "PeopleListVM.h"
#import "StaticData.h"
#import "PeopleViewCell.h"
#import "ChooseButton.h"
#import "PeopleVM.h"
#import "HighLevelSearchViewController.h"
#import "PersonalSettingVC.h"
#import "PeopleViewModel.h"
#import "MeInfoViewModel.h"
#import "MeInfoViewController.h"

static NSString *CellTableIdentifier=@"CellTableIdentifier";
static BOOL isShow = NO;


@interface PeopleViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int _dataCount;
    XDRefreshHeader *_header;
    XDRefreshFooter *_footer;
}

@property (nonatomic,strong)NSArray *content;
@property (copy,nonatomic) NSMutableArray *choose;
@property (copy,nonatomic) NSArray *result;

@property (nonatomic,strong)UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (strong,nonatomic) UIView *dview;

@property (strong,nonatomic) PeopleVM *peopleVM;
@property (strong,nonatomic)MeInfoViewModel *meInfoVM;

@property (weak, nonatomic) IBOutlet UINavigationItem *naviItem;


@end

@implementation PeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.content = [[NSArray alloc] init];
    _peopleVM = [[PeopleVM alloc]init];
    self.meInfoVM = [MeInfoViewModel getMeInfoVM];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataCount = 0;
    
    _tableView=(id)[self.view viewWithTag:1];
    
    _tableView.rowHeight=116;//表示图为单元预留合适的显示空间
    UINib *nib=[UINib nibWithNibName:@"PeopleViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    UIEdgeInsets contentInset=_tableView.contentInset;
    contentInset.top=20;
    [_tableView setContentInset:contentInset];
    
    _header =  [XDRefreshHeader headerOfScrollView:_tableView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"hello");
                [_footer resetNoMoreData];
                if([StaticData getPeoplePage] != -1){
                    _dataCount += 10;
                }else{
                    _dataCount += ([StaticData getPeopleSize] - _dataCount);
                }
                [_tableView reloadData];
                [_header endRefreshing];
                [User peopleListWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
                    NSLog(@"ViewController 类中，获得人脉列表成功");
                    [PeopleListVM saveInPlist:dict];
                    
                    self.content = [PeopleListVM getFromPlist];
                    for(int i = 0; i < self.content.count;i++){
                        NSLog(@"测试输出：%@",self.content[i]);
                    }
                    
                    
                } AFNErrorBlock:^(NSError *error) {
                    NSLog(@"获得人脉列表失败");
                }];
                
            });
        });
    }];
    
    [_header beginRefreshing];
    
    _footer = [XDRefreshFooter footerOfScrollView:_tableView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"hello2");
                
                if([StaticData getPeoplePage] != -1){
                    _dataCount += 10;
                }else{
                    _dataCount += ([StaticData getPeopleSize] - _dataCount);
                }
                
                
                if ([StaticData getPeoplePage] == -1) {
                    [_footer endRefreshingWithNoMoreDataWithTitle:@"无数据了"];
                }else {
                    [_tableView reloadData];
                    [_footer endRefreshing];
                }
                
                
                [User peopleListWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
                    NSLog(@"ViewController 类中，获得人脉列表成功");
                    [PeopleListVM saveInPlist:dict];
                    
                    self.content = [PeopleListVM getFromPlist];
                    for(int i = 0; i < self.content.count;i++){
                        NSLog(@"测试输出：%@",self.content[i]);
                    }
                    
                    
                } AFNErrorBlock:^(NSError *error) {
                    NSLog(@"获得人脉列表失败");
                }];
                
            });
        });
    }];
    
    _choose =[NSMutableArray arrayWithArray:@[@"NO",@"NO",@"NO"]];
    
    //_naviView.frame.size.height
    _dview = [[UIView alloc] initWithFrame:CGRectMake(0,50, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self setDownView];
    
    //--------------------------------  leftButton  rightButton
    [self.leftButton addTarget:self action:@selector(showSearchBar:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightButton addTarget:self action:@selector(showDown:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataCount;
}

- (PeopleViewCell*)tableView:(UITableView*)tableView
       cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //注册tableCell，创建新的cell，重复利用
    PeopleViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    
    if(indexPath.row < self.content.count){
        NSDictionary *rowData=[self.content[indexPath.row] valueForKey:@"_source"];
        
        NSLog(@"当前行people的dictionary：%@",self.content[indexPath.row]);
        
        cell.name=rowData[@"name"];
        cell.major=rowData[@"faculty"];
        cell.classNum = rowData[@"major"];
        cell.job = rowData[@"job"];
        cell.city= rowData[@"city"];
        cell.peopleUrl = rowData[@"icon_url"];
        
        NSLog(@"cell.name %@; cell.major %@; cell.classNum %@;",cell.name,cell.major,cell.classNum);
    }else{
        cell.name= @"";
        cell.major= @"";
        cell.classNum = @"";
        cell.job = @"";
        cell.city= @"";
        cell.peopleUrl = @"";
        
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDown:(id)sender{
    if(!isShow){
        [self.view addSubview:_dview];
        isShow = YES;
    }
    else{
        [_dview removeFromSuperview];
        isShow = NO;
    }
    
}

- (void)setDownView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height / 5)];
    view.backgroundColor = [UIColor whiteColor];
    
    // button groups
    ChooseButton *majorBtn = [[ChooseButton alloc] initWithFrame:CGRectMake(30, 40, 80, 30)];
    majorBtn.backgroundColor = [UIColor lightGrayColor];
    [majorBtn.layer setMasksToBounds:YES];
    [majorBtn.layer setCornerRadius:6.0];
    majorBtn.alpha = 0.5;
    [majorBtn setTitle:@"同院系" forState:UIControlStateNormal];
    majorBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [majorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [majorBtn addTapBlock:^(UIButton *button) {
        if(button.backgroundColor == [UIColor lightGrayColor]){
            [button setBackgroundColor:[UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0]];
            button.alpha = 1.0;
            
            _choose[0] = @"YES";
            
            NSLog(@"同院系");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
        }else{
            [button setBackgroundColor:[UIColor lightGrayColor]];
            button.alpha = 0.5;
            _choose[0] = @"NO";
            
            NSLog(@"同院系");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
            
        }
    }];
    
    ChooseButton *yearBtn = [[ChooseButton alloc] initWithFrame:CGRectMake(150, 40, 80, 30)];
    yearBtn.backgroundColor = [UIColor lightGrayColor];
    [yearBtn.layer setMasksToBounds:YES];
    [yearBtn.layer setCornerRadius:6.0];
    yearBtn.alpha = 0.5;
    [yearBtn setTitle:@"同年级" forState:UIControlStateNormal];
    yearBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [yearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [yearBtn addTapBlock:^(UIButton *button) {
        //self.choose[0] = @"YES";
        if(button.backgroundColor == [UIColor lightGrayColor]){
            [button setBackgroundColor:[UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0]];
            button.alpha = 1.0;
            
            _choose[1] = @"YES";
            
            NSLog(@"同年级");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
            
        }else{
            [button setBackgroundColor:[UIColor lightGrayColor]];
            button.alpha = 0.5;
            
            _choose[1] = @"NO";
            
            NSLog(@"同年级");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
            
        }
    }];
    
    
    ChooseButton *cityBtn = [[ChooseButton alloc] initWithFrame:CGRectMake(270, 40, 80, 30)];
    cityBtn.backgroundColor = [UIColor lightGrayColor];
    [cityBtn.layer setMasksToBounds:YES];
    [cityBtn.layer setCornerRadius:6.0];
    cityBtn.alpha = 0.5;
    [cityBtn setTitle:@"同城市" forState:UIControlStateNormal];
    cityBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [cityBtn addTapBlock:^(UIButton *button) {
        //self.choose[0] = @"YES";
        if(button.backgroundColor == [UIColor lightGrayColor]){
            [button setBackgroundColor:[UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0]];
            button.alpha = 1.0;
            
            _choose[2] = @"YES";
            
            NSLog(@"同城市");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
            
        }else{
            [button setBackgroundColor:[UIColor lightGrayColor]];
            button.alpha = 0.5;
            
            _choose[2] = @"NO";
            
            NSLog(@"同城市");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
            
        }
    }];
    
    
        ChooseButton *closeBtn = [[ChooseButton alloc] initWithFrame:CGRectMake(270, view.bounds.size.height - 45, 80, 30)];
        closeBtn.backgroundColor = [UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0];
        [closeBtn.layer setMasksToBounds:YES];
        [closeBtn.layer setCornerRadius:6.0];
        [closeBtn setTitle:@"确定" forState:UIControlStateNormal];
        closeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
        [closeBtn addTapBlock:^(UIButton *button) {
            
            NSLog(@"提交查询条件");
            
            _result = [_peopleVM matchPeople:[NSArray arrayWithArray:_choose]];
            self.content = [NSArray arrayWithArray:_result];
            //#########################   NSLog 测试新的content
            for(int k = 0 ;k<self.content.count;k++){
                NSLog(@"新的content :%@",self.content[k]);
            }
    
            [self.tableView reloadData];
    
        }];
    
    UIButton *superBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, view.bounds.size.height - 45, 80, 30)];
    superBtn.backgroundColor = [UIColor whiteColor];
    [superBtn.layer setMasksToBounds:YES];
    [superBtn.layer setCornerRadius:6.0];
    superBtn.layer.borderWidth = 1.5;
    superBtn.layer.borderColor = [UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0].CGColor;
    [superBtn setTitle:@"高级筛选" forState:UIControlStateNormal];
    superBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [superBtn setTitleColor:[UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [superBtn addTarget:self action:@selector(superChoose:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:majorBtn];
    [view addSubview:yearBtn];
    [view addSubview:cityBtn];
    [view addSubview:closeBtn];
    [view addSubview:superBtn];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = CGRectMake(0, 0, _dview.bounds.size.width, (_dview.bounds.size.height - view.bounds.size.height));
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, maskRect);
    
    [maskLayer setPath:path];
    CGPathRelease(path);
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0,view.bounds.size.height, _dview.bounds.size.width,_dview.bounds.size.height - view.bounds.size.height)];
    maskView.layer.mask = maskLayer;
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [_dview addSubview:maskView];
    [_dview addSubview:view];
    
}

- (void)superChoose:(id)sender{
    HighLevelSearchViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"highLevel"];
    [self.navigationController pushViewController:vc animated:YES];
//  [self presentViewController:vc animated:YES completion:nil];
}

- (void)clickBtn:(UIButton*)btn{
    btn.backgroundColor = [UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0];
    if([btn.currentTitle isEqualToString:@"同院系"]){
        self.choose[0] = @"YES";
    }else if([btn.currentTitle isEqualToString:@"同年级"]){
        self.choose[1] = @"YES";
    }else if([btn.currentTitle isEqualToString:@"同城市"]){
        self.choose[2] = @"YES";
    }
}

- (void)viewWillAppear:(BOOL)animated{
//    self.peopleVM = [[PeopleVM alloc] init];

    if([PeopleViewModel highSearchFromPlist] != nil ){
        self.content = [PeopleViewModel highSearchFromPlist];
    }else{
        self.content = [PeopleListVM getFromPlist];
    }

    [self.tableView reloadData];
}

- (void)showSearchBar:(id)sender{
    PersonalSettingVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"uncertainSearch"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.content[indexPath.row];
    
    NSDictionary *personalRequest = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[dict valueForKey:@"_id"],@"uid", nil];
    
    [User getPersonalInfo:personalRequest SuccessBlock:^(NSDictionary *dict, BOOL success) {
        
        NSLog(@"获得的具体的人脉详情 %@",dict);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        
        NSLog(@"%@",plistPath1);
        //得到完整的路径名
        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"personalDetailInfoSecond.plist"];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
            
            [[dict valueForKey:@"Data"] writeToFile:fileName atomically:YES];
            NSLog(@"personalDetailInfoSecond.plist文件写入完成");
        }
        
        
        [self.meInfoVM setIfFollowed:[[[dict valueForKey:@"Data"] valueForKey:@"response"]valueForKey:@"has_followed"]];
        
        
        
        [self.meInfoVM setInfo:self.content[indexPath.row]];
        NSString *fileName2 = [plistPath1 stringByAppendingPathComponent:@"personalDetailInfoFirst.plist"];
        NSFileManager *fm2 = [NSFileManager defaultManager];
        if ([fm2 createFileAtPath:fileName2 contents:nil attributes:nil] ==YES) {
            
            [self.content[indexPath.row]  writeToFile:fileName2 atomically:YES];
            NSLog(@"personalDetailInfoFirst.plist文件写入完成");
        }
        
        
        MeInfoViewController *meInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"meInfo"];
        [self.navigationController pushViewController:meInfoVC animated:YES];
        
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"获得某个人脉详情失败，此处应加一个弹窗显示");
    }];
    
    
    
}



@end
