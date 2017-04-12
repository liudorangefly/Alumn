//
//  DemoVC5.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/28.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#import "DemoVC5.h"

#import "DemoVC5CellTableViewCell.h"

#import "SDRefresh.h"

#import "UITableView+SDAutoTableViewCellHeight.h"

#import "CircleViewController.h"

#import "Circle+Extension.h"

#import "User.h"

#import "AFNetManager.h"

#import "circleDeatilVC.h"

#import "SecondViewController.h"

#import "Circle+Extension.h"


@interface DemoVC5 ()


@property (nonatomic, strong) NSMutableArray *modelsArray;

@end

@implementation DemoVC5


{
    SDRefreshFooterView *_refreshFooter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    NSNumber *i=[[NSNumber alloc]initWithInt:1];
    [self creatModelsWithCount:4 page:i];
    
    __weak typeof(self) weakSelf = self;
    // 上拉加载
    _refreshFooter = [SDRefreshFooterView refreshView];
    [_refreshFooter addToScrollView:self.tableView];
    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
    _refreshFooter.beginRefreshingOperation = ^() {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSNumber *newpage=[[NSNumber alloc]initWithInt:[SecondViewController getPage]];
            NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:[circleDeatilVC getIDinList],@"topic_id",@"4",@"count",newpage,@"page",@"0",@"order", nil];
            NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [AFNetManager dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
            NSLog (@"%@",postdic);
            [Circle circeDynamicListWithParameters:postdic page:newpage SuccessBlock:^(NSDictionary *dict, BOOL success) {
                [weakSelf creatModelsWithCount:4 page:newpage];
                [weakSelf.tableView reloadData];
                [weakRefreshFooter endRefreshing];
            } AFNErrorBlock:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
            
        });
    };
}



- (void)creatModelsWithCount:(NSInteger)count page:(NSNumber *) pages
{
    __weak typeof(self) weakSelf = self;
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *plistName =[[NSString alloc] initWithFormat:@"DynamicList%@_Page%@.plist",[circleDeatilVC getIDinList],pages];
    NSLog(@"circle Plsit of dynamic%@",plistName);
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:plistName];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:fileName];
    for (NSDictionary *dict in dictArray) {
        DemoVC5Model *mod = [DemoVC5Model modelWithDict:dict page:pages ID:[circleDeatilVC getIDinList]];
        [self.modelsArray  addObject:mod];
    }
    [weakSelf.tableView reloadData];
    extern int pageoflist;
    [SecondViewController setPageAdd1];
  
  }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤1 * >>>>>>>>>>>>>>>>>>>>>>>>
    
    [self.tableView startAutoCellHeightWithCellClass:[DemoVC5CellTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    
    
    return self.modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"test";
    DemoVC5CellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[DemoVC5CellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.modelsArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    return [self.tableView cellHeightForIndexPath:indexPath model:self.modelsArray[indexPath.row] keyPath:@"model"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //该方法响应列表中行的点击事件
     DemoVC5CellTableViewCell *cell = [[DemoVC5CellTableViewCell alloc]init];
    
    cell.model = self.modelsArray[indexPath.row];
    NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:[User getXrsf],@"_xsrf",
                             cell.model.feed_id,@"feed_id",@"1",@"page",@"999",@"count",nil];
    
    [Circle getCommentWithParameters:userInfo SuccessBlock:^(NSDictionary *dict, BOOL success) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CircleViewController *VC = [sb instantiateViewControllerWithIdentifier:@"jump"];
        NSLog(@"cell.model.name%@",cell.model.name);
        currentCell = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       cell.model.name,@"name",
                       cell.model.content,@"content",
                       cell.model.icon_url ,@"icon_url",
                       cell.model.create_time,@"create_time",
                       cell.model.image_urls,@"img_urls",
                       cell.model.feed_id,@"feed_id",
                       cell.model.liked_num,@"liked_num",
                       cell.model.liked,@"liked",
                       cell.model.Atpage,@"page",
                       cell.model.ID,@"ID",
                       
                       nil];
        [self showViewController:VC sender:nil];
        
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
+(NSDictionary *)getCurrentCell
{
    //extern NSDictionary *currentCell;
    return currentCell;
}

+(void) setCurrentCellLike:(NSString *)str 
{
    [currentCell setObject:str forKey:@"liked"];
    //[currentCell setObject:num forKey:@"liked_num"];
    NSLog(@"hghjghjghjghjg$$$$%@",[currentCell objectForKey:@"liked"]);
}



@end
