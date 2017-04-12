//
//  MessageViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/13.
//  Copyright © 2016年 刘畅. All rights reserved.
//

#define HeadMenuViewHeight 45
// 获取RGB颜色
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]



#import "MessageViewController.h"

#import <AVOSCloud/AVOSCloud.h>
#import <CDChatManager.h>
#import "ChatListViewController.h"
#import "MessageViewModel.h"
#import "User.h"
#import "User+Extension.h"

#import "CommentTableViewController.h"
#import "MessageTableViewController.h"

#import "SystemMessageTableViewCell.h"

#import "MessageDetailVM.h"
#import "ApplyMessageVC.h"
#import "SystemMessageVC.h"

@interface MessageViewController ()<UIScrollViewDelegate,UITableViewDelegate>
{
    CGFloat _lastPosition;
}

//框架最下面的scrollView;
@property(nonatomic,strong)UIScrollView * bottomScrollView;
//左右滑动的scrollView
@property(nonatomic,strong)UIScrollView * contentScrollView;
//这个是模拟头部最上面那个滑动视图
//@property(nonatomic,strong)UILabel * headScrollView;
//这个是中间那个菜单
@property(nonatomic,retain)UIScrollView * headMenuScrollView;
//模拟数据用的
@property(nonatomic,retain)NSArray * headMenuDateArray;
//这个数组放 tableView
@property(nonatomic,retain)NSMutableArray * contableTableViewArray;


//headScrollView当前被选中的按钮标记 默认为0
@property(nonatomic,assign)NSInteger currentSeletedHeadScrollViewSubButtonNumberTag;
//headScrollView当前被选中的按钮标记 默认为0
@property(nonatomic,assign)UIButton * currentSeletedButton;
@property(nonatomic,assign)CGFloat currentContScrollViewOffSizeWidth;
@property(nonatomic,assign)BOOL refusedHeadSrollViewAnimation;
@property(nonatomic,assign)UIView * contentViewLeftView;
@property(nonatomic,assign)UIView * contentViewRightView;
@property(nonatomic,assign)UIView * contentViewCurrentView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initWithUserInterface];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    self.headMenuDateArray = @[@"私信",@"通知",@"评论"];
}
- (void)initWithUserInterface
{
    _contableTableViewArray = [[NSMutableArray alloc]init];
    [self.view addSubview:self.bottomScrollView];
    //    [self.bottomScrollView addSubview:self.headScrollView];
    [self.bottomScrollView addSubview:self.headMenuScrollView];
    [self.bottomScrollView addSubview:self.contentScrollView];
}
- (UIScrollView *)bottomScrollView
{
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,60, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        _bottomScrollView.delegate = self;
        _bottomScrollView.backgroundColor = [UIColor whiteColor];
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.showsVerticalScrollIndicator = NO;
        _bottomScrollView.contentSize = CGSizeMake(_bottomScrollView.bounds.size.width , _bottomScrollView.bounds.size.height);
        _bottomScrollView.alwaysBounceVertical = YES;
        _bottomScrollView.alwaysBounceHorizontal = NO;
    }
    return _bottomScrollView;
}

//改变图片的大小适应image View的大小
-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}



- (UIScrollView *)headMenuScrollView
{
    if (!_headMenuScrollView) {
        _headMenuScrollView = [self createHeadMenuScrollView];
    }
    return _headMenuScrollView;
}

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headMenuScrollView.frame), CGRectGetWidth([UIScreen mainScreen].bounds), self.bottomScrollView.bounds.size.height - self.headMenuScrollView.bounds.size.height)];
        _contentScrollView.backgroundColor = [UIColor redColor];
        _contentScrollView.delegate = self;
        _contentScrollView.bounces = NO;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        if (_headMenuDateArray.count < 3) {
            _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * _headMenuDateArray.count , _contentScrollView.bounds.size.height);
        }else{
            _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * 3 , _contentScrollView.bounds.size.height);
        }
    }
    
    return _contentScrollView;
}
- (void)setHeadMenuDateArray:(NSArray *)headMenuDateArray
{
    if (_headMenuDateArray) {
        _headMenuDateArray = nil;
    }
    [_headMenuScrollView removeFromSuperview];
    _headMenuDateArray = headMenuDateArray;
    
    if (_headMenuDateArray.count < 3) {
        _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * _headMenuDateArray.count , _contentScrollView.bounds.size.height);
    }else{
        _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * 3 , _contentScrollView.bounds.size.height);
    }
    self.headMenuScrollView = [self createHeadMenuScrollView];
    [self.bottomScrollView addSubview:_headMenuScrollView];
    [self setContentscrollViewContentTableView];
}

