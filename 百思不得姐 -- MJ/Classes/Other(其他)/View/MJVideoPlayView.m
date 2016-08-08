//
//  MJVideoPlayView.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/7.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJVideoPlayView.h"
#import <AVFoundation/AVFoundation.h>

@interface MJVideoPlayView ()

@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenButton;
@property (weak, nonatomic) IBOutlet UISlider *timeControllSlider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIView *bottomToolView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *canclButton;


/* player */
@property (weak ,nonatomic) AVPlayer * player;

/* playerLayer */
@property (weak ,nonatomic) AVPlayerLayer * playerLayer;

/* 定时器 */
@property (strong ,nonatomic)  NSTimer * timer;

@end

@implementation MJVideoPlayView
#pragma mark - xib 一出生就具有的特性设置
- (void)awakeFromNib
{
    
    AVPlayer * player = [[AVPlayer alloc]init];
    self.player = player;
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    [self.pictureView.layer addSublayer:self.playerLayer];
    
//    设置 slider 的滑动样式
    [self.timeControllSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    
    [self.timeControllSlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    
    [self.timeControllSlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
//    播放背景图片的手势添加
    self.pictureView.userInteractionEnabled = YES;
    
    [self.pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoViewClick:)]];
    
//    创建时，默认播放
    self.playOrPauseButton.selected = YES;
    self.bottomToolView.alpha = 0;
    self.canclButton.alpha = self.bottomToolView.alpha;
//  定时器的添加
    
    [self addTime];
    
}
#pragma mark - 设置 playerLayer 的尺寸，以及变更 self 的尺寸时就会调用
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
    
}
#pragma mark - 背景图片的点击手势触发的方法
- (void)videoViewClick:(UIGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.3 animations:^{
        if (self.bottomToolView.alpha)
        {
            self.bottomToolView.alpha = 0;
            self.canclButton.alpha = self.bottomToolView.alpha;
        }
        else
        {
            self.bottomToolView.alpha = 1;
            self.canclButton.alpha = self.bottomToolView.alpha;
        }
    }];
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem
{
    _playerItem = playerItem;
    
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.player play];
}

+ (instancetype)videoPlayView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)removeTime
{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)addTime
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
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
    
    [self.timeControllSlider setValue:sliderValue animated:NO];
    
}
#pragma mark -  IBAction子控件们点击所触发的方法
// 点击全屏/取消全屏 按钮
- (IBAction)fullScreenClick:(UIButton *)sender
{
    self.fullScreenButton.selected = !self.fullScreenButton.selected;
    
    if ([self.delegate respondsToSelector:@selector(videoPlayViewChangeOrientation:)])
    {
        [self.delegate videoPlayViewChangeOrientation:self.fullScreenButton.selected];
    }
}
// 按下 slider 一瞬间 所执行的操作
- (IBAction)sliderStart:(UISlider *)sender
{
    [self removeTime];
    
}
// 结束 slider 的按压动作后，所执行的动作
- (IBAction)sliderEndTouch:(UISlider *)sender
{
    CGFloat duration = CMTimeGetSeconds(self.player.currentItem.duration);
    
    CGFloat sliderEndTime = self.timeControllSlider.value * duration;
//    跳到 slider 滑动结束时，sliderValue 所代表的的播放位置
    [self.player seekToTime:CMTimeMakeWithSeconds(sliderEndTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
//    开始播放
    self.playOrPauseButton.selected = YES;
    
    [self addTime];
}
// 结束 slider 的按压动作后，时间 label 也随之变化
- (IBAction)sliderEndOtherChange:(UISlider *)sender
{
//    拿到播放的视频总时间
    CGFloat duration = CMTimeGetSeconds(self.player.currentItem.duration);
//    拿到 sliderValue 代表的视频播放时间
    CGFloat sliderEndTime = self.timeControllSlider.value * duration;
    
    //    秒转为 分钟 和 秒
    NSInteger cMin = sliderEndTime / 60;
    NSInteger cSec = (NSInteger)sliderEndTime % 60;
    
    NSInteger dMin = duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd/%02zd:%02zd",cMin,cSec,dMin,dSec];
}
// 点击了播放、暂停按钮触发
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
            [self.progressView stopAnimating];
            [self.player pause];
            [self removeTime];
        }
}
// 点击了右上角的 x 按钮
- (IBAction)closeVideoView:(UIButton *)sender
{
    [self resetVideoPlay];
}
#pragma mark - 控件被复用时需要调用的方法
// 暂停播放
- (void)suspendVideoPlay
{
    [self.progressView stopAnimating];
    
    self.playOrPauseButton.selected = NO;
    self.bottomToolView.alpha = 1;
    self.canclButton.alpha = self.bottomToolView.alpha;
    [self.player pause];
    
    [self removeTime];
}
// 重置播放器
- (void)resetVideoPlay
{
    [self suspendVideoPlay];
    
    [self.playerLayer removeFromSuperlayer];
    
    [self.player replaceCurrentItemWithPlayerItem:nil];
    
    self.player = nil;
    
    [self removeFromSuperview];
}

#pragma mark - playitem 监听到 status 改变后实现的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem * item = (AVPlayerItem *)object;
    
    if (item.status == AVPlayerItemStatusReadyToPlay)
    {
        [self.progressView stopAnimating];
    }
   
}
#pragma mark - 销毁播放器时，需要做的事情
- (void)dealloc
{
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    
    [self.player replaceCurrentItemWithPlayerItem:nil];
}
@end
