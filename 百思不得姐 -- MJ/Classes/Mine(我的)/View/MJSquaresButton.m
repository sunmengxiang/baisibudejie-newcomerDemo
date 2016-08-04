//
//  MJSquaresButton.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJSquaresButton.h"

@implementation MJSquaresButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.bounds = CGRectMake(0, 0, self.width * 0.7, self.height * 0.7);
    
    self.imageView.center = CGPointMake(self.width *  0.5, self.height * 0.7 * 0.5);
    
    self.titleLabel.width = self.width;
    
    self.titleLabel.height = self.height - self.imageView.height;
    
    self.titleLabel.x = 0;
    
    self.titleLabel.y = self.imageView.height;
    
}

@end
