//
//  MJCommentUsers.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/31.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJCommentUsers : NSObject

/* 是否 VIP */
@property ( assign ,nonatomic)  BOOL  is_vip;

/* 名字 */
@property (strong ,nonatomic)  NSString * username;

/* 点赞数量 */
@property ( assign ,nonatomic)   NSInteger  total_cmt_like_count;

/* 性别 */
@property ( strong ,nonatomic)   NSString *  sex;
/* 头像 */
@property (strong,nonatomic) NSString * profile_image;

@end
