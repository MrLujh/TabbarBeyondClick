//
//  TBMeViewController.m
//  TabbarBeyondClick
//
//  Created by 卢家浩 on 2017/4/17.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBMeViewController.h"
#import "TBHotViewController.h"

@interface TBMeViewController ()

@end

@implementation TBMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(B) name:@"A" object:nil];
    
    [self setCustomerTitle:@"我的"];
    

    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 50, 50);
    btn.layer.cornerRadius = 25;
    btn.layer.masksToBounds = YES;
    btn.center = self.view.center;
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor cyanColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {

    
    TBHotViewController *tbHotVC = [[TBHotViewController alloc] init];
    [self.navigationController pushViewController:tbHotVC animated:YES];

}

- (void)B {

    //隐藏
    [self.tabBarController.tabBar hideBadgeOnItemIndex:4];

}

@end
