//
//  MySerachBar.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/26.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//


#define SEMWIDTH [UIScreen mainScreen].bounds.size.width

#define SEMHEIGHT [UIScreen mainScreen].bounds.size.height

#define SEMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#import <UIKit/UIKit.h>
@class CustomSearchBar;

@protocol CustomsearchResultsUpdater <NSObject>

@required
/**第一步根据输入的字符检索 必须实现*/
-(void)CustomSearch:(CustomSearchBar *)searchBar inputText:(NSString *)inputText;
@end

@protocol CustomSearchBarDataSouce <NSObject>
@required
// 设置显示列的内容
-(NSInteger)searchBarNumberOfRowInSection;
// 设置显示没行的内容
-(NSString *)CustomSearchBar:(CustomSearchBar *)searchBar titleForRowAtIndexPath:(NSIndexPath *)indexPath;


@optional
// 每行图片
-(NSString *)CustomSearchBar:(CustomSearchBar *)searchBar imageNameForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol CustomSearchBarDelegate <NSObject>
@optional
// 点击每一行的效果
- (void)CustomSearchBar:(CustomSearchBar *)searchBar didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)CustomSearchBar:(CustomSearchBar *)searchBar cancleButton:(UIButton *)sender;

@end


@interface CustomSearchBar : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>


// 显示
+(instancetype)show:(CGPoint)orgin andHeight:(CGFloat)height;


@property (nonatomic, weak) id<CustomSearchBarDataSouce>  DataSource;
@property (nonatomic, weak) id<CustomSearchBarDelegate>  delegate;
@property (nonatomic, weak) id<CustomsearchResultsUpdater>  searchResultsUpdater;
@end


