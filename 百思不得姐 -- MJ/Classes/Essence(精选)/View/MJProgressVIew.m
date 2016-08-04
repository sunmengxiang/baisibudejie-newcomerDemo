//
//  MJProgressVIew.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/31.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJProgressVIew.h"

@implementation MJProgressVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        self.roundedCorners = 3;
        self.trackTintColor = [UIColor clearColor];
        self.progressLabel.textColor = [UIColor whiteColor];
        [self.progressLabel.text stringByReplacingOccurrencesOfString:@"-" withString:@""];

    }
    return self;
}

- (void)awakeFromNib
{
    self.roundedCorners = YES;
    self.trackTintColor = [UIColor clearColor];
    self.progressLabel.textColor = [UIColor whiteColor];
    
    

}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString * p = [NSString stringWithFormat:@"%.0f%%",progress*100];
    self.progressLabel.text = [p stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
   
}
@end
