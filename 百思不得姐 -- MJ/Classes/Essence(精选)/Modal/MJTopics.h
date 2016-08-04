//
//  MJTopics.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/29.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJComments;
@interface MJTopics : NSObject
/* id */
@property (strong ,nonatomic) NSString * ID;
/* 帖子type */
@property ( assign ,nonatomic) MJTopicsType  type;
/* name */
@property (strong ,nonatomic) NSString * name;
/* icon URL */
@property (strong ,nonatomic) NSString * profile_image;
/* jie_v */
@property (assign ,nonatomic,getter=isJieVip)BOOL jie_vip;
/* content text */
@property (strong ,nonatomic) NSString * text;
/* 图片宽度 */
@property ( assign ,nonatomic)   NSInteger  width;
/* 图片高度 */
@property ( assign ,nonatomic)   NSInteger  height;

/* 大图片 url*/
@property (strong ,nonatomic)  NSString * imageBig;
/* 中等图片 url*/
@property (strong ,nonatomic)  NSString * imageMid;
/* 小图片 url*/
@property (strong ,nonatomic)  NSString * imageSmall;

/* 声音 URL */
@property (strong ,nonatomic) NSString * voiceuri;

/* 声音时长 */
@property (strong ,nonatomic)  NSString * voicetime;

/* 声音时长 */
@property (strong ,nonatomic) NSString * voicelength;

/* 视频时长 */
@property (assign ,nonatomic)  NSInteger videotime;

/* 视频 url */
@property (strong ,nonatomic) NSString * videouri;

/* 是否 gif 图片 */
@property ( assign ,nonatomic,getter=isGif)   BOOL  gif;

/* 通过时间 */
@property (strong ,nonatomic)  NSString * passtime;
/* ding */
@property ( assign ,nonatomic)  NSInteger  love;
/* cai */
@property ( assign ,nonatomic)  NSInteger  cai;

/* commentCount */
@property ( assign ,nonatomic)  NSInteger  comment;

/* repost */
@property ( assign ,nonatomic)  NSInteger  repost;

/* 播放次数 */
@property ( assign ,nonatomic)   NSInteger  playcount;

/* 热评数据 */
@property (strong ,nonatomic)  MJComments * top_cmt;

//@property (strong ,nonatomic)  NSArray * top_cmt;
/*************** topics 的细节 ***************/

/* cellHeight */
@property ( assign ,nonatomic)  CGFloat cellHeight;

/* 图片frame */
@property ( assign ,nonatomic)  CGRect  pictureFrame;

/* seeBigPicture 按钮是否显示 */
@property ( assign ,nonatomic,getter=isBigPicture) BOOL bigPicture;

/* hotCommentViewFrame */
@property ( assign ,nonatomic)  CGRect  hotCommentViewFrame;

@end
