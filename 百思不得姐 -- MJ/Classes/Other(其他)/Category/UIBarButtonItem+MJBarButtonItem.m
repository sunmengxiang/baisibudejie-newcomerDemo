//
//  UIBarButtonItem+MJBarButtonItem.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "UIBarButtonItem+MJBarButtonItem.h"

@implementation UIBarButtonItem (MJBarButtonItem)


+ (instancetype)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highImage target:(id)target selector:(SEL)selector
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    btn.size = btn.currentImage.size;
    
    return [[self alloc] initWithCustomView:btn];
}
@end
