//
//  MJEssenceViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJEssenceViewController.h"
#import "MJSubTagViewController.h"
#import "MJTopicsViewController.h"

@interface MJEssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIButton * selectButton;
/* titleView 的红色指示器  */
@property (nonatomic,weak) UIImageView  * redView;
/* titleView */
@property (weak ,nonatomic) UIView * titleView;

/* myContentView */
@property (weak ,nonatomic) UIScrollView * myContentView;

@end

@implementation MJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MJGloabalBgColor;
    
    
    //    设置导航条内容
    [self setUpNavi];
    
    //    设置子控制器们
    [self setUpChildView];
  
    //    设置 contentView
    [self setUpContentView];
    
    //    设置 titieView及其内部的按钮等控件
    [self setUpTitleView];
    
}
- (void)setUpContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView * myContentView = [[UIScrollView alloc]init];
    myContentView.contentSize = CGSizeMake(MJScreenW * self.childViewControllers.count, 0);
    myContentView.frame = self.view.bounds;
    self.myContentView = myContentView;
    [self.view insertSubview:myContentView atIndex:0];
    self.myContentView.pagingEnabled = YES;
    self.myContentView.delegate = self;
    
}
- (void)setUpChildView
{
    MJTopicsViewController * allVc = [[MJTopicsViewController alloc]init];
    allVc.title = @"推荐";
    allVc.type = MJTopicsTypeAll;
    [self addChildViewController:allVc];
    
    MJTopicsViewController * voiceVc = [[MJTopicsViewController alloc]init];
    voiceVc.title = @"声音";
    voiceVc.type = MJTopicsTypeVoice;
    [self addChildViewController:voiceVc];
    
    MJTopicsViewController * videoVc = [[MJTopicsViewController alloc]init];
    videoVc.title = @"视频";
    videoVc.type = MJTopicsTypeVideo;
    [self addChildViewController:videoVc];
    
    MJTopicsViewController * pictureVc = [[MJTopicsViewController alloc]init];
    pictureVc.title = @"图片";
    pictureVc.type = MJTopicsTypePicture;
    [self addChildViewController:pictureVc];
    
    MJTopicsViewController * wordVc = [[MJTopicsViewController alloc]init];
    wordVc.title = @"段子";
    wordVc.type = MJTopicsTypeWord;
    [self addChildViewController:wordVc];
    
  
}
#pragma mark - 设置 titieView及其内部的按钮等控件
- (void)setUpTitleView
{
//    设置 titleView
    UIView * titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 64, MJScreenW, MJTopicsTitleViewHeight);
    
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.alpha = 0.6;
    [self.view addSubview:titleView];
    
    //    添加红色下标指示器
    UIImageView * redView = [[UIImageView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    redView.height = 3;
    redView.y = titleView.height - redView.height;
    redView.tag = -1;
    
    self.redView = redView;
    
    
//    添加按钮

//    按钮的尺寸变量
    NSInteger typeCount = 5;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnWidth = MJScreenW / typeCount;
    CGFloat btnHeight = MJTopicsTitleViewHeight;
    for (int i = 0; i < 5; i ++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btnX = i * btnWidth;
        
        btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        [btn setTitle: self.childViewControllers[i].title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [titleView addSubview:btn];
//        默认选中第一个按钮
        if (i == 0)
        {
            [btn.titleLabel sizeToFit];
            btn.enabled = NO;
            self.selectButton = btn;
            self.redView.width = btn.titleLabel.width;
            self.redView.centerX = btn.centerX;
//            加载第一个控制器的 view
            UIViewController * vc = self.childViewControllers[0];
            vc.view.x = 0;
            vc.view.y = 0;
            vc.view.size = self.myContentView.size;
            [self.myContentView addSubview:vc.view];
        }
        
    }
    
    [titleView addSubview:redView];
    
}
- (void)btnClick:(UIButton *)btn
{
    self.selectButton.enabled = YES;
    
    btn.enabled = NO;
    
    self.selectButton = btn;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.redView.width = btn.titleLabel.width;
        self.redView.centerX = btn.centerX;
    }];
    
//    获取 titleView 的偏移量
    CGPoint offset = self.myContentView.contentOffset;
    offset.x = btn.tag * MJScreenW;
    
    [self.myContentView setContentOffset:offset animated:YES];
}
# pragma mark - 设置导航条内容
- (void)setUpNavi
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self selector:@selector(subTagClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}
# pragma mark - 点击导航条左侧按钮触发
- (void)subTagClick
{
    MJSubTagViewController * subTagVc = [[MJSubTagViewController alloc]init];
    
    [self.navigationController pushViewController:subTagVc animated:YES];
}

# pragma mark - <UIScrollViewDelegate>
//拖拽 scrollview 完成后来到这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / MJScreenW ;
    //    根据 index 找到对应的 titleView 内部的按钮
    
    [self btnClick:self.titleView.subviews[index]];
   
}


// titleView 点击完成后来到这个代理方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    在这里加载 offset 对应的控制器的 view，实现懒加载
    NSInteger index = scrollView.contentOffset.x / MJScreenW;
    UIViewController * vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.size = self.myContentView.size;
    
    [self.myContentView addSubview:vc.view];
}
@end
