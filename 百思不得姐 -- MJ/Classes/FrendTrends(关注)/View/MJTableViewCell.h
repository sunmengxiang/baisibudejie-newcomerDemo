//
//  MJTableViewCell.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJCategotyList;
@interface MJTableViewCell : UITableViewCell
/* 模型数据 */
@property (strong ,nonatomic)   MJCategotyList * list;

+ (instancetype)cellWithTableview:(UITableView *)tableView;
@end