- (void)setCurrentSeletedHeadScrollViewSubButtonNumberTag:(NSInteger)currentSeletedHeadScrollViewSubButtonNumberTag
{
    _currentSeletedHeadScrollViewSubButtonNumberTag = currentSeletedHeadScrollViewSubButtonNumberTag;
    if (_headMenuScrollView && _headMenuDateArray.count) {
        UIView * view = [_headMenuScrollView viewWithTag:100];
        UIButton * button = (UIButton *)[_headMenuScrollView viewWithTag:1000 + currentSeletedHeadScrollViewSubButtonNumberTag];
        button.center = CGPointMake(button.frame.size.width * (CGFloat)(0.5 + currentSeletedHeadScrollViewSubButtonNumberTag), button.center.y);
        view.center = CGPointMake(view.frame.size.width * (CGFloat)(0.5 + currentSeletedHeadScrollViewSubButtonNumberTag), view.center.y);
        if (_currentSeletedButton) {
            _currentSeletedButton.selected = NO;
        }
        button.selected = YES;
        [self contentScrollViewPressAnimation];
        _currentSeletedButton = button;
        [self headMenuScrollViewPressAnimation];
        
    }
}
//创建headmenuScrollView
- (UIScrollView *)createHeadMenuScrollView
{
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), HeadMenuViewHeight)];
    if (_headMenuScrollView) {
        scrollView.frame = _headMenuScrollView.frame;
    }
    scrollView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    if (_headMenuDateArray && _headMenuDateArray.count > 0) {
        NSInteger arrayCount = _headMenuDateArray.count;
        
        CGFloat  buttonWidth = 0;
        if (arrayCount <= 4){
            buttonWidth = CGRectGetWidth([UIScreen mainScreen].bounds)/arrayCount;
        }
        else if (arrayCount > 4){
            buttonWidth = CGRectGetWidth([UIScreen mainScreen].bounds)/4.0;
        }
        scrollView.contentSize = CGSizeMake(buttonWidth * arrayCount , scrollView.frame.size.height);
        for (int i = 0 ; i < _headMenuDateArray.count ; i ++) {
            NSString * string = _headMenuDateArray[i];
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, scrollView.frame.size.height)];
            button.center = CGPointMake(buttonWidth * (CGFloat)(0.5 + i), scrollView.frame.size.height/2.0);
            [button setTitle:string forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [button setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
            //            [button setTitleColor:RGB(24, 181, 44) forState:UIControlStateSelected];
            [button addTarget:self action:@selector(processHeadMenuScrollViewButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 1000 + i;
            [scrollView addSubview:button];
            
            if (i == _currentSeletedHeadScrollViewSubButtonNumberTag){
                button.selected = YES;
                _currentSeletedButton = button;
            }
        }
        //$$$$$$$$$$$$$$$$$$$$$$点击button下的选中标记
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, 3/ 667.0 * CGRectGetHeight([UIScreen mainScreen].bounds))];
        //######################$$$$$$$$$$$$$$$$$$$$$$修改被选中button的标志
        
        UIImage *markImg = [UIImage imageNamed:@"markImg"];
        UIImageView *backImgView = [[UIImageView alloc]initWithImage:[self OriginImage:markImg scaleToSize:view.bounds.size]];
        
        backImgView.contentMode = UIViewContentModeScaleAspectFill;
        
        
        view.center = CGPointMake(buttonWidth * (CGFloat)(0.5 + _currentSeletedHeadScrollViewSubButtonNumberTag), scrollView.frame.size.height - view.frame.size.height/2.0);
        view.tag = 100;
        
        
        [view addSubview:backImgView];
        
        [scrollView addSubview:view];
    }else{
        
        UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.center =  CGPointMake( 130/ 375.0 * CGRectGetWidth([UIScreen mainScreen].bounds) , scrollView.bounds.size.height/2.0);
        [scrollView addSubview:activityView];
        [activityView startAnimating];
        
        UILabel * label = [[UILabel alloc]initWithFrame:scrollView.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:16];
        label.text = @"      正在加载数据";
        label.textColor = RGB(100, 100, 100);
        [scrollView addSubview:label];
    }
    
    return scrollView;
}


