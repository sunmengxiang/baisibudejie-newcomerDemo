//
//  MJSettingViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJSettingViewController.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

@interface MJSettingViewController ()

@end

@implementation MJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = MJGloabalBgColor;
    self.navigationItem.title = @"我的设置";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(35 , 0, 0, 0);
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

static NSString * settingCellID = @"settingCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCellID
        ];
    }
    
    CGFloat MJCaches = [SDImageCache sharedImageCache].getSize / 1024.0 / 1024.0;
    
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%.2fMB)",MJCaches];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"清除完成"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    });
    
    [[SDImageCache sharedImageCache]clearDisk];
}
@end
