//
//  MJTopicsVideoView.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/30.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJTopics;
@interface MJTopicsVideoView : UIView

/* 帖子数据 */
@property (strong ,nonatomic)  MJTopics * topics;

+ (instancetype)topicsVideoView;
@end
