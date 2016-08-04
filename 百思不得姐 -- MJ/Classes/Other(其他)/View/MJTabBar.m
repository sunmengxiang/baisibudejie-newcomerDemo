//
//  MJTabBar.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTabBar.h"
#import "MJPublishViewController.h"


@interface MJTabBar ()

@property (weak , nonatomic) UIButton * publishButton;


@end
@implementation MJTabBar
//tabBarItem 的总数量
static NSInteger tabBarItemCount = 5;

#pragma mark - 在这里初始化定义 tabBar 内部的一次性设置
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        UIButton * publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        
        [publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
//   让发布按钮的 size 同他内部的图片子控件大小一致
        publishBtn.size = publishBtn.currentImage.size;
        
        self.publishButton = publishBtn;
        [self addSubview:publishBtn];
        
    }
    
    return self;
}
#pragma mark - 监听 tabBar 发布按钮的点击
- (void)publishClick
{
    MJPublishViewController * publishVc = [[MJPublishViewController alloc]init];
    
//    在 UIView 内部无法通过通常的 self.navigationController push 方法来跳转控制器，通过找到 keyWindow来 modal 发布控制器
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVc animated:YES completion:nil];
}
#pragma mark - 在这里定义子控件的尺寸和位置
- (void)layoutSubviews
{
    
    [super layoutSubviews];
//    尺寸变量的定义
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnWidth = MJScreenW / tabBarItemCount;
    CGFloat btnHeight = self.bounds.size.height;
    NSUInteger index = 0;
    
    self.publishButton.center = CGPointMake(MJScreenW * 0.5, self.bounds.size.height * 0.5);
    for (UIButton * btn  in self.subviews)
    {
        if ([btn isKindOfClass:[UIControl class]] && !(btn == self.publishButton)) {
            btnX = btnWidth * ((index > 1)? (index + 1):(index));
            
            btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
            
            index ++;
        }
    }
    
}


@end
