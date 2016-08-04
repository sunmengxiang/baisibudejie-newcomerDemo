//
//  UIView+MJframe.h
//  项目--导航栏的设置
//
//  Created by 孙梦翔 on 16/7/5.
//  Copyright © 2016年 孙梦翔. All rights reserved.

//   为了省略繁杂的 frame.size/frame.origin等等重复代码，定义此分类，已在 PCH 文件中导入头文件

#import <UIKit/UIKit.h>

@interface UIView (MJframe)

@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;


@property (nonatomic,assign) CGSize size;
@end
