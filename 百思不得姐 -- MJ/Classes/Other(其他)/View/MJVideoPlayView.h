//
//  MJVideoPlayView.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/7.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol MJVideoPlayViewDelegate <NSObject>

@optional

- (void)videoPlayViewChangeOrientation:(BOOL)isFull;

@end
@interface MJVideoPlayView : UIView

/* playerItem */
@property (strong ,nonatomic) AVPlayerItem * playerItem;


/* delegate */
@property (strong ,nonatomic) id<MJVideoPlayViewDelegate>  delegate;

+ (instancetype)videoPlayView;

- (void)resetVideoPlay;
- (void)suspendVideoPlay;
@end