#warning Mark替换代码修改区

//创建下面的tableView
- (void)setContentscrollViewContentTableView
{
    [self.contableTableViewArray removeAllObjects];
    
    NSLog(@"headMenuDataArray.count %ld",(long)self.headMenuDateArray.count);
    
    for (int i = 0; i < self.headMenuDateArray.count; i ++) {
        
        switch(i){
            case 0:{
                NSLog(@"私信界面");
                NSLog(@"私信的名字%@",[[User getUserDic]valueForKey:@"name"]);
                
                [[CDChatManager manager] openWithClientId:[[User getUserDic]valueForKey:@"name"] callback:^(BOOL succeeded, NSError *error) {
                    ChatListViewController *chatList = [[ChatListViewController alloc] init];
                    chatList.view.frame = self.contentScrollView.bounds;
                    chatList.tableView.tag = 100 + i;
                    [self addChildViewController:chatList];
                    [self.contableTableViewArray addObject:chatList.view];
                }];
                ChatListViewController *chatList = [[ChatListViewController alloc] init];
                chatList.tableView.tag = 100 + i;
                chatList.view.frame = self.contentScrollView.bounds;
                [self addChildViewController:chatList];
                [self.contableTableViewArray addObject:chatList.view];
                
                break;
            }
            case 1:{
                NSLog(@"通知界面");
                MessageTableViewController *tableViewVC = [[MessageTableViewController alloc]init];
                tableViewVC.view.frame = self.contentScrollView.bounds;
                tableViewVC.tableView.delegate = self;
                tableViewVC.tableView.tag = 100 + i;
                [self addChildViewController:tableViewVC];
                [tableViewVC.tableView reloadData];
                
                [_bottomScrollView.panGestureRecognizer requireGestureRecognizerToFail:tableViewVC.tableView.panGestureRecognizer];
                
                [self.contableTableViewArray addObject:tableViewVC.view];
                
                break;
                
            }
            case 2:{
                NSLog(@"评论界面");
                
                CommentTableViewController *commentVC = [[CommentTableViewController alloc]init];
                commentVC.view.frame = self.contentScrollView.bounds;
                commentVC.tableView.delegate = self;
                commentVC.tableView.tag = 100 + i;
                
                [commentVC.tableView reloadData];
                
                [self addChildViewController:commentVC];
                
                [_bottomScrollView.panGestureRecognizer requireGestureRecognizerToFail:commentVC.tableView.panGestureRecognizer];
                
                [self.contableTableViewArray addObject:commentVC.view];
                break;
            }
            default:
                break;
        }
        
    }
    
    [self contentScrollViewArrangementContent];
}




//按钮事件
- (void)processHeadMenuScrollViewButton:(UIButton *)button
{
    if (_currentSeletedButton && button == _currentSeletedButton) {
        return;
    }
    self.currentSeletedHeadScrollViewSubButtonNumberTag = button.tag - 1000;
}
#pragma mark -- contentScrollView方法部分

