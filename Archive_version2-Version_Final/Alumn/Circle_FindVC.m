//
//  Circle_FindVC.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/30.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "Circle_FindVC.h"

#import "CollectionViewCell_F.h"
#import "CollectionReusableView_F.h"

#import "Section_FModel.h"
#import "Cell_FModel.h"
#import "UIView+SDAutoLayout.h"
#import "MyAlertVC.h"
#import   "UIImageView+WebCache.h"

#define UISCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)



@interface Circle_FindVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView_F;

//下面数组用来存放头部标题；
@property(strong,nonatomic) NSMutableArray *headerArray;
@property (nonatomic,strong) Section_FModel *section;
//里面存放section对象，也就是section模型，模型由SectionModel定义；
@property (nonatomic,strong) NSMutableArray *dataSectionArray;
//里面存放cell对象，也就是cell模型，模型由CellModel定义；
@property (nonatomic,strong) NSMutableArray *dataCellArray;
@property(nonatomic,strong) NSMutableArray *cellImageArr;
@property(nonatomic,strong) NSMutableArray *cellDescArr;
@property(nonatomic,strong) CollectionReusableView_F *reusableView;

@end

@implementation Circle_FindVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //进行CollectionView和Cell的绑定
    [self.collectionView_F registerClass:[CollectionViewCell_F class]  forCellWithReuseIdentifier:@"CollectionCell"];
    self.collectionView_F.backgroundColor = [UIColor clearColor];//背景透明
    //加入头部视图；
    [self.collectionView_F registerClass:[CollectionReusableView_F class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    Section_FModel *sec = [self.dataSectionArray objectAtIndex:section];
    return  sec.cellArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell_F *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    //找到某一个具体的Section；
    Section_FModel *sec = [self.dataSectionArray objectAtIndex:indexPath.section];
    //找到Section中的cell数组中某个具体的cell；
    Cell_FModel *cel = [sec.cellArray objectAtIndex:indexPath.row];
    //取出数据；
   [cell.imageView sd_setImageWithURL:[NSURL URLWithString:cel.cellImage] placeholderImage:[UIImage imageNamed:@"10.jpg"]];
    cell.descLabel.text = cel.cellDesc;
    
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
    return UIEdgeInsetsMake(10,25,25,15);
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.collectionView_F.frame.size.width, 50);
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
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *plistPath1= [paths objectAtIndex:0];
            NSString *plistName =[[NSString alloc] initWithFormat:@"TYPE_%@.plist",self.ID];
            NSString *fileName = [plistPath1 stringByAppendingPathComponent:plistName];
            NSArray *dictArray = [NSArray arrayWithContentsOfFile:fileName];
            //          NSMutableArray *models = [NSMutableArray arrayWithCapacity:[dictArray count]];
            for (NSDictionary *dict in dictArray) {
                Cell_FModel *mod = [Cell_FModel modelWithDict:dict];
                NSLog(@"%@",dict);
                [ _dataCellArray  addObject:mod];
            }
            
            
            
            Section_FModel *sectionModel = [[Section_FModel alloc] init];
            //sectionModel.sectionName = self.headerArray[i];
            //把上面生成的cell数组加入到section数组中；
            sectionModel.cellArray = _dataCellArray;
            //增加一个section；
            [_dataSectionArray addObject:sectionModel];
        }//for;
    }
    return _dataSectionArray;
}





#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //取出是某一个section；
    Section_FModel *sec = [self.dataSectionArray objectAtIndex:indexPath.section];
        NSLog(@"第%ld个section,点击图片%ld",indexPath.section,indexPath.row);
        //MyAlertVC *ContmetViewController =[[MyAlertVC alloc] init];
        //[self.view addSubview:[ContmetViewController init].view];
        _darkview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _darkview.backgroundColor = [UIColor blackColor];
        _darkview.alpha = 0.5;
        _darkview.userInteractionEnabled =YES;
         UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
        [tapGesture setNumberOfTapsRequired:1];
        [_darkview addGestureRecognizer:tapGesture];
        [self.view addSubview:_darkview];
        self.alt = [MyAltview new];
        self.alt.altwidth=280;
      Cell_FModel *getcell= self.dataCellArray[indexPath.row];
    NSString *contentWithBlanck = [[NSString alloc] initWithFormat:@"%@,%@",getcell.content,@"\n"];
    [_alt CreatAlt:nil circleName:getcell.cellDesc altTitle:getcell.creator Content:contentWithBlanck altButton:nil altbtnTcolor:[UIColor blackColor] altselectbtnTcolor:[UIColor whiteColor] icon:getcell.cellImage creator_id:getcell.creator_id circle_ID:getcell.ID  ];
        _alt.sd_layout
        .centerYEqualToView(self.view)
        .centerXEqualToView(self.view);
        [self.view addSubview:_alt.view];
        [Circle_FindVC animationAlert:_alt.view];
        [_alt show];

}





- (void)deleteCellButtonPressed: (id)sender{
    
    CollectionViewCell_F *cell = (CollectionViewCell_F *)[sender superview];//获取cell
    NSIndexPath *indexpath = [self.collectionView_F indexPathForCell:cell];//获取cell对应的indexpath;
    //删除cell；
    Section_FModel *sec = [self.dataSectionArray objectAtIndex:indexpath.section];
    [sec.cellArray removeObjectAtIndex:indexpath.row];
    
    [self.collectionView_F reloadData];
    NSLog(@"删除按钮，section:%ld ,   row: %ld",(long)indexpath.section,(long)indexpath.row);
}
- (IBAction)backItemClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)event:(UITapGestureRecognizer *)gesture
{
    NSLog(@"单机");
    [_alt removeFromSuperview];
    [_alt hide];
    [_darkview removeFromSuperview];
}

+(void) animationAlert:(UIView *)view
{
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 1;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    
    
}
@end


