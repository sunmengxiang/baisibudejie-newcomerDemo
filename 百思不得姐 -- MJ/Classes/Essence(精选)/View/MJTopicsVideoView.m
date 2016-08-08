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
#import "MJVideoPlayView.h"
#import "MJFullViewController.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
@interface MJTopicsVideoView ()<MJVideoPlayViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLable;

@property (weak, nonatomic) IBOutlet MJProgressVIew *progressView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

/* 记录上一次的 topics 模型 */
@property (strong ,nonatomic)  MJTopics * lastTopics;



/* fullView */
@property (strong ,nonatomic) MJFullViewController * fullVc;
@end

@implementation MJTopicsVideoView


// 快速加载 xib 文件
+ (instancetype)topicsVideoView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    [self setUpVideoPlayer];
}
#pragma mark - 点击中间的播放按钮
- (IBAction)playClick
{
    self.videoView = [MJVideoPlayView videoPlayView];
    self.videoView.delegate = self;
    self.videoView.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topics.videouri]];
    
    [self addSubview:self.videoView];

}
- (void)setUpVideoPlayer
{
 
    self.pictureView.userInteractionEnabled = YES;
    
}

#pragma mark - 设置子控件的数据
- (void)setTopics:(MJTopics *)topics
{
    _topics = topics;
    self.lastTopics = topics;
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:topics.imageMid] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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
# pragma mark - <MJVideoPlayViewDelegate>全屏或取消全屏
- (void)videoPlayViewChangeOrientation:(BOOL)isFull
{
    if (isFull)
    {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.fullVc animated:YES completion:^{
            self.videoView.frame = self.fullVc.view.bounds;
            [self.fullVc.view addSubview:self.videoView];
        }];
    }
    else
    {
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
            self.videoView.frame = self.bounds;
            [self addSubview:self.videoView];
        }];
    }
}
// 布局子控件尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.videoView.frame = self.bounds;
}
// 懒加载
- (MJFullViewController *)fullVc
{
    if (_fullVc == nil)
    {
        _fullVc = [[MJFullViewController alloc]init];
    }
    return _fullVc;
}
- (void)dealloc
{
    [self.videoView removeFromSuperview];
}
#pragma mark - 从缓存池拿出来时，需清空上一个数据，否则莫名子控件会乱入
- (void)videoResetImage
{
    [self.pictureView setImage:nil];
    self.playTimeLable = nil;
    self.progressView = nil;
    self.playCountLabel = nil;
    self.fullVc = nil;
    [self removeFromSuperview];

}
@end
