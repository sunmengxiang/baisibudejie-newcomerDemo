//
//  UIImage+MJCircleImage.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/30.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "UIImage+MJCircleImage.h"

@implementation UIImage (MJCircleImage)

- (UIImage *)circleImage
{
//    开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1);
    
    
//    开启上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ref, rect);
    
    CGContextClip(ref);
    
    [self drawInRect:rect];
    
    UIImage * circleImage = UIGraphicsGetImageFromCurrentImageContext();

//    关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;;
}
@end
