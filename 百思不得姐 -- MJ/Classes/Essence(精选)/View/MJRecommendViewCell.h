//
//  MJRecommendViewCell.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJRecommend;
@interface MJRecommendViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/* 模型 */
@property (strong ,nonatomic)  MJRecommend * recommend;
@end
