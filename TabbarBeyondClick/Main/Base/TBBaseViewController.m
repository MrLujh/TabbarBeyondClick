
//
//  TBBaseViewController.m
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/18.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBBaseViewController.h"

@interface TBBaseViewController ()
@property (nonatomic, retain) UIView* overlayView;
@property (nonatomic, retain) UIView* bgview;
@property (nonatomic, retain) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, retain) UIImageView *loadingImageView;
@end

@implementation TBBaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (iOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    self.view.backgroundColor = ViewController_BackGround;
    
    //导航栏 返回 按钮
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if (viewControllers.count > 1){
        
        [self.navigationItem setHidesBackButton:NO animated:NO];
        
        UIBarButtonItem *leftBarButtonItem = [UIFactory createBackBarButtonItemWithTarget:self action:@selector(backAction)];
        
        if (iOS7) {
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = -15;
            self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarButtonItem];
            
        }else{
            
            self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        }
        
        //返回的手势
        UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSweepGesture:)];
        gesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:gesture];
        
        
    }else{
        
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
    }
    
    
}


- (void)backSweepGesture:(UISwipeGestureRecognizer*)gesture{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -
#pragma mark Action

- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setCustomerTitle:(NSString *)title{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
}

@end
