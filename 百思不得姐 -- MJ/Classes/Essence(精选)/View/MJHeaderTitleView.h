//
//  MJHeaderTitleView.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/1.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJHeaderTitleView : UITableViewHeaderFooterView

@property (nonatomic,strong) NSString * title;

+ (instancetype)headerWithTabelView:(UITableView *)tableView;
@end
