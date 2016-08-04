//
//  MJRecommend.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJRecommend : NSObject

/* name */
@property (strong ,nonatomic) NSString * theme_name;
/* imageUrl */
@property (strong ,nonatomic) NSString * image_list;

/* 订阅数量 */
@property (assign ,nonatomic) NSInteger  sub_number;

@end
