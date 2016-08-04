//
//  MJShowPictureViewController.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/2.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJTopics;
@interface MJShowPictureViewController : UIViewController


/* modal 前的下载进度 */
@property ( assign ,nonatomic)   CGFloat  progress;

@property (nonatomic,strong) MJTopics * topics;
@end