//contentScrollView内容整理和更换
- (void)contentScrollViewArrangementContent
{
    if (_headMenuDateArray.count  && _currentSeletedHeadScrollViewSubButtonNumberTag >= 0 && _currentSeletedHeadScrollViewSubButtonNumberTag <= _headMenuDateArray.count - 1 ) {
        NSInteger number = _headMenuDateArray.count >= 3 ? 3 : _headMenuDateArray.count;
        if (number >= 3) {
            NSInteger judge = 0;
            if (_currentSeletedHeadScrollViewSubButtonNumberTag - 1 <= 0) {
                judge = 0;
            }else if(_currentSeletedHeadScrollViewSubButtonNumberTag == _headMenuDateArray.count - 1){
                judge = _currentSeletedHeadScrollViewSubButtonNumberTag - 2;
            }else{
                judge = _currentSeletedHeadScrollViewSubButtonNumberTag - 1;
            }
            [_contentViewCurrentView removeFromSuperview];
            [_contentViewLeftView    removeFromSuperview];
            [_contentViewRightView   removeFromSuperview];
            _contentViewCurrentView = nil;
            _contentViewLeftView = nil;
            _contentViewRightView = nil;
            for (int i = 0; i < number; i ++) {
                
                UIView * view = _contableTableViewArray[i + judge];
                view.center = CGPointMake(_contentScrollView.frame.size.width * (i + 0.5) , _contentScrollView.frame.size.height/2.0);
                
                [_contentScrollView addSubview:view];
                
                if (i + judge == _currentSeletedHeadScrollViewSubButtonNumberTag) {
                    _contentScrollView.contentOffset = CGPointMake(_contentScrollView.frame.size.width * i, 0);
                    _currentContScrollViewOffSizeWidth = _contentScrollView.frame.size.width * i;
                    self.contentViewCurrentView = view;
                }else if (i + judge == _currentSeletedHeadScrollViewSubButtonNumberTag + 1){
                    self.contentViewRightView = view;
                }else if (i + judge == _currentSeletedHeadScrollViewSubButtonNumberTag - 1){
                    self.contentViewLeftView = view;
                }
                
            }
        }else{
            for (int i = 0; i < number; i ++) {
                
                UIView * view = _contableTableViewArray[i];
                view.center = CGPointMake(_contentScrollView.frame.size.width * (i + 0.5) , _contentScrollView.frame.size.height/2.0);
                
                [_contentScrollView addSubview:view];
                
                if (i  == _currentSeletedHeadScrollViewSubButtonNumberTag) {
                    self.contentViewCurrentView = view;
                    _contentScrollView.contentOffset = CGPointMake(_contentScrollView.frame.size.width * i, 0);
                    _currentContScrollViewOffSizeWidth = _contentScrollView.frame.size.width * i;
                    
                }
                
            }
        }
    }
}
#pragma mark -- menuScrollView动画
//按下headMenuScrollView动画
- (void)headMenuScrollViewPressAnimation
{
    CGFloat width = -1.0;
    if (_currentSeletedButton.center.x > _headMenuScrollView.frame.size.width/2.0 && _currentSeletedButton.center.x < _headMenuScrollView.contentSize.width - _headMenuScrollView.frame.size.width /2.0) {
        width = _currentSeletedButton.center.x  - _headMenuScrollView.frame.size.width/2.0;
    }else if (_currentSeletedButton.center.x <= _headMenuScrollView.frame.size.width/2.0){
        width = 0.0;
    }else if (_currentSeletedButton.center.x >= _headMenuScrollView.contentSize.width - _headMenuScrollView.frame.size.width /2.0){
        width = _headMenuScrollView.contentSize.width - _headMenuScrollView.frame.size.width;
    }
    if (width >= 0) {
        [_headMenuScrollView setContentOffset:CGPointMake(width, 0) animated:YES];
    }
}
//按下contentScrollView动画
- (void)contentScrollViewPressAnimation
{
    if (_currentSeletedHeadScrollViewSubButtonNumberTag == _currentSeletedButton.tag - 1000) {
        return;
    }
    NSInteger i = 0;
    if (_currentSeletedHeadScrollViewSubButtonNumberTag > _currentSeletedButton.tag - 1000) {
        i = 1;
    }else if (_currentSeletedHeadScrollViewSubButtonNumberTag < _currentSeletedButton.tag - 1000){
        i = -1;
    }
    if (_currentSeletedHeadScrollViewSubButtonNumberTag != _currentSeletedButton.tag - 1
        && _currentSeletedHeadScrollViewSubButtonNumberTag != _currentSeletedButton.tag + 1) {
        UIView * view = (UIView *)_contableTableViewArray[_currentSeletedHeadScrollViewSubButtonNumberTag];
        view.center = CGPointMake(_currentContScrollViewOffSizeWidth + (CGFloat)(i + 0.5) * _contentScrollView.frame.size.width  , _contentScrollView.frame.size.height/2.0);
        if (i == 1) {
            [_contentViewRightView removeFromSuperview];
        }else if (i == -1){
            [_contentViewLeftView removeFromSuperview];
        }
        [_contentScrollView addSubview:view];
        
    }
    _currentSeletedButton = (UIButton *)[_headMenuScrollView viewWithTag:_currentSeletedHeadScrollViewSubButtonNumberTag + 1000];
    _refusedHeadSrollViewAnimation = YES;
    
    [_contentScrollView setContentOffset:CGPointMake(_currentContScrollViewOffSizeWidth + i * _contentScrollView.frame.size.width , 0) animated:YES];
}
//左右滑动contenView的动画
- (void)contenViewRightLeftAnimation:(CGFloat)scrollViewContentOffsizeWidth
{
    UIView * view = [_headMenuScrollView viewWithTag:100];
    UIButton * nextButton = nil;
    if (scrollViewContentOffsizeWidth > _currentContScrollViewOffSizeWidth && _currentSeletedButton.tag-1000 < _headMenuDateArray.count - 1) {
        nextButton = (UIButton *)[_headMenuScrollView viewWithTag:_currentSeletedButton.tag + 1];
    }
    else if (scrollViewContentOffsizeWidth < _currentContScrollViewOffSizeWidth && _currentSeletedButton.tag > 1000){
        nextButton = (UIButton *)[_headMenuScrollView viewWithTag:_currentSeletedButton.tag - 1];
    }
    
    if (nextButton) {
        CGFloat offSizeWidth = _currentSeletedButton.center.x + (scrollViewContentOffsizeWidth - _currentContScrollViewOffSizeWidth)/_contentScrollView.frame.size.width * nextButton.frame.size.width;
        CGFloat contentOffSizeWidth = _currentSeletedButton.center.x + (scrollViewContentOffsizeWidth - _currentContScrollViewOffSizeWidth)/_contentScrollView.frame.size.width * nextButton.frame.size.width - _headMenuScrollView.frame.size.width/2.0;
        if (offSizeWidth > _headMenuScrollView.frame.size.width/2.0 ) {
            
            if (contentOffSizeWidth + _headMenuScrollView.frame.size.width > _headMenuScrollView.contentSize.width) {
                _headMenuScrollView.contentOffset = CGPointMake(_headMenuScrollView.contentSize.width - _headMenuScrollView.frame.size.width, 0);
            }else{
                _headMenuScrollView.contentOffset = CGPointMake(contentOffSizeWidth , 0);
            }
        }else{
            _headMenuScrollView.contentOffset = CGPointMake(contentOffSizeWidth + _headMenuScrollView.frame.size.width/2.0 - offSizeWidth, 0);
        }
        view.center = CGPointMake(offSizeWidth , view.center.y);
        
        CGFloat i = fabs((scrollViewContentOffsizeWidth - _currentContScrollViewOffSizeWidth)/_contentScrollView.frame.size.width);
        
        [_currentSeletedButton setTitleColor:RGB(24 + 76.0 * i, 181 - 81.0 * i, 44 + 56.0 * i) forState:UIControlStateSelected];
        [nextButton setTitleColor:RGB(100 - 76.0 * i, 100 + 81.0 * i, 100 - 44.0 * i) forState:UIControlStateNormal];
    }
    
}


