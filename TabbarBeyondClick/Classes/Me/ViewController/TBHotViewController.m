

//
//  TBHotViewController.m
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/19.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBHotViewController.h"

@interface TBHotViewController ()

@end

@implementation TBHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"A" object:nil];
}

@end
