//
//  TBLiveChatViewController.m
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/20.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBLiveChatViewController.h"

@interface TBLiveChatViewController ()
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation TBLiveChatViewController

-(void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.cornerRadius = 15;
    self.headImageView.layer.masksToBounds = YES;

}

-(void)setModel:(TBHomeModel *)model {

    _model = model;
    
    if ([model.creator.portrait rangeOfString:@"http"].location != NSNotFound ) {
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.creator.portrait] placeholderImage:[UIImage imageNamed:@"icon"]];
        
    }else {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",IMAGE_HOST,model.creator.portrait];
         [self.headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"icon"]];
        
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self initTimer];
    
}

- (void)initTimer {
    
    //初始化心形动画
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        
        [self showMoreLoveAnimateFromView:self.shareBtn addToView:self.view];
    });
    dispatch_resume(self.timer);
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //
    [self showMoreLoveAnimateFromView:self.shareBtn addToView:self.view];
    
}

- (void)showMoreLoveAnimateFromView:(UIView *)fromView addToView:(UIView *)addToView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    CGRect loveFrame = [fromView convertRect:fromView.frame toView:addToView];
    CGPoint position = CGPointMake(fromView.layer.position.x, loveFrame.origin.y - 30);
    imageView.layer.position = position;
    NSArray *imgArr = @[@"heart_1",@"heart_2",@"heart_3",@"heart_4",@"heart_5",@"heart_1"];
    NSInteger img = arc4random()%6;
    imageView.image = [UIImage imageNamed:imgArr[img]];
    [addToView addSubview:imageView];
    
    imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    CGFloat duration = 3 + arc4random()%5;
    CAKeyframeAnimation *positionAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimate.repeatCount = 1;
    positionAnimate.duration = duration;
    positionAnimate.fillMode = kCAFillModeForwards;
    positionAnimate.removedOnCompletion = NO;
    
    UIBezierPath *sPath = [UIBezierPath bezierPath];
    [sPath moveToPoint:position];
    CGFloat sign = arc4random()%2 == 1 ? 1 : -1;
    CGFloat controlPointValue = (arc4random()%50 + arc4random()%100) * sign;
    [sPath addCurveToPoint:CGPointMake(position.x, position.y - 300) controlPoint1:CGPointMake(position.x - controlPointValue, position.y - 150) controlPoint2:CGPointMake(position.x + controlPointValue, position.y - 150)];
    positionAnimate.path = sPath.CGPath;
    [imageView.layer addAnimation:positionAnimate forKey:@"heartAnimated"];
    
    
    [UIView animateWithDuration:duration animations:^{
        imageView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

@end
