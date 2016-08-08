//
//  MJVoicePlayView.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/8.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJVoicePlayView.h"
@interface MJVoicePlayView ()
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;

@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/* player */
@property (weak ,nonatomic) AVPlayer * player;

/* playerLayer */
@property (strong ,nonatomic) AVPlayerLayer * playerLayer;

/* 定时器 */
@property (strong ,nonatomic)  NSTimer * timer;
@end

@implementation MJVoicePlayView
- (void)awakeFromNib
{
    //    设置 slider 的滑动样式
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    
    [self.timeSlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    
    [self.timeSlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];

    AVPlayer * player = [[AVPlayer alloc]init];
    self.player = player;
    
    self.playOrPauseButton.selected = YES;
    AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    self.playerLayer = playerLayer;
    
    [self addTime];
    
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem
{
    _playerItem = playerItem;
    
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    self.timeSlider.value = 0.0;
    [self.player play];
}

+ (instancetype)voicePlayView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (void)addTime
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
}
- (void)removeTime
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)progressChange
{
    CGFloat currentTime = CMTimeGetSeconds(self.player.currentTime);
    
    CGFloat durationTime = CMTimeGetSeconds(self.player.currentItem.duration);
    
    CGFloat sliderValue = currentTime / durationTime;
    //    秒转为 分钟 和 秒
    NSInteger cMin = currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    
    NSInteger dMin = durationTime / 60;
    NSInteger dSec = (NSInteger)durationTime % 60;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd/%02zd:%02zd",cMin,cSec,dMin,dSec];
    
    [self.timeSlider setValue:sliderValue animated:NO];
}
#pragma mark -  IBAction子控件们点击所触发的方法
// 暂停、播放按钮
- (IBAction)playOrPauseClick:(UIButton *)sender
{
    self.playOrPauseButton.selected = !self.playOrPauseButton.selected;
    
    if (self.playOrPauseButton.selected)
    {
        [self.player play];
        [self addTime];
    }
    else
    {
        [self.player pause];
        [self removeTime];
    }
}
// 刚按下 slider 滑动条
- (IBAction)sliderTouchStart:(UISlider *)sender
{
    [self removeTime];
}
// 结束按压 slider 滑动条事件后，在这里更新 timeLabel 的播放时间显示
- (IBAction)slderTouchEndWithLabelChange:(UISlider *)sender
{
    CGFloat durationTime = CMTimeGetSeconds(self.player.currentItem.duration);
    
    CGFloat currentSliderTime = durationTime * self.timeSlider.value;
    
    //    秒转为 分钟 和 秒
    NSInteger cMin = currentSliderTime / 60;
    NSInteger cSec = (NSInteger)currentSliderTime % 60;
    
    NSInteger dMin = durationTime / 60;
    NSInteger dSec = (NSInteger)durationTime % 60;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd/%02zd:%02zd",cMin,cSec,dMin,dSec];
}
// 结束按压 slider 滑动条事件后，在这里更新播放器的播放进度
- (IBAction)sliderTouchEnd:(UISlider *)sender
{
    CGFloat durationTime = CMTimeGetSeconds(self.player.currentItem.duration);
    
    CGFloat currentSliderTime = durationTime * self.timeSlider.value;
    
    [self.player seekToTime:CMTimeMakeWithSeconds(currentSliderTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
    [self.player play];
    
    [self addTime];
}


#pragma mark - 控件被复用时需要调用的方法
// 暂停播放
- (void)suspendVoicePlay
{
    self.playOrPauseButton.selected = NO;
    [self.player pause];
    
    [self removeTime];
}
// 重置播放器
- (void)resetVoicePlay
{
    [self suspendVoicePlay];
    
    [self.playerLayer removeFromSuperlayer];
    
    [self.player replaceCurrentItemWithPlayerItem:nil];
    
    self.player = nil;
    
    [self removeFromSuperview];
}


@end
