//
//  UIBarButtonItem+MJBarButtonItem.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//  为了方便创建 UIBarButtonItem 按钮，创建 UIBarButtonItem 分类，已在 PCH 文件中导入头文件

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MJBarButtonItem)

+ (instancetype)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highImage target:(id)target selector:(SEL)selector;
@end
