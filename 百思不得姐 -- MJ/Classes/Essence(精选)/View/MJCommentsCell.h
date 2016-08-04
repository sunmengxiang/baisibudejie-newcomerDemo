//
//  MJCommentsCell.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/1.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJComments;
@interface MJCommentsCell : UITableViewCell

+ (instancetype)commentCell;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) MJComments * comments;

@end
