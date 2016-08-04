//
//  MJTopicsViewCell.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/29.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJTopics;
@interface MJTopicsViewCell : UITableViewCell

/* 帖子数据 */
@property (strong ,nonatomic)  MJTopics * topics;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (instancetype)topicsViewCell;
@end
