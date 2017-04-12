//
//  LfDeleteVC.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/29.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//



#import "LfDeleteVC.h"

#import "LfDeleteVCCellTableViewCell.h"

#import "SDRefresh.h"

#import "UITableView+SDAutoTableViewCellHeight.h"

@interface LfDeleteVC ()

@property (nonatomic, strong) NSMutableArray *modelsArray;

@end

@implementation LfDeleteVC
{
    SDRefreshFooterView *_refreshFooter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self creatModelsWithCount:10];
    
    __weak typeof(self) weakSelf = self;
    
    // 上拉加载
    _refreshFooter = [SDRefreshFooterView refreshView];
    [_refreshFooter addToScrollView:self.tableView];
    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
    _refreshFooter.beginRefreshingOperation = ^() {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf creatModelsWithCount:10];
            [weakSelf.tableView reloadData];
            [weakRefreshFooter endRefreshing];
        });
    };
}

- (void)creatModelsWithCount:(NSInteger)count
{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *iconImageNamesArray = @[@"1.jpg",
                                     @"2.jpg",
                                     @"3.jpg",
                                     @"4.jpg",
                                     @"5.jpg",
                                     ];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
  
    
    
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
       
        
        LfDeleteVCModel *model = [LfDeleteVCModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        
        
        [self.modelsArray addObject:model];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤1 * >>>>>>>>>>>>>>>>>>>>>>>>
    
    [self.tableView startAutoCellHeightWithCellClass:[LfDeleteVCCellTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    
    
    return self.modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"test";
    LfDeleteVCCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LfDeleteVCCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.modelsArray[indexPath.row];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //----通过表视图是否处于编辑状态来选择是左滑删除，还是多选删除。
    if (self.tableView.editing)
    {
        //当表视图处于没有未编辑状态时选择多选删除
        return UITableViewCellEditingStyleDelete| UITableViewCellEditingStyleInsert;
    }
    else
    {
        //当表视图处于没有未编辑状态时选择左滑删除
        return UITableViewCellEditingStyleDelete;
    }
    
}

//根据不同的editingstyle执行数据删除操作（点击左滑删除按钮的执行的方法）
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.modelsArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if(editingStyle == (UITableViewCellEditingStyleDelete| UITableViewCellEditingStyleInsert))
    {
        
    }
    
}

//修改左滑删除按钮的title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    return [self.tableView cellHeightForIndexPath:indexPath model:self.modelsArray[indexPath.row] keyPath:@"model"];
}


@end
