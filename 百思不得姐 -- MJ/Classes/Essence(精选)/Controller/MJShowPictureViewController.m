//
//  MJShowPictureViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/2.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJShowPictureViewController.h"
#import "MJProgressVIew.h"
#import "MJTopics.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
@interface MJShowPictureViewController ()

@property (weak, nonatomic) IBOutlet MJProgressVIew *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/* 下载完成的图片 */
@property (strong ,nonatomic)  UIImageView * imageV;
@end

@implementation MJShowPictureViewController
- (UIImageView *)imageV
{
    if (_imageV == nil)
    {
        _imageV = [[UIImageView alloc]init];
    }
    return _imageV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MJGloabalBgColor;
    
//    设置 scrollView
    [self setUpScrollView];
    
}
- (void)setUpScrollView
{
    
    CGFloat picHeight =  self.topics.height * MJScreenW / self.topics.width;
    
    UIImageView * imageV = [[UIImageView alloc]init];
    [self.scrollView addSubview:imageV];
    if (picHeight >= MJScreenH)
    {
        self.scrollView.contentSize = CGSizeMake(MJScreenW, picHeight);
        imageV.frame = CGRectMake(0, 0, MJScreenW, picHeight);
    }
    else
    {
        self.scrollView.bounds = CGRectMake(0, 0, self.topics.width, self.topics.height);
        self.scrollView.center = CGPointMake(MJScreenW * 0.5, MJScreenH * 0.5);
        imageV.bounds = self.scrollView.bounds;
        imageV.center = CGPointMake(MJScreenW * 0.5, MJScreenH * 0.5);
        
    }
    
    [self.progressView setProgress:self.progress animated:NO];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.topics.imageBig] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = receivedSize * 1.0 / 1.0 * expectedSize;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.2f",progress];
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        self.imageV.image = image;
        self.imageV.size = image.size;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveClick {
    
    UIImageWriteToSavedPhotosAlbum(self.imageV.image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{

    [SVProgressHUD showSuccessWithStatus:@"已保存到你的相册"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}




@end