#pragma mark -- scrollView协议

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _contentScrollView) {
        _refusedHeadSrollViewAnimation = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_bottomScrollView.contentOffset.y < -_bottomScrollView.contentInset.top) {
        _bottomScrollView.delegate = nil;
        [UIView animateWithDuration:0.3 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [_bottomScrollView setContentOffset:CGPointMake(0,-_bottomScrollView.contentInset.top)];
        }completion:^(BOOL finished) {
            _bottomScrollView.delegate = self;
        }];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate == NO && _bottomScrollView.contentOffset.y < -_bottomScrollView.contentInset.top) {
        _bottomScrollView.delegate = nil;
        [UIView animateWithDuration:0.3 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [_bottomScrollView setContentOffset:CGPointMake(0,-_bottomScrollView.contentInset.top)];
        }completion:^(BOOL finished) {
            _bottomScrollView.delegate = self;
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _contentScrollView && scrollView.contentOffset.x != _currentContScrollViewOffSizeWidth) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @synchronized(scrollView){
                if (_refusedHeadSrollViewAnimation == NO) {
                    [self contenViewRightLeftAnimation:scrollView.contentOffset.x];
                }
                if (scrollView.contentOffset.x >= _currentContScrollViewOffSizeWidth + _contentScrollView.frame.size.width || scrollView.contentOffset.x <= _currentContScrollViewOffSizeWidth - _contentScrollView.frame.size.width ) {
                    _currentSeletedButton.selected = NO;
                    [_currentSeletedButton setTitleColor:RGB(24, 181, 44) forState:UIControlStateSelected];
                    if (_refusedHeadSrollViewAnimation == NO) {
                        if (scrollView.contentOffset.x > _currentContScrollViewOffSizeWidth && _currentSeletedButton.tag-1000 < _headMenuDateArray.count - 1) {
                            _currentSeletedButton = (UIButton *)[_headMenuScrollView viewWithTag:_currentSeletedButton.tag + 1];
                        }
                        else if (scrollView.contentOffset.x < _currentContScrollViewOffSizeWidth && _currentSeletedButton.tag > 1000){
                            _currentSeletedButton = (UIButton *)[_headMenuScrollView viewWithTag:_currentSeletedButton.tag - 1];
                        }
                    }
                    if (_currentSeletedButton.tag - 1000 > 0 && _currentSeletedButton.tag - 1000 < _headMenuDateArray.count - 1) {
                        [_contentScrollView setContentOffset:CGPointMake(_contentScrollView.frame.size.width , 0)];
                        _currentContScrollViewOffSizeWidth = _contentScrollView.frame.size.width;
                    }else{
                        _currentContScrollViewOffSizeWidth = roundf((scrollView.contentOffset.x/_contentScrollView.frame.size.width)) * _contentScrollView.frame.size.width;
                    }
                    _currentSeletedButton.selected = YES;
                    [_currentSeletedButton setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
                    _currentSeletedHeadScrollViewSubButtonNumberTag = _currentSeletedButton.tag - 1000;
                    [self contentScrollViewArrangementContent];
                }
            }
        });
    }else if (scrollView == self.contentViewCurrentView) {
        //悬浮框
        if (_bottomScrollView.contentOffset.y < self.view.bounds.size.height || scrollView.contentOffset.y < 0) {
            scrollView.delegate = nil;
            _bottomScrollView.delegate = nil;
            CGPoint contentOffsetPoint = _bottomScrollView.contentOffset;
            contentOffsetPoint.y = contentOffsetPoint.y + (scrollView.contentOffset.y < 0 ? scrollView.contentOffset.y / 2.0: scrollView.contentOffset.y);
            scrollView.contentOffset = CGPointMake(0, 0);
            _bottomScrollView.contentOffset = contentOffsetPoint;
            scrollView.delegate = self;
            _bottomScrollView.delegate = self;
            
        }else if (_bottomScrollView.contentOffset.y > self.view.bounds.size.height){
            
            _bottomScrollView.delegate = nil;
            _bottomScrollView.contentOffset = CGPointMake(_bottomScrollView.contentOffset.x, self.view.bounds.size.height);
            _bottomScrollView.delegate = self;
            
        }else{
            CGFloat num = scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentSize.height;
            
            if (num > 0) {
                
            }
            
        }
        
    }
    
}


