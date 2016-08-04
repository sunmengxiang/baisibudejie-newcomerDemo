//
//  MJTopicsPictureView.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/30.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTopicsPictureView.h"
#import "MJTopics.h"
#import <UIImageView+WebCache.h>
#import "MJProgressVIew.h"
#import "MJShowPictureViewController.h"

@interface MJTopicsPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifLogo;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@property (weak, nonatomic) IBOutlet MJProgressVIew *progressView;

@property (nonatomic,assign) CGFloat progress;
@end
@implementation MJTopicsPictureView

- (void)awakeFromNib
{
//    给图片添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigPictureClick)];
    self.pictureImageView.userInteractionEnabled = YES;
    [self.pictureImageView addGestureRecognizer:tap];
}

+ (instancetype)topicsPictureView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (IBAction)seeBigPictureClick
{
    MJShowPictureViewController * showVc = [[MJShowPictureViewController alloc]init];
    showVc.progress = self.progress;
    showVc.topics = self.topics;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVc animated:YES completion:nil];
}

- (void)setTopics:(MJTopics *)topics
{
    
//    防止上一个 progress 循环利用到下一个 progress
    [self.progressView setProgress:0.0];
    _topics = topics;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:topics.imageBig] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = receivedSize * 1.0 / expectedSize * 1.0 ;
        self.progress = progress;
//        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.2f",progress];
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        if (! self.topics.isBigPicture == YES) return ;
       
//        开启上下文
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(topics.pictureFrame.size.width, topics.pictureFrame.size.height), 0, 0);
        
        CGFloat picHeight = self.width * topics.height / topics.width;
//        将图片绘制上去
        [image drawInRect:CGRectMake(0, 0, topics.pictureFrame.size.width, picHeight)];
        
//        拿到画上去的图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        
//        关闭上下文
        UIGraphicsEndImageContext();
        
        self.pictureImageView.image = image;
        
    }];
    
    self.gifLogo.hidden = !topics.isGif;
    self.seeBigPictureButton.hidden = !topics.bigPicture;
    
    
}

@end
