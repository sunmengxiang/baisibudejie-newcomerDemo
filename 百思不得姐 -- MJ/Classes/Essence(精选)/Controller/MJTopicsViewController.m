//
//  MJTopicsViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/29.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTopicsViewController.h"
#import "MJTopics.h"
#import "MJTopicsViewCell.h"
#import "MJVideoPlayView.h"
#import "MJTopicsVideoView.h"
#import "MJFullViewController.h"
#import "MJCommentsViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFHTTPSessionManager.h>

@interface MJTopicsViewController ()
/* 加载下一页需要 */
@property (nonatomic , strong) NSString * maxtime;
/* 当前 页码 */
@property (nonatomic,assign) NSInteger page;

/* 模型数据 */
@property (strong ,nonatomic)  NSMutableArray * topicsArr;

/* 请求参数 */
@property (strong ,nonatomic)  NSMutableDictionary * parms;

@end

@implementation MJTopicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置 tableView
    [self setUpTableView];
    //    设置刷新控件
    [self setUpRefresh];
}
// 增加这个 getter 方法是为了能成为一个基类:“精选”和“最近”都可以 get 的方法
- (NSString *)a
{
    return [self.parentViewController.navigationItem.title isEqualToString:@"精选"]?@"list":@"newlist";
}
static NSString *topicsCellID = @"topicsCell";
- (void)setUpTableView
{
    
    self.tableView.backgroundColor = MJGloabalBgColor;
    CGFloat topMargin = MJTopicsTitleViewY + MJTopicsTitleViewHeight;
    CGFloat bottomMargin = self.tabBarController.tabBar.height;
    
    self.tableView.contentInset = UIEdgeInsetsMake(topMargin , 0, bottomMargin, 0);
    
    //    设置滑动指示条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MJTopicsViewCell class]) bundle: [NSBundle mainBundle]] forCellReuseIdentifier:topicsCellID];
}
- (void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.tableView.mj_header beginRefreshing];
//    刷新完成后，header 刷新控件自动改变 透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)loadNewData
{
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary * parms = [NSMutableDictionary dictionary];
    parms[@"a"] = self.a;
    parms[@"c"] = @"data";
    parms[@"type"] = @(self.type);
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        self.topicsArr = [MJTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//         maxtime 这个参数是加载下一页数据时，需要的数据
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        //    清空页码
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)loadMoreData
{
    
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary * parms = [NSMutableDictionary dictionary];
    parms[@"a"] = self.a;
    parms[@"c"] = @"data";
    parms[@"type"] = @(self.type);
    parms[@"maxtime"] = self.maxtime;
    parms[@"page"] = @(++self.page);
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * array = [MJTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.page = [responseObject[@"info"][@"page"] integerValue];
        [self.topicsArr addObjectsFromArray:array];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topicsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJTopicsViewCell *cell = [MJTopicsViewCell cellWithTableView:tableView];
    
    cell.topics = self.topicsArr[indexPath.row];
    
    [cell layoutIfNeeded];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MJTopics * topics = self.topicsArr[indexPath.row];

    
    return topics.cellHeight;
}


#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJCommentsViewController * commentVc = [[MJCommentsViewController alloc]initWithStyle:UITableViewStyleGrouped];
  
    commentVc.topics = self.topicsArr[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}






@end
