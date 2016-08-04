//
//  UIImageView+MJCircleImageView.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/30.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "UIImageView+MJCircleImageView.h"
#import <UIImageView+WebCache.h>


@implementation UIImageView (MJCircleImageView)


- (void)circleImageViewWithUrl:(NSString *)image
{
    [self sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = [self.image circleImage];
    }];
    
    
    
}
@end
