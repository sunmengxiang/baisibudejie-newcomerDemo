//
//  MJTopicsVoiceView.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJTopics;
@class MJVideoPlayView;
@interface MJTopicsVoiceView : UIView
/* 帖子数据 */
@property (strong ,nonatomic)  MJTopics * topics;
@property(weak,nonatomic) MJVideoPlayView * videoView;
+ (instancetype)topicsVoiceView;
- (void)voiceResetImage;
@end
