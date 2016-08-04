//
//  MJMineTableViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJMineTableViewController.h"
#import "MJSettingViewController.h"
#import "MJLoginPageViewController.h"
#import "MJSquares.h"
#import "MJSquaresButton.h"
#import "MJSquaresWebController.h"
#import <MJExtension.h>
#import <AFHTTPSessionManager.h>
#import <UIButton+WebCache.h>

@interface MJMineTableViewController ()
@property (nonatomic,strong) NSArray * squaresArr;

/* 存储 不重复name 的key 字典 */
@property (strong ,nonatomic)  NSMutableDictionary * dic;

/* 存储 key 的数组 */
@property (strong ,nonatomic)  NSMutableArray * keyArr;
@end

@implementation MJMineTableViewController


- (NSMutableArray *)keyArr
{
    if (_keyArr == nil)
    {
        _keyArr = [NSMutableArray array];
    }
    
    return _keyArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    设置导航条内容
    [self setUpNavi];
    
//    设置 tableView
    [self setTableView];
    
//    加载方块数据
    [self loadSquaresData];
    

}

- (void)setUpNavi
{
//    导航条 setting 按钮
    UIBarButtonItem * settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self selector:@selector(mineSettingClick)];
    
//    导航条 背景切换 按钮
    UIBarButtonItem * moonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] highlightImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self selector:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}

- (void)setTableView
{
    self.tableView.backgroundColor = MJGloabalBgColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
}
- (void)loadSquaresData
{
    NSMutableDictionary * parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"square";
    parms[@"c"] = @"topic";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.squaresArr = [MJSquares mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
//        为了拿掉返回数据中的脏数据，对数据重新进行挑选，将重复的数据，清除，所以执行以下方法
        
        for (MJSquares * squares in self.squaresArr)
        {
            [dic setValue:squares forKeyPath:squares.name];
        }
        
        self.dic = dic;
        //    遍历 dic，拿到 key的数组
        NSEnumerator * keyEnum = [self.dic keyEnumerator];
        
        
        for (NSString * key in keyEnum)
        {
            [self.keyArr addObject:key];
        }
        
        [self setUpBlocks];
    } failure:nil];
    

}
- (void)setUpBlocks
{
    UIScrollView * footView = [[UIScrollView alloc]init];
    
    footView.pagingEnabled = YES;
    
    footView.backgroundColor = [UIColor whiteColor];
    
//    设置按钮
//    按钮的尺寸变量
    NSInteger colsMax = 5;
    CGFloat btnW = MJScreenW / colsMax;
    CGFloat btnH = btnW;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
//    行数和列数
    NSInteger cols = 0;
    NSInteger rows = 0;
    
    NSInteger page = 0;
    
    MJSquares * squares = [[MJSquares alloc]init];
    for (int i = 0; i < self.dic.count; i ++)
    {
        squares = self.dic[self.keyArr[i]];
        MJSquaresButton * btn = [MJSquaresButton buttonWithType:UIButtonTypeCustom];
       
        page = i / (colsMax * 2) + (i % (colsMax * 2) > 0);
        
        if (page == 0)
        {
            page = 1;
        }
        if (i < 10)
        {
            cols = i  / colsMax;
            rows = i  % colsMax;
        }
        else if(i < 20)
        {
            cols = (i - 10) / colsMax;
            rows = (i - 10) % colsMax;
        }
       
        else if (i < 30)
        {
            cols = (i - 20) / colsMax;
            rows = (i - 20) % colsMax;
        }
        
        if (i == 10)
        {
            page = 2;
        }
        else if (i == 20)
        {
            page = 3;
        }
        
        btnX = rows * btnW + (page - 1) * MJScreenW;
        btnY = cols * btnH;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);

        
        [btn setTitle:squares.name forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:squares.icon] forState:UIControlStateNormal];
        btn.url = squares.url;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:btn];
    }
    
//    footView 的页码
   NSInteger totalPage = self.dic.count / (colsMax * 2) + (self.dic.count % (colsMax * 2) > 0);
   footView.frame = CGRectMake(0, 60, MJScreenW, MJScreenW / colsMax * 2 + MJTopicsCellMargin);
    footView.showsHorizontalScrollIndicator = YES;
    footView.contentSize = CGSizeMake(MJScreenW * totalPage, 0);
    self.tableView.tableFooterView = footView;
}

- (void)btnClick:(MJSquaresButton *)btn
{
    MJSquaresWebController * squaresWebVc = [[MJSquaresWebController alloc]init];
    squaresWebVc.url = btn.url;
    [self.navigationController pushViewController:squaresWebVc animated:YES];
}

- (void)mineSettingClick
{
    MJSettingViewController * settingVc = [[MJSettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:settingVc animated:YES];
}
//暂时未做
- (void)moonClick
{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

static NSString * mineCellID = @"mineCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineCellID ];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellID];
    }
    
    cell.imageView.image = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [cell.imageView setBounds:CGRectMake(0, 0, cell.imageView.width, cell.imageView.height * 0.8)];
    cell.textLabel.text = @"登录/注册";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJLoginPageViewController * loginPageVc = [[MJLoginPageViewController alloc]init];
    
    [self presentViewController:loginPageVc animated:YES completion:nil];
}
@end