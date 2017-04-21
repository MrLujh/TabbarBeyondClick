//
//  TBCollectionViewCell.m
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/20.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBCollectionViewCell.h"

@implementation TBCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetWidth(self.frame)-10)];
        [self addSubview:self.imgView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.frame)-10, 20)];
        self.text.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.text];
        
        }
    return self;
}

-(void)setModel:(TBHomeModel *)model {

    _model = model;
    
    if ([model.creator.portrait rangeOfString:@"http"].location != NSNotFound ) {
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.creator.portrait] placeholderImage:[UIImage imageNamed:@"icon"]];
        
    }else {
    
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",IMAGE_HOST,model.creator.portrait];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    }

    self.text.text = model.distance;

}

@end
