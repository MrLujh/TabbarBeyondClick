
//
//  TBHomeViewController.m
//  TabbarBeyondClick
//
//  Created by 卢家浩 on 2017/4/17.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBHomeViewController.h"
#import "TBCollectionViewCell.h"
#import "TBPlayerViewController.h"
#import "TBHomeModel.h"
@interface TBHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,copy)NSMutableArray *data;
@end

@implementation TBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化变量
    [self initVar];
    
    // 初始化CollectionView
    [self setUpCollectionView];
    
    // 网络请求
    [self networkRequestData];
    
}

#pragma mark -初始化变量

- (void)initVar {

    [self setCustomerTitle:@"首页"];
    _data = [NSMutableArray array];

}

#pragma mark -初始化CollectionView

- (void)setUpCollectionView {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.headerReferenceSize = CGSizeMake(KUIScreenWidth, 10);//头部大小
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KUIScreenWidth, KUIScreenHeight -49) collectionViewLayout:flowLayout];
    
    //定义每个UICollectionView 的大小
    flowLayout.itemSize = CGSizeMake((KUIScreenWidth-20)/2, (KUIScreenWidth-20)/2 +20);
    //定义每个UICollectionView 横向的间距
    flowLayout.minimumLineSpacing = 5;
    //定义每个UICollectionView 纵向的间距
    flowLayout.minimumInteritemSpacing = 0;
    //定义每个UICollectionView 的边距距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);//上左下右
    
    //注册cell和ReusableView（相当于头部）
    [_collectionView registerClass:[TBCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //背景颜色
    _collectionView.backgroundColor = [UIColor whiteColor];
    //自适应大小
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.collectionView];

}

#pragma mark -网络请求

- (void)networkRequestData {
    
    NSDictionary * params = @{@"uid":@"85149891",
                              @"latitude":@"40.090562",
                              @"longitude":@"116.413353"
                              };
    
    [CESHttpTool getWithPath:API_NearLocation params:params success:^(id json) {
        
        NSArray *livesArray = json[@"lives"];
        
        for (NSDictionary *dict in livesArray) {
            
            TBHomeModel *model = [TBHomeModel mj_objectWithKeyValues:dict];
            
            [_data addObject:model];
            
        }
        
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark -UICollectionView dataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _data.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    TBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.model = _data[indexPath.row];
    
    return cell;
}


#pragma mark -UICollectionView 被选中时调用的方法

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TBPlayerViewController *VC = [[TBPlayerViewController alloc] init];
    VC.model = _data[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
