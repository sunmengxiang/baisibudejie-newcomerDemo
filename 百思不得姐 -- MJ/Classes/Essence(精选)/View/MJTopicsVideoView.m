//
//  MJTopicsVideoView.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/30.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTopicsVideoView.h"
#import "MJTopics.h"
#import "MJProgressVIew.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
@interface MJTopicsVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLable;

@property (weak, nonatomic) IBOutlet MJProgressVIew *progressView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (nonatomic,strong) AVPlayer * player;
/* playeritem */
@property (strong ,nonatomic) AVPlayerItem * playerItem;
/* playerLayer */
@property (strong ,nonatomic) AVPlayerLayer * playerLayer;
@end

@implementation MJTopicsVideoView


- (AVPlayer *)player
{
    if (_player == nil)
    {
        _player = [[AVPlayer alloc]init];
    }
    return _player;
}

+ (instancetype)topicsVideoView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    [self setUpVideoPlayer];
}
- (IBAction)playClick
{
    [self.player play];
}
- (void)setUpVideoPlayer
{
    NSURL * videoUrl = [NSURL URLWithString:self.topics.videouri];
    
    self.playerItem = [[AVPlayerItem alloc]initWithURL:videoUrl];
    
    self.player = [self.player initWithPlayerItem:self.playerItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
}

- (void)setTopics:(MJTopics *)topics
{
    _topics = topics;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:topics.imageBig] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = receivedSize *1.0 / expectedSize *1.0;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.2f",progress];
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    NSInteger playMinute = topics.videotime / 60;
    NSInteger playSecond = topics.videotime % 60;
    self.playTimeLable.text = [NSString stringWithFormat:@"%02zd:%02zd",playMinute,playSecond];
    self.playCountLabel.text = [NSString stringWithFormat:@"播放:%zd次",topics.playcount];
    
}
@end
