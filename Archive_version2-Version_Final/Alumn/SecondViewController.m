//
//  SecondViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/23.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//
#import "SecondViewController.h"
#import "CollectionViewCell.h"
#import "AppDelegate.h"
#import "CollectionReusableView.h"

#import "SectionModel.h"
#import "CellModel.h"
#import "UIViewController+PortalTransition.h"
#import "CYViewControllerTransitioningDelegate.h"
#import "User.h"
#import "Circle.h"
#import "Circle+Extension.h"
#import "createaCircleStep1VC.h"
#import   "UIImageView+WebCache.h"
#import "circleDeatilVC.h"
#define UISCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
BOOL flag=false;
NS_ENUM(NSInteger,CellState){
  
  //右上角编辑按钮的两种状态；
  //正常的状态，按钮显示“编辑”;
  NormalState,
  //正在删除时候的状态，按钮显示“完成”；
  DeleteState
  
};


@interface SecondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) CYViewControllerTransitioningDelegate *viewControllerTransitionDelegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,assign) enum CellState;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
//下面数组用来存放头部标题；
@property(strong,nonatomic) NSMutableArray *headerArray;
@property (nonatomic,strong) SectionModel *section;
//里面存放section对象，也就是section模型，模型由SectionModel定义；
@property (nonatomic,strong) NSMutableArray *dataSectionArray;
//里面存放cell对象，也就是cell模型，模型由CellModel定义；
@property (nonatomic,strong) NSMutableArray *dataCellArray;
@property(nonatomic,strong) NSMutableArray *cellImageArr;
@property(nonatomic,strong) NSMutableArray *cellDescArr;
@property(nonatomic,strong) CollectionReusableView *reusableView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
   

  [super viewDidLoad];

  [self.collectionView registerClass:[CollectionViewCell class]  forCellWithReuseIdentifier:@"CollectionCell"];
  self.collectionView.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:248.0f/255.0f alpha:0.5];//背景透明
  //加入头部视图；
  [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
  //一开始是正常状态；
  CellState = NormalState;
  
  [self createLongPressGesture];
  //并给这个头部增加长按事件，要求长按修改头部文字；
  //创建长按手势监听
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(sectionHeaderLongPressed:)];
  longPress.minimumPressDuration = 1.0;
  //将长按手势添加到需要实现长按操作的视图里
  [self.collectionView addGestureRecognizer:longPress];

}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
  SectionModel *sec = [self.dataSectionArray objectAtIndex:section];
  return  sec.cellArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
  //找到某一个具体的Section；
  SectionModel *sec = [self.dataSectionArray objectAtIndex:indexPath.section];
  //找到Section中的cell数组中某个具体的cell；
  CellModel *cel = [sec.cellArray objectAtIndex:indexPath.row];
  //取出数据；
 // cell.imageView.image = [UIImage imageNamed:cel.cellImage];
  [cell.imageView sd_setImageWithURL:[NSURL URLWithString:cel.cellImage] placeholderImage:[UIImage imageNamed:@"创建圈子.png"]];
    cell.descLabel.text = cel.cellDesc;
  //设置删除按钮
  // 点击编辑按钮触发事件
  if(CellState == NormalState){
    //正常情况下，所有删除按钮都隐藏；
    cell.deleteButton.hidden = true;
    self.editButton.titleLabel.text = @"编辑";
  }else{
      self.editButton.titleLabel.text = @"完成";
    //可删除情况下；
    //找到某个具体的section；
    SectionModel *section = self.dataSectionArray[indexPath.section];
    //cell数组中的最后一个是添加按钮，不能删除；
    if (indexPath.row == section.cellArray.count - 1){
      cell.deleteButton.hidden = true;
    }else{
      cell.deleteButton.hidden = false;
    }
  }
  [cell.deleteButton addTarget:self action:@selector(deleteCellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  return cell;
}

//有多少个section；
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  //有多少个一维数组；
  return self.dataSectionArray.count;
}

