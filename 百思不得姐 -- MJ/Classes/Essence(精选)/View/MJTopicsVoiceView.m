//
//  MJTopicsVoiceView.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTopicsVoiceView.h"
#import "MJProgressVIew.h"
#import "MJTopics.h"

#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
@interface MJTopicsVoiceView()<AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet MJProgressVIew *progressView;

@property(nonatomic,strong) AVAudioPlayer * voicePlayer;
@end
@implementation MJTopicsVoiceView


+ (instancetype)topicsVoiceView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
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
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",playMinute,playSecond];
    self.playCountLabel.text = [NSString stringWithFormat:@"播放:%zd次",topics.playcount];
    
}
@end
