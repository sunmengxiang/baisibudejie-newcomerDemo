//
//  MJTabBarViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTabBarViewController.h"
#import "MJEssenceViewController.h"
#import "MJLatestViewController.h"
#import "MJPublishViewController.h"
#import "MJLoginViewController.h"
#import "MJMineTableViewController.h"
#import "MJNavigationController.h"


#import "MJTabBar.h"

@interface MJTabBarViewController ()

@end

@implementation MJTabBarViewController

+ (void)initialize
{
    NSMutableDictionary * attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary * selectAttr = [NSMutableDictionary dictionary];
    selectAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    
//    拿到所有的 tabBar
    UITabBarItem * tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectAttr forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    设置子控制器
    [self setUpChildViewControllers];
    
//    设置 TabBar
    [self setUpTabBar];
    
}


- (void)setUpChildViewControllers
{
    //    设置 精选 控制器
    MJEssenceViewController * essenVc = [[MJEssenceViewController alloc]init];
    
    [self setOneChildViewController:essenVc tabBarImage:[UIImage imageNamed:@"tabBar_essence_icon"] selectTabBarImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精选"];
    
    //    设置 最近 控制器
    MJLatestViewController * laVc = [[MJLatestViewController alloc]init];
    
    [self setOneChildViewController:laVc tabBarImage:[UIImage imageNamed:@"tabBar_new_icon"] selectTabBarImage:[UIImage imageNamed:@"tabBar_new_click_icon"] title:@"最近"];
    
    //    设置 关注 控制器
    MJLoginViewController * loginVc = [[MJLoginViewController alloc]init];
    
    [self setOneChildViewController:loginVc tabBarImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectTabBarImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] title:@"关注"];
    
    //    设置 我的 控制器
    MJMineTableViewController * mineVc = [[MJMineTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    [self setOneChildViewController:mineVc tabBarImage:[UIImage imageNamed:@"tabBar_me_icon"] selectTabBarImage:[UIImage imageNamed:@"tabBar_me_click_icon"] title:@"我的"];
    
}


- (void)setOneChildViewController:(UIViewController *)vc tabBarImage:(UIImage*)image selectTabBarImage:(UIImage *)selectImage title:(NSString *)title
{
    
//    设置 tabBar 的图片及文字
    vc.tabBarItem.title = title;
    vc.navigationItem.title = title;
    [vc.tabBarItem setImage:image];
    [vc.tabBarItem setSelectedImage:selectImage];
    
//    设置 tabBar 子控制器的导航控制器
    MJNavigationController * navi = [[MJNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:navi];
}

- (void)setUpTabBar
{
    [self setValue:[[MJTabBar alloc] init] forKeyPath:@"tabBar"];
    
}

@end