//加载头部标题；
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
  
  self.reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
  //就打印出当前section的值；
  self.reusableView.title.text = [self.headerArray objectAtIndex:indexPath.section];
  return self.reusableView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  return CGSizeMake((UISCREEN_WIDTH - 40) / 2, (UISCREEN_WIDTH - 40) / 2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
  return UIEdgeInsetsMake(10,15,15,15);
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
  return CGSizeMake(self.collectionView.frame.size.width, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
  return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
  return 0;
}

#pragma mark -- Lazy Load 懒加载
//要添加的图片从这里面选；
//这里进行的是懒加载，要先去判断，没有的话才去进行实例化;

- (NSMutableArray *)dataSectionArray{
  if (!_dataSectionArray){
    //CollectionView有一个Section数组；
    _dataSectionArray = [[NSMutableArray alloc] initWithCapacity:1];//1个；
    for (int i = 0; i < 1; i++) {
      //默认初始有两个Section；
      _dataCellArray = [[NSMutableArray alloc] initWithCapacity:999];//2个；
      //for (int j = 0; j < 6; j++) {
        //默认一个section中有6个cell；
        //初始化每一个cell；
//        CellModel *cellModel = [[CellModel alloc] init];
//        cellModel.cellImage = self.cellImageArr[j];
//        cellModel.cellDesc = self.cellDescArr[j];
//          CellModel *cellModel = [[CellModel alloc] init];
          NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
          NSString *plistPath1= [paths objectAtIndex:0];
          NSString *plistName =[[NSString alloc] initWithFormat:@"MainPageCircle.plist"];
          NSString *fileName = [plistPath1 stringByAppendingPathComponent:plistName];
          NSArray *dictArray = [NSArray arrayWithContentsOfFile:fileName];
//          NSMutableArray *models = [NSMutableArray arrayWithCapacity:[dictArray count]];
        if (dictArray.count!=0)
        { for (NSDictionary *dict in dictArray) {
              CellModel *mod = [CellModel modelWithDict:dict];
              NSLog(@"%@",dict);
                [ _dataCellArray  addObject:mod];
        }}

        //添加到cell数组中；
        //[_dataCellArray addObject:cellModel];
      //}//for;
      //初始化section；
        NSDictionary *finally =[[NSDictionary alloc] initWithObjectsAndKeys:@"添加",@"name",@"add",@"ID",@"创建圈子.png",@"icon_url",nil];
        CellModel *finallyCell = [CellModel modelWithDict:finally];
        [_dataCellArray addObject:finallyCell];
        

      SectionModel *sectionModel = [[SectionModel alloc] init];
      //sectionModel.sectionName = self.headerArray[i];
      //把上面生成的cell数组加入到section数组中；
      sectionModel.cellArray = _dataCellArray;
      //增加一个section；
      [_dataSectionArray addObject:sectionModel];
    }//for;
  }
  return _dataSectionArray;
}

//这里标题的添加也使用懒加载；
- (NSMutableArray *)headerArray{
  
  if (!_headerArray) {
    self.headerArray = [[NSMutableArray alloc] initWithObjects:@"",@"", nil];
  }
  return _headerArray;
}

- (NSMutableArray *)cellImageArr{
  
  if (!_cellImageArr) {
    self.cellImageArr = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"创建圈子",nil];
  }
  return _cellImageArr;
}

