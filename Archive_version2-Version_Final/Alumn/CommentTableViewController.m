//
//  CommentTableViewController.m
//  scrollViewDamo
//
//  Created by 韩雪滢 on 9/11/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import "CommentTableViewController.h"
#import "MessageViewModel.h"
#import "CommentTableViewCell.h"
#import "User.h"
#import "User+Extension.h"

@interface CommentTableViewController ()

@property (nonatomic,strong)NSArray *commentArray;

@end

@implementation CommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [User reciveCommentWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
        NSLog(@"检测评论列表是否存入");
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"获取评论失败");
    }];

    
    NSLog(@"评论列表界面CommmentList");
    
    UINib *nib = [UINib nibWithNibName:@"CommentTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"commentCell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = 90;
    
    //    if(!([MessageViewModel commentListFromPlist] == nil)){
    //    self.commentArray = [MessageViewModel commentListFromPlist];
    //    }else{
    //        self.commentArray = nil;
    //    }
    
   // NSLog(@"评论列表count  %lu",(long)[MessageViewModel commentListFromPlist].count);
    
    
    self.commentArray = [MessageViewModel commentListFromPlist];
    NSLog(@"评论列表count  %lu",(long)[MessageViewModel commentListFromPlist].count);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.commentArray = [MessageViewModel commentListFromPlist];
    return self.commentArray.count;
}


- (CommentTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.commentArray = [MessageViewModel commentListFromPlist];
    
    NSLog(@"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%评论列表的第一个  %@",self.commentArray[0]);
    
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    
    NSLog(@"评论的cell");
    if(self.commentArray.count > 0){
        cell.name = [[self.commentArray[indexPath.row] valueForKey:@"creator"]valueForKey:@"name"];
        cell.comment = [[self.commentArray[indexPath.row]valueForKey:@"feed"] valueForKey:@"content"];
        cell.updateTime = [self.commentArray[indexPath.row] valueForKey:@"create_time"];
        cell.imgUrl = [[self.commentArray[indexPath.row] valueForKey:@"creator"]valueForKey:@"icon_url"];
    }
    
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSLog(@"点击某条具体的消息");
//    
//    NSString *title = [[NSString alloc] initWithFormat:@"来自%@的评论", [[self.commentArray[indexPath.row] valueForKey:@"creator"]valueForKey:@"name"]];
//    NSString *message = [[self.commentArray[indexPath.row]valueForKey:@"feed"] valueForKey:@"content"];
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    [alertVC addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"关闭弹窗");
//    }]];
//    
//    [self presentViewController:alertVC animated:YES completion:nil];
//    
//}
//
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
