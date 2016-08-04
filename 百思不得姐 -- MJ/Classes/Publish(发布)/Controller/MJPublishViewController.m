//
//  MJPublishViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJPublishViewController.h"
#import "MJVerticalButton.h"
#import <POP.h>

@interface MJPublishViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

static CGFloat MJAnimDelayTime = 0.6;
@implementation MJPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MJGloabalBgColor;
    
//    设置 sloganView
    UIImageView *sloganImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganImageView.center = CGPointMake(MJScreenW * 0.5, MJScreenH * 0.2);
    
    [self.view addSubview:sloganImageView];

}
#pragma mark - 在 view load 之后执行弹簧动画
- (void)viewDidAppear:(BOOL)animated
{
    //    设置发布按钮
    [self setUpSpringBtn];
   
}

#pragma mark - 设置弹簧动画，及添加发布按钮内容
- (void)setUpSpringBtn
{
    
    NSArray * btnImageStringArr = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    
    NSArray * btnImageNameArr = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
//    每行的最大按钮数
    NSUInteger maxCols = 3;
//    行数 列数
    NSInteger cols = 0;
    NSInteger rows = 0;

    
    CGFloat btnX = 0;
    CGFloat btnY = MJScreenH * 0.3;
    CGFloat btnWidth = 72;
    CGFloat btnHeight = 100;
   
    //    行间距和列间距
    CGFloat rowsMargin = (MJScreenW - maxCols * btnWidth) / (maxCols + 1);
    CGFloat colsMargin = 25;
    for (int i = 0; i < 6; i ++)
    {
        MJVerticalButton * btn = [MJVerticalButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:btnImageStringArr[i]] forState:UIControlStateNormal];
        [btn setTitle:btnImageNameArr[i] forState:UIControlStateNormal];
        cols = i / maxCols;
        rows = i % maxCols;
        btnX = rows * btnWidth + (rows + 1) * rowsMargin;
        btnY = MJScreenH * 0.3 + cols * btnHeight + cols * colsMargin;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
        POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, -btnHeight, btnWidth, btnHeight)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnWidth, btnHeight)];
        
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        anim.springSpeed = 20;
        anim.springBounciness = 10;
        
        [btn pop_addAnimation:anim forKey:@"btnAppearAnim"];
        
        
        [self.view addSubview:btn];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJAnimDelayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cancelButton.enabled = YES;
    });
    
}
# pragma mark - 在 view 即将 disAppear 时，执行发布的内容按钮逐个的下落动画，动画完成后 dismiss
- (void)viewWillDisappear:(BOOL)animated
{
    
    NSInteger index = 0;
    
    for (UIView * v in self.view.subviews)
    {
        if ( [v isKindOfClass:[MJVerticalButton class]])
        {
            
            POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            
            anim.toValue = [NSValue valueWithCGRect:CGRectMake(v.x, MJScreenH + v.height, v.width, v.height)];
            anim.springSpeed = 5;
            anim.springBounciness = 1;
            anim.beginTime = CACurrentMediaTime() + index * 0.1;
            [v pop_addAnimation:anim forKey:@"btnQuitAnim"];
            
            ++index;
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((MJAnimDelayTime - 0.1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    });
  
}

#pragma mark - 点击了取消按钮
- (IBAction)cancel
{
    self.cancelButton.enabled = NO;
    [self viewWillDisappear:NO];
}


@end