- (NSMutableArray *)cellDescArr{
  if (!_cellDescArr) {
    self.cellDescArr = [[NSMutableArray alloc] initWithObjects:@"第0个",@"第1个",@"第2个",@"第3个",@"第4个",@"",nil];
  }
  return _cellDescArr;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
  //取出是某一个section；
  SectionModel *sec = [self.dataSectionArray objectAtIndex:indexPath.section];
  if ((indexPath.row == sec.cellArray.count - 1)) {
    NSLog(@"点击最后一个cell，执行添加操作");
      createaCircleStep1VC *create = [[createaCircleStep1VC alloc]init];
      [self.navigationController pushViewController:create animated:YES];
//    //初始化一个新的cell模型；
//    CellModel *cel = [[CellModel alloc] init];
//    cel.cellImage = @"1";
//    cel.cellDesc = @"再来一个";
//    //获取当前的cell数组；
//    self.dataCellArray = sec.cellArray;
//    //把新创建的cell插入到最后一个之前；
//    [self.dataCellArray insertObject:cel atIndex:self.dataCellArray.count - 1];
//    //更新UI；
//    [self.collectionView reloadData];
  }else{
    NSLog(@"第%ld个section,点击图片%ld",indexPath.section,indexPath.row);
      //在storyborad中使用push方法不拖线跳转
      CellModel *getcell= self.dataCellArray[indexPath.row];
      NSLog(@"adsadasfasfasf xcvadvlpaksvpk%@",getcell.ID);
      [circleDeatilVC setIDinList:getcell.ID];
          NSNumber *i=[[NSNumber alloc]initWithInt:[SecondViewController getPage]];
          NSDictionary *userInfo =[[NSDictionary alloc] initWithObjectsAndKeys:getcell.ID,@"topic_id",@"4",@"count",i,@"page",@"0",@"order", nil];
          NSDictionary *postdic = [[NSDictionary alloc] initWithObjectsAndKeys: [self dictionaryToJson:userInfo],@"info_json",[User getXrsf],@"_xsrf", nil];
          NSLog (@"%@",postdic);
          [Circle circeDynamicListWithParameters:postdic page:i SuccessBlock:^(NSDictionary *dict, BOOL success) {
              UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
              circleDeatilVC *VC = [sb instantiateViewControllerWithIdentifier:@"circleDeatil"];
              VC.backgroundUrl = getcell.cellImage;
              VC.circleNameStr = getcell.cellDesc;
              VC.number=getcell.numbers;
              VC.modalPresentationStyle = UIModalPresentationCustom;
              self.viewControllerTransitionDelegate.viewController = VC;
              //[self presentViewController:newVC animated:YES completion:nil];
              //Or you can call this catogory method
              [self presentPortalTransitionViewController:VC completion:nil];
              //[self.navigationController pushViewController:VC animated:YES];
          } AFNErrorBlock:^(NSError *error) {
              NSLog(@"%@",error);
          }];
      //[SecondViewController setPageAdd1];
      
  }
}

#pragma mark - 添加环境的按钮
- (IBAction)addEnvirnmentClick:(id)sender {
  
  self.dataCellArray = [[NSMutableArray alloc] init];
  for (int i = 0; i < 6; i++) {
    
    CellModel *cell = [[CellModel alloc] init];
    cell.cellDesc = self.cellDescArr[i];
    cell.cellImage = self.cellImageArr[i];
    [self.dataCellArray addObject:cell];
  }
  [self popEnvirnmentNameDialog];
}

#pragma mark - 弹出输入环境名称的提示框
- (void)popEnvirnmentNameDialog{
  
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入Section名称" preferredStyle:UIAlertControllerStyleAlert];
  //以下方法就可以实现在提示框中输入文本；
  [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
    
    SectionModel *sec = [[SectionModel alloc] init];
    sec.sectionName = envirnmentNameTextField.text;
    sec.cellArray = self.dataCellArray;
    //增加一个section，就要加入到dataSectionArray中；
    [self.dataSectionArray addObject:sec];
    [self.headerArray addObject:envirnmentNameTextField.text];
    [self.collectionView reloadData];
    NSLog(@"你输入的文本%@",envirnmentNameTextField.text);
  }]];
  
  [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
  [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.placeholder = @"请输入Section名称";
  }];
  [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)editButtonPressed:(id)sender {
  //从正常状态变为可删除状态；
  if (CellState == NormalState) {
    
    CellState = DeleteState;
    self.editButton.titleLabel.text = @"完成";
    //循环遍历整个CollectionView；
    for(CollectionViewCell *cell in self.collectionView.visibleCells){
      
      NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
      //找到某一个具体的section；
      SectionModel *section = self.dataSectionArray[indexPath.section];
      //除最后一个cell外都显示删除按钮；
      if (indexPath.row != section.cellArray.count - 1){
        [cell.deleteButton setHidden:false];
      }
    }
  }
  else if (CellState == DeleteState){
    
    CellState = NormalState;
    //self.editButton.titleLabel.text = @"编辑";
  }
  [self.collectionView reloadData];
}

