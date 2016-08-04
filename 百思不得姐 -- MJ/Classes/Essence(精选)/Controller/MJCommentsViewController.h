//
//  MJCommentsViewController.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/1.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJTopics;
@class MJTopicsViewCell;
@interface MJCommentsViewController : UITableViewController

/* 帖子数据 */
@property (strong ,nonatomic)  MJTopics * topics;
/* 帖子 */
@property (strong ,nonatomic)  MJTopicsViewCell * topicsCell;


@end
