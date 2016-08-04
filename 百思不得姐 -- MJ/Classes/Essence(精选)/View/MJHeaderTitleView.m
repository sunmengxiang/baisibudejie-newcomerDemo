
//
//  MJHeaderTitleView.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/1.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJHeaderTitleView.h"
@interface MJHeaderTitleView ()

@property (nonatomic,weak) UILabel * titleView;
@end
@implementation MJHeaderTitleView
static NSString * headerID = @"headerView";
+ (instancetype)headerWithTabelView:(UITableView *)tableView
{
    MJHeaderTitleView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    
    if (headerView == nil)
    {
        headerView = [[MJHeaderTitleView alloc]initWithReuseIdentifier:headerID];
    }
    
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = MJGloabalBgColor;
        UILabel * titleView = [[UILabel alloc]init];
        titleView.textColor = [UIColor grayColor];
        titleView.font = [UIFont systemFontOfSize:14];
        titleView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        titleView.textAlignment = NSTextAlignmentLeft;
        self.titleView = titleView;
        [self.contentView addSubview:titleView];

    }
    
    return self;
}

// 发现必须要执行 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 这个 datasource 方法，才会调用viewForHeaderInSection 这个方法，所以 不能通过暴露 title 来设置 header 的内容，只能调用  titleForHeaderInSection

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleView.text = title;
}

@end
