//
//  RNTableViewController.m
//  TestingSearchBar
//
//  Created by Ryan Nystrom on 5/19/14.
//  Copyright (c) 2014 Ryan Nystrom. All rights reserved.
//

#import "RNTableViewController.h"

@interface RNTableViewController ()
<UISearchBarDelegate>


@property (nonatomic, strong) NSArray *items;


@end

@implementation RNTableViewController

NSString * const CellIdentifier = @"CellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[UISearchBar alloc] init];
    [self.searchBar sizeToFit];
    
    self.title = @"Table View";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
   
    self.searchBar.placeholder = @"发现圈子";
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.alpha =0.93;
    self.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchBar.alpha=1;
   self.searchBar.showsCancelButton= NO;
    self.searchBar.showsScopeBar = YES;
//    for (UIView *view in [[_searchBar.subviews lastObject] subviews]) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            self.cancelButton = (UIButton *)view;
//            self.cancelButton.tintColor = [UIColor redColor];
//            [_cancelButton addTarget:self
//                    action:@selector(test:)
//          forControlEvents:UIControlEventTouchUpInside
//             ];
//        }
    
//    }
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame = CGRectMake(20, 20, 280, 40);
//    btn.backgroundColor = [UIColor clearColor];
//    [btn setTitle:@"点击" forState:UIControlStateNormal];
//    
//    [btn addTarget:self
//            action:@selector(test:)
//  forControlEvents:UIControlEventTouchUpInside
//     ];
//    
//    [self.view addSubview:btn];
    

    self.tableView.tableHeaderView = self.searchBar;

    self.items = @[@"I'm", @"A", @"Child", @"UITableViewController"];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
        [self.tableView setHidden:true];
        [self.searchBar setHidden:true];
}

//- (IBAction)test:(UIButton *)sender
//{
//     NSLog(@"testOut Event");
//    NSString *msg = @"f*au*ck U";
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"message" message:msg                delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];  [alert show];
//    [self.tableView setHidden:true];
//    [self.searchBar setHidden:true];
//    
//}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
