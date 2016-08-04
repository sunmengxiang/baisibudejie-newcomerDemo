//
//  MJCategoryCell.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJCategory;


@interface MJCategoryCell : UITableViewCell

/* textButton 的内容 */
@property (strong ,nonatomic)  NSString * title;

+ (instancetype)cellWithTableview:(UITableView *)tableView;

/* category 模型 */
@property (strong ,nonatomic) MJCategory *  category;
@end