#pragma mark -- tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title = [[NSString alloc] init];
    NSString *message = [[NSString alloc] init];
    
    NSString *content = [[NSString alloc] init];
    NSString *time = [[NSString alloc] init];
    
    NSString *commentName = [[NSString alloc] init];
    NSString *trend = [[NSString alloc] init];
    
    
    
    if(_currentSeletedHeadScrollViewSubButtonNumberTag == 1){
        
        NSArray *messageData = [MessageViewModel messageListFromPlist];
        NSDictionary *messageDic = messageData[indexPath.row];
        [MessageDetailVM setMessageDic:messageData[indexPath.row]];
        
        NSNumber *type = [messageDic valueForKey:@"type"];
        
        if(type.integerValue == 4){
            ApplyMessageVC *applyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ApplyVC"];
            [self.navigationController pushViewController:applyVC animated:YES];
        }else{
            SystemMessageVC *systemVC = [self.storyboard instantiateViewControllerWithIdentifier:@"systemVC"];
            [self.navigationController pushViewController:systemVC animated:YES];
        }
        
        
        NSLog(@"分析一下现在的数据 %@",[MessageDetailVM getMessageDic]);
        
    }else{
        NSArray *commentData = [MessageViewModel commentListFromPlist];
        commentName = [[[commentData[indexPath.row] valueForKey:@"creator"] valueForKey:@"name"] substringFromIndex:11];
        content = [commentData[indexPath.row] valueForKey:@"content"];
        title = [NSString stringWithFormat:@"%@评论了您的动态",commentName];
        time = [commentData[indexPath.row] valueForKey:@"create_time"];
        message = [NSString stringWithFormat:@"时间:%@\n评论:%@",time,content];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"消息详情确认");
        }];
        [alertController addAction:cancleAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    
    
}




@end