- (void)deleteCellButtonPressed: (id)sender{

  CollectionViewCell *cell = (CollectionViewCell *)[sender superview];//获取cell
  NSIndexPath *indexpath = [self.collectionView indexPathForCell:cell];//获取cell对应的indexpath;
  //删除cell；
  SectionModel *sec = [self.dataSectionArray objectAtIndex:indexpath.section];
  [sec.cellArray removeObjectAtIndex:indexpath.row];
  
  [self.collectionView reloadData];
  NSLog(@"删除按钮，section:%ld ,   row: %ld",(long)indexpath.section,(long)indexpath.row);
}

#pragma mark - 创建长按手势
- (void)createLongPressGesture{
  //创建长按手势监听
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(cellLongPressed:)];
  longPress.minimumPressDuration = 1.0;
  //将长按手势添加到需要实现长按操作的视图里
  [self.collectionView addGestureRecognizer:longPress];
}

#pragma mark - cell的长按处理事件
- (void) cellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {

  CGPoint pointTouch = [gestureRecognizer locationInView:self.collectionView];
  if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
    NSLog(@"长按手势开始");
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointTouch];
    if (indexPath == nil) {
      NSLog(@"空");
    }else{

      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入修改后的描述文字" preferredStyle:UIAlertControllerStyleAlert];
      //以下方法就可以实现在提示框中输入文本；
      [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *cellDescTextField = alertController.textFields.firstObject;
        
        NSString *cellDesc = cellDescTextField.text;
        NSLog(@"输入的文字是：%@",cellDesc);
        //找到当前操作的section；
        SectionModel *section = [self.dataSectionArray objectAtIndex:indexPath.section];
        //找到当前操作的cell；
        CellModel *cell = [section.cellArray objectAtIndex:indexPath.row];
        //修改该cell的描述文字；
        cell.cellDesc = cellDesc;
        
        //确定当前的cell数组；
        self.dataCellArray = section.cellArray;
        //替换cell数组中的内容；
        [self.dataCellArray replaceObjectAtIndex:indexPath.row withObject:cell];
        //更新界面；
        [self.collectionView reloadData];
      }]];
      
      [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
      [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入Section名称";
      }];
      [self presentViewController:alertController animated:true completion:nil];
      NSLog(@"Section = %ld,Row = %ld",(long)indexPath.section,(long)indexPath.row);
    }
  }
  if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
    NSLog(@"长按手势改变，发生长按拖拽动作执行该方法");
  }
  if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
    NSLog(@"长按手势结束");
  }
}

#pragma mark - sectionHeader的长按处理事件
- (void) sectionHeaderLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer{
    
      CGPoint pointTouch = [gestureRecognizer locationInView:self.collectionView];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
         NSLog(@"11111111");
        if(CellState ==NormalState)
        {
        //循环遍历整个CollectionView；
        for(CollectionViewCell *cell in self.collectionView.visibleCells){
            
            NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
            //找到某一个具体的section；
            SectionModel *section = self.dataSectionArray[indexPath.section];
            //除最后一个cell外都显示删除按钮；
            if (indexPath.row != section.cellArray.count - 1){
                [cell.deleteButton setHidden:false];
            }
        }
        }
        if(CellState==DeleteState)
        {
            //循环遍历整个CollectionView；
            for(CollectionViewCell *cell in self.collectionView.visibleCells){
                
                NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
                //找到某一个具体的section；
                SectionModel *section = self.dataSectionArray[indexPath.section];
                //除最后一个cell外都显示删除按钮；
                if (indexPath.row != section.cellArray.count - 1){
                    [cell.deleteButton setHidden:true];}
          }
        }
  if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
      
      }
    }
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+(int) getPage
{
    extern int page;
    return page;
}
+(void) setPage: (int)num
{
    page = num;
}

+(void) setPageAdd1
{
    page++;
}

@end
