//
//  MJTagRecommendController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTagRecommendController.h"

#import "MJCategory.h"
#import "MJCategotyList.h"
#import "MJTableViewCell.h"
#import "MJCategoryCell.h"
#import <MJExtension.h>
#import <AFHTTPSessionManager.h>
#import <MJRefresh.h>


@interface MJTagRecommendController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userListTableView;
/* category数组 */
@property (strong ,nonatomic)  NSArray  * categoryArr;


/* 管理 manag */
@property (strong ,nonatomic) AFHTTPSessionManager * manager;

/*  */
@property (strong ,nonatomic) NSMutableDictionary * parms;
@end

@implementation MJTagRecommendController

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    设置 tableView
    [self setUpTableView];
    //    设置右侧的刷新控件
    [self setUpRefresh];
    //    加载数据
    [self loadCategoryData];
}

- (void)setUpTableView
{
    self.view.backgroundColor = MJGloabalBgColor;
    self.title = @"推荐关注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    
    self.userListTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.userListTableView.backgroundColor = MJGloabalBgColor;
    self.categoryTableView.backgroundColor = MJGloabalBgColor;
    self.categoryTableView.rowHeight = 44;
    self.userListTableView.rowHeight = 70;

}
- (void)loadCategoryData
{

    NSMutableDictionary * parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"category";
    parms[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.categoryArr = [MJCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        [self.categoryTableView reloadData];
        
//        默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [self.userListTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)setUpRefresh
{
    self.userListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadListNewData)];
    
    self.userListTableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.userListTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadListMoreData)];
    
}
- (void)loadListNewData
{
   
    MJCategory * ca = self.categoryArr[self.categoryTableView.indexPathForSelectedRow.row];
    ca.currentPage = 1;
     NSString * categoryID = ca.ID;
    NSMutableDictionary * parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"list";
    parms[@"c"] = @"subscribe";
    parms[@"category_id"] = categoryID;
    parms[@"page"] = @(ca.currentPage);
    self.parms = parms;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        [self.userListTableView.mj_header endRefreshing];
        
        NSArray * list = [MJCategotyList mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        ca.total = [responseObject[@"total"] integerValue];
        
        
        [ca.list removeAllObjects];
        
        [ca.list addObjectsFromArray:list];
        
         if (self.parms != parms) return ;
        
        [self.userListTableView reloadData];
        
        [self checkFooterStatus];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)loadListMoreData
{
    
    [self.userListTableView.mj_header endRefreshing];
    
    MJCategory * ca = self.categoryArr[self.categoryTableView.indexPathForSelectedRow.row];
     NSString * categoryID = ca.ID;
    NSMutableDictionary * parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"list";
    parms[@"c"] = @"subscribe";
    parms[@"category_id"] = categoryID;
    parms[@"page"] = @(++ca.currentPage);
    self.parms = parms;
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * list = [MJCategotyList mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        if (self.parms != parms) return ;
        
        [ca.list addObjectsFromArray:list];
        
        [self checkFooterStatus];
        
        [self.userListTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)checkFooterStatus
{
    MJCategory * ca = self.categoryArr[self.categoryTableView.indexPathForSelectedRow.row];
    
    self.userListTableView.mj_footer.hidden = (ca.list.count == 0);
    
    if (ca.list.count == ca.total)
    {
          [self.userListTableView.mj_footer endRefreshingWithNoMoreData];
    }
    else
    {
        [self.userListTableView.mj_footer endRefreshing];
    }
}
#pragma mark - <UITableViewDataSoure>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView)

        return self.categoryArr.count;

        [self checkFooterStatus];
        
        return [self.categoryArr[self.categoryTableView.indexPathForSelectedRow.row] list].count;

}

static NSString * categoryID = @"categoryCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView)
    {
        MJCategoryCell * cell = [MJCategoryCell cellWithTableview:tableView];
        
        MJCategory * category = self.categoryArr[indexPath.row];
        
        cell.category = category;

        return cell;
    }
    
    else
    {
        MJTableViewCell * cell = [MJTableViewCell cellWithTableview:tableView];
        
        MJCategory * ca = self.categoryArr[self.categoryTableView.indexPathForSelectedRow.row];
        MJCategotyList * list = ca.list[indexPath.row];
        cell.list = list;
        
        return cell;
    }
}
#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.userListTableView.mj_footer endRefreshing];
    [self.userListTableView.mj_header endRefreshing];
    if (tableView == self.categoryTableView)
    {
        MJCategory * ca = self.categoryArr[indexPath.row];
        if (ca.list.count)
        {
            [self.userListTableView reloadData];
        }
        else
        {
            [self.userListTableView reloadData];
            
            [self.userListTableView.mj_header beginRefreshing];
        }
        
    }

}

@end
