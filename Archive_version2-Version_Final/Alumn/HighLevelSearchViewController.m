//
//  HighLevelSearchViewController.m
//  PeopleListFinal
//
//  Created by 韩雪滢 on 9/2/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "HighLevelSearchViewController.h"
#import "YearpickerTextField.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>
#import "TextFieldSender.h"
#import "PlacepickerTextField.h"
#import "User.h"
#import "User+Extension.h"
#import "PeopleViewModel.h"
#import "PeopleViewController.h"

@interface HighLevelSearchViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet YearpickerTextField *firstyearTextField;
@property (weak, nonatomic) IBOutlet YearpickerTextField *secondyearTextField;

@property (strong,nonatomic) TextFieldSender *sender;
@property (weak, nonatomic) IBOutlet PlacepickerTextField *countryTextField;
@property (weak, nonatomic) IBOutlet PlacepickerTextField *stateTextField;
@property (weak, nonatomic) IBOutlet PlacepickerTextField *cityTextField;

@property (weak, nonatomic) IBOutlet UIButton *placeAddBtn;

@property (weak, nonatomic) IBOutlet UITableView *placeTableView;

@property (strong,nonatomic) NSMutableArray *yearArray;
@property (strong,nonatomic) NSMutableArray *placeArray;
@property (weak, nonatomic) IBOutlet UIButton *resultBtn;


@end

@implementation HighLevelSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *barBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    barBackground.backgroundColor = [UIColor colorWithRed:84.0 / 225.0 green:210 / 225.0 blue:139.0 / 225.0 alpha:1.0];
    [self.view addSubview:barBackground];
    
    //--------------------------------------- init tableViews
    self.placeTableView = (id)[self.view viewWithTag:2];
    self.placeTableView.rowHeight = 50;
    
    
    
    //---------------------------------------- init arrays
    self.yearArray = [[NSMutableArray alloc] init];
    self.placeArray = [[NSMutableArray alloc] init];
    
    self.sender = [TextFieldSender getSender];
    
    if([self.sender getCurrentText]){
        NSLog(@"YES");
    }else{
        NSLog(@"NO");
    }
    
    self.resultBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:209/255.0 blue:141/255.0 alpha:1.0];
    [self.resultBtn setTitle:@"查询" forState:UIControlStateNormal];
  
    self.resultBtn.layer.masksToBounds = YES;
    self.resultBtn.layer.cornerRadius = 6.0;
    
    self.countryTextField.tag = 51;
    self.stateTextField.tag = 52;
    self.cityTextField.tag = 53;
    self.firstyearTextField.tag = 31;
    self.secondyearTextField.tag = 32;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addPlace:(id)sender {
    if((self.countryTextField.text.length != 0) || (self.stateTextField.text.length != 0) || (self.cityTextField.text.length != 0)){
        NSString *place = [[NSString alloc] initWithFormat:@"%@_%@_%@",self.countryTextField.text,self.stateTextField.text,self.cityTextField.text];
        
        [self.placeArray addObject:place];
        
        for(int i = 0;i < self.placeArray.count;i++){
            NSLog(@"reload placetable: %@",self.placeArray[i]);
        }
        
        [self.placeTableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return self.placeArray.count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                  cell.textLabel.text = self.placeArray[indexPath.row];
    }
    
    return cell;
}

- (NSArray<UITableViewRowAction*> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
      
            [self.placeArray removeObjectAtIndex:indexPath.row];
            [self.placeTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    return @[deleteRowAction];
}
- (IBAction)searchBtnClick:(id)sender {
    
//    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",[NSNumber numberWithInt:2000],@"filter_admission_year_min",[NSNumber numberWithInt:2016],@"filter_admission_year_max",@"[\"_金融_\",\"_软件学院_\"]",@"filter_major_list",@"[\"_中国_福建_漳州_\"]",@"filter_city_list",[NSNumber numberWithInt:0],@"all_match",@"",@"query", nil];
//    NSLog(@"发送到:%@",requestDic);
    NSNumber *firstYear;
    NSNumber *lastYear ;
    
    NSLog(@"firstYearText %@",self.firstyearTextField.text);
    
    
    if(self.firstyearTextField.text.length == 0){
        firstYear = [[NSNumber alloc] initWithInteger:1905];
        NSLog(@"firstTextField.length is 0");
    }else{
        firstYear = [[NSNumber alloc] initWithInteger:[self.firstyearTextField.text integerValue]];
    }
    
    if(self.secondyearTextField.text.length == 0){
        lastYear = [[NSNumber alloc]initWithInteger:2016];
    }else{
        lastYear = [[NSNumber alloc] initWithInteger:[self.secondyearTextField.text integerValue]];
    }
    
    NSString *searchPlace = [[NSString alloc] initWithFormat:@"[\"_%@_\",",self.placeArray[0]];
    for(int i = 1;i < self.placeArray.count - 1; i++){
        searchPlace = [NSString stringWithFormat:@"%@\"_%@_\",",searchPlace,self.placeArray[i]];
    }
    searchPlace = [NSString stringWithFormat:@"%@\"_%@_\"]",searchPlace,self.placeArray[self.placeArray.count - 1]];

    NSLog(@"搜索地点：%@",searchPlace);
    
        NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",firstYear,@"filter_admission_year_min",lastYear,@"filter_admission_year_max",@"[]",@"filter_major_list",searchPlace,@"filter_city_list",[NSNumber numberWithInt:0],@"all_match",@"",@"query",[NSNumber numberWithInt:1],@"page",[NSNumber numberWithInt:10],@"size",nil];
        NSLog(@"发送到:%@",requestDic);
    [User highSearchWithParameters:requestDic SuccessBlock:^(NSDictionary *dict, BOOL success) {
        NSLog(@"获取高级搜索列表成功");
        [PeopleViewModel highSearchSaveInplist:[dict valueForKey:@"Data"]];
        [self.sender setIsHighSearch:YES];
      } AFNErrorBlock:^(NSError *error) {
        NSLog(@"获取高级搜索列表失败");
    }];
    
//    PeopleViewController *peopleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"peopleVC"];
//  //  peopleVC.content = [[NSArray alloc] initWithArray:[PeopleViewModel highSearchFromPlist]];
//    [self.navigationController pushViewController:peopleVC animated:YES];
    

}

@end
