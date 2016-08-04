//
//  MJLoginViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJLoginViewController.h"
#import "MJLoginPageViewController.h"
#import "MJTagRecommendController.h"
@interface MJLoginViewController ()

@end

@implementation MJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = MJGloabalBgColor;
    
//    设置导航条内容
    [self setUpNavi];
}


- (void)setUpNavi
{
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self selector:@selector(recommentClick)];
}
#pragma mark - 点击了导航条左侧按钮
- (void)recommentClick
{
    MJTagRecommendController * tagRecommendVc = [[MJTagRecommendController alloc]init];
    
    [self.navigationController pushViewController:tagRecommendVc animated:YES];
}
# pragma mark - 点击了<立即登录注册>按钮
- (IBAction)loginClick
{
    MJLoginPageViewController * loginRegistVc = [[MJLoginPageViewController alloc]init];
    
    [self presentViewController:loginRegistVc animated:YES completion:nil];
}

@end
