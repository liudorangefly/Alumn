//
//  PersonalSettingVC.m
//  PersonalSetting
//
//  Created by 韩雪滢 on 9/23/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "PersonalSettingVC.h"
#import "User.h"
#import "User+Extension.h"
#import "PeopleViewCell.h"

static NSString *ResultTableCellID = @"CellTableIdentifier";

@interface PersonalSettingVC ()

@property (nonatomic,strong) NSString *keyword;
@property (nonatomic,strong) NSMutableArray *resultArray;

@property (nonatomic,strong) UITableView *resultTable;

@end

@implementation PersonalSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.resultTable = (id)[self.view viewWithTag:1];
    //tableCell  的设置和注册
    UINib *nib = [UINib nibWithNibName:@"PeopleViewCell" bundle:nil];
    [self.resultTable registerNib:nib forCellReuseIdentifier:ResultTableCellID];
    self.resultTable.rowHeight = 116;
    
    self.resultTable.delegate = self;
    self.resultTable.dataSource = self;
    
    if(self.resultTable.style == UITableViewStylePlain){
//        UIEdgeInsets contentInset = self.resultTable.contentInset;
//        contentInset.top = 20;
//        [self.resultTable setContentInset:contentInset];
        
        UIView *barBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
        barBackground.backgroundColor = [UIColor colorWithRed:84.0 / 225.0 green:210 / 225.0 blue:139.0 / 225.0 alpha:1.0];
        [self.view addSubview:barBackground];
    }
    
    self.resultArray = [[NSMutableArray alloc]init];
    self.keyword = [[NSString alloc]init];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,44)];
    [searchBar setTintColor:[UIColor colorWithRed:84.0 / 225.0 green:210 / 225.0 blue:139.0 / 225.0 alpha:0.8]];
    [searchBar setPlaceholder:@"请输入关键字"];
    
    [searchBar setShowsSearchResultsButton:YES];
    
    self.resultTable.tableHeaderView = searchBar;
    
    
    searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"搜索结果表的行数 %ld",self.resultArray.count);
    
    return self.resultArray.count;
}
//---------------------------------  设置tableCell
- (PeopleViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PeopleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ResultTableCellID forIndexPath:indexPath];
    NSDictionary *rowData = [self.resultArray[indexPath.row] valueForKey:@"_source"];
    cell.name = rowData[@"name"];
    cell.major = rowData[@"faculty"];
    cell.classNum = rowData[@"major"];
    cell.job = rowData[@"job"];
    cell.city= rowData[@"city"];
    cell.peopleUrl = rowData[@"icon_url"];
    
    return cell;
}


#pragma mark --UISearchBarDelegate
//--------------------------- 得到焦点开始编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    NSLog(@"search Bar shouldBeginEditing");
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    return YES;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"点击searchButton进行搜索");
    
    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[NSNumber numberWithInt:0],@"filter_admission_year_min",[NSNumber numberWithInt:9999],@"filter_admission_year_max",@"[]",@"filter_major_list",@"[]",@"filter_city_list",[NSNumber numberWithInt:1],@"all_match",searchBar.text,@"query",[NSNumber numberWithInt:1],@"page",[NSNumber numberWithInt:10],@"size", nil];
    NSLog(@"发送到:%@",requestDic);
    [User uncertainSearchWithParameters:requestDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
        //设置 resultArray 显示
        self.resultArray = [[[[dict valueForKey:@"Data"]valueForKey:@"response"]valueForKey:@"hits"]valueForKey:@"hits"];
        
        [searchBar resignFirstResponder];
         [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        [self.resultTable reloadData];
        
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"获取模糊搜索列表失败");
    }];
    
}

@end
