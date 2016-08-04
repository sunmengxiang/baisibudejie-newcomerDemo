//
//  MJCommentsViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/1.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJCommentsViewController.h"
#import "MJTopicsViewCell.h"
#import "MJTopics.h"
#import "MJComments.h"
#import "MJCommentUsers.h"
#import "MJCommentsCell.h"
#import "MJHeaderTitleView.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFHTTPSessionManager.h>

@interface MJCommentsViewController ()
@property (nonatomic,strong) MJComments * topCmt;

@property (nonatomic,strong) NSArray * hotComments;

@property (nonatomic,strong) NSMutableArray * latestComments;

@property (nonatomic,assign) NSInteger page;


/* 记录上一个点击的 cell */
@property (strong ,nonatomic) MJCommentsCell * selectCell;
@end

@implementation MJCommentsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //    设置刷新控件
    [self setUpRefresh];
    
//    创建 headerView
    [self setUpHeaderView];
  
//    设置 tableView
    [self setUpTableView];
    
    
}
# pragma  mark - 设置刷新控件
- (void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
// 加载最新数据
- (void)loadNewData
{
    
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary * parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"dataList";
    parms[@"c"] = @"comment";
    parms[@"data_id"] = self.topics.ID;
    parms[@"hot"] = @"1";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        self.hotComments = [MJComments mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        self.latestComments = [MJComments mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.page = 1;
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}
// 加载更多数据
- (void)loadMoreData
{
    
    [self.tableView.mj_header endRefreshing];
    NSInteger page = self.page;
    NSMutableDictionary * parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"dataList";
    parms[@"c"] = @"comment";
    parms[@"data_id"] = self.topics.ID;
    parms[@"page"] = @(page);
    
    MJComments * cmp = [self.latestComments lastObject];
    parms[@"lastcid"] = cmp.ID;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        如果没有评论，就 return
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            
             [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
        
        NSArray * latestComments = [MJComments mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.latestComments addObjectsFromArray:latestComments];
        
        [self.tableView reloadData];
        self.page ++;
//        判断 footer 的状态，若已经没有数据可以加载，就隐藏 footerView 刷新控件
        NSInteger total = [responseObject[@"total"] integerValue];
        if ( self.latestComments.count < total)
        {
            [self.tableView.mj_footer endRefreshing];
        }
        else
        {
            [self.tableView.mj_footer setHidden:YES];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self.tableView.mj_footer endRefreshing];
    }];
}
# pragma mark - 设置 tabelView
- (void)setUpTableView
{
     self.tableView.backgroundColor = MJGloabalBgColor;
     self.title = @"评论";

    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}
#pragma mark - 设置 headerVeiw
- (void)setUpHeaderView
{
    
//    清空热门评论
    if (self.topics.top_cmt != nil)
    {
        self.topCmt = self.topics.top_cmt;
        
        self.topics.top_cmt = nil;
        
        [self.topics setValue:@0 forKey:@"cellHeight"];
     }
        UIView * view = [[UIView alloc]init];
        MJTopicsViewCell * cell = [MJTopicsViewCell topicsViewCell];
        cell.topics = self.topics;
        
        cell.size = CGSizeMake(MJScreenW, self.topics.cellHeight);
        
        view.size = CGSizeMake(MJScreenW, self.topics.cellHeight + MJTopicsCellMargin);
        view.backgroundColor = [UIColor clearColor];
        [view addSubview:cell];
    
    
    self.tableView.tableHeaderView = view;
    
}

- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (MJComments *)commentInIndexPath:(NSIndexPath *)indexPath {
    
    return [self commentsInSection:indexPath.section][indexPath.row];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCmtCount = self.hotComments.count;
    NSInteger lateestCmtCount = self.latestComments.count;

    if (hotCmtCount)
        return 2;
    
    if (lateestCmtCount)
        return 1;
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.hotComments.count)
    {
        if (section == 0)
        {
            return self.hotComments.count;
        }
        else
        {
            return self.latestComments.count;
        }
    }
    else
    {
        return self.latestComments.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MJCommentsCell *cell = [MJCommentsCell cellWithTableView:tableView];
    
    cell.comments = [self commentInIndexPath:indexPath];

    /*
   MJComments * lateCmt = self.latestComments[indexPath.row];
    if (self.hotComments.count)
    {
        if (indexPath.section == 0)
        {
            MJComments * hotCmt = self.hotComments[indexPath.row];
            cell.comments = hotCmt;
        }
        else
        {
            cell.comments = lateCmt;
        }
    }
    else
    {

         cell.comments = lateCmt;
    }
    */
    return cell;
}

// 自定义 headerView 的代码

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MJHeaderTitleView * titleHeaderView = [MJHeaderTitleView headerWithTabelView:tableView];
//    不能在这里设置 title,因为：发现你不调用 titleForHeaderInSection datasource 的代理方法，就不给你进入到这个代理方法！！！
    return titleHeaderView;
}
 

// 设置 header 的文字提示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger hotCmtCount = self.hotComments.count;
    if (section == 0)  return hotCmtCount?@"最热评论":@"最新评论";
    else return @"最新评论";
    
}
// 设置 header 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
// 销毁控制器
- (void)dealloc
{
//    将进入评论控制器时，返回清空的热评数据，并重新计算 cellHeight
    if (self.topCmt != nil)
    {
        self.topics.top_cmt = self.topCmt;
        
        [self.topics setValue:@0 forKey:@"cellHeight"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJCommentsCell * cell = [tableView cellForRowAtIndexPath:indexPath];
     UIMenuController * menu = [UIMenuController sharedMenuController];

    if (!menu.isMenuVisible )
    {
        
        [cell becomeFirstResponder];
        UIMenuItem * ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
         UIMenuItem * report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
         UIMenuItem * comment = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(comment:)];
        
        menu.menuItems = @[ding,report,comment];
        CGRect rect = CGRectMake(0, cell.height * 0.3, cell.width , cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
    else
    {
        [menu setMenuVisible:NO animated:YES];
    }
    
    self.selectCell = cell;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
}
- (void)ding:(UIMenuController *)menu
{
    
}
- (void)report:(UIMenuController *)menu
{
    
}
- (void)comment:(UIMenuController *)menu
{
    
}

@end