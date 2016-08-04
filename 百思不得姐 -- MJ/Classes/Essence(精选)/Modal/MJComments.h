//
//  MJComments.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/31.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MJCommentUsers;
@interface MJComments : NSObject

/* ID */
@property (strong ,nonatomic) NSString * ID;
/* 语音时长 */
@property ( assign ,nonatomic)   NSInteger  voicetime;

/* 点赞数量 */
@property ( assign ,nonatomic)   NSInteger  like_count;
/* 语音 url */
@property (strong ,nonatomic) NSString * voiceurl;

/* 评论内容 */
@property (strong ,nonatomic)  NSString * content;

/* 评论的用户 */
@property (strong ,nonatomic)   MJCommentUsers * user;

@end
