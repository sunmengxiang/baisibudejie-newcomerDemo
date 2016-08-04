//
//  MJSubTagViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJSubTagViewController.h"
#import "MJRecommend.h"
#import "MJRecommendViewCell.h"
#import <AFHTTPSessionManager.h>
#import <MJExtension.h>
//#import <MJRefresh.h>


@interface MJSubTagViewController ()

//模型数组
@property (nonatomic,strong) NSArray * recomArr;
@end

@implementation MJSubTagViewController

static NSString * recommendCellID = @"recommendCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = MJGloabalBgColor;

    //加载数据
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary * parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"tag_recommend";
    parms[@"action"] = @"sub";
    parms[@"c"] = @"topic";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * arr = [MJRecommend mj_objectArrayWithKeyValuesArray:responseObject];
        
        self.recomArr = arr;
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.recomArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJRecommendViewCell * cell = [MJRecommendViewCell cellWithTableView:tableView];
    cell.recommend = self.recomArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
@end
