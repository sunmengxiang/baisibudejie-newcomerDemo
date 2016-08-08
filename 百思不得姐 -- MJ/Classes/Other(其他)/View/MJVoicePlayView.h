//
//  MJVoicePlayView.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/8.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface MJVoicePlayView : UIView
/* playerItem */
@property (strong ,nonatomic) AVPlayerItem * playerItem;

+ (instancetype)voicePlayView;
- (void)resetVoicePlay;
@end
