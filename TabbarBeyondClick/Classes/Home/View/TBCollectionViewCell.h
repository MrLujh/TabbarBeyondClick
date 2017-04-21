//
//  TBCollectionViewCell.h
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/20.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBHomeModel.h"
@interface TBCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)TBHomeModel *model;
@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *text;

@end
