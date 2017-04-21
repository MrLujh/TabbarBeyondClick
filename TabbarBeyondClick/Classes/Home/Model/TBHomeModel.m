//
//  TBHomeModel.m
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/20.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBHomeModel.h"

@implementation TBHomeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"UId" : @"id",
             
             };
}


@end
