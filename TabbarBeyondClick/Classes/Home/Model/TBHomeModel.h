//
//  TBHomeModel.h
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/20.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBcreator.h"

@interface TBHomeModel : NSObject
// 城市
@property(nonatomic,copy)NSString *city;
// 距离
@property(nonatomic,copy)NSString *distance;
// 组
@property(nonatomic,copy)NSString *group;
// id
@property(nonatomic,copy)NSString *UId;
// 城市
@property(nonatomic,copy)NSString *landscape;
// 城市
@property(nonatomic,copy)NSString *link;
// 城市
@property(nonatomic,copy)NSString *multi;
// 城市
@property(nonatomic,copy)NSString *name;
// 城市
@property(nonatomic,copy)NSString *optimal;
// 城市
@property(nonatomic,copy)NSString *rotate;
// 城市
@property(nonatomic,copy)NSString *slot;
// 城市
@property(nonatomic,copy)NSString *version;
// 城市
@property(nonatomic,copy)NSString *live_type;
// 城市
@property(nonatomic,copy)NSString *share_addr;
// 城市
@property(nonatomic,copy)NSString *stream_addr;

@property(nonatomic,strong)TBcreator *creator;
@end
