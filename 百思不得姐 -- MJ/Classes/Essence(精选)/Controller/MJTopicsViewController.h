//
//  MJTopicsViewController.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/29.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJTopicsViewController : UITableViewController

/* topics type 类型 */
@property (assign ,nonatomic) MJTopicsType type;

/* 新帖还是精华 */
@property (strong ,nonatomic)  NSString * a;

@end
