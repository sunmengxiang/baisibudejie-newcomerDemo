//
//  MJTopics.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/29.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTopics.h"
#import "MJComments.h"
#import "MJCommentUsers.h"
#import <MJExtension.h>

@implementation MJTopics

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"imageBig":@"image1",
             @"imageMid":@"image2",
             @"imageSmall":@"image0",
             @"top_cmt" : @"top_cmt[0]",
             @"ID":@"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"top_cmt":@"MJComments"
             };
}

- (CGFloat)cellHeight
{
    if (_cellHeight == 0)
    {
        //    根据 text 的字体大小计算 text 的高度
        CGSize maxSize = CGSizeMake(MJScreenW - 2 * MJTopicsCellMargin, MAXFLOAT);

        CGFloat textHeight = [self.text  boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;

 
        _cellHeight = MJTopicsCellTextY + textHeight;
//        判断是否图片帖子
        if (self.type == MJTopicsTypePicture)
        {
//             拿到图片的大小，将其转换为宽度跟图片控件宽度一致，此时的等比例的高度就是我们所要
            CGFloat height = self.height * maxSize.width / self.width;
            if (height >= MJTopicsPictureMaxHeight)
            {
                height = MJTopicsPicturePreferHeight;
                self.bigPicture = YES;
            }
            else
            {
                self.bigPicture = NO;
            }
            _cellHeight += MJTopicsCellMargin + height;
            CGFloat picY = MJTopicsCellTextY + textHeight + MJTopicsCellMargin;
            self.pictureFrame = CGRectMake(MJTopicsCellMargin, picY, maxSize.width, height);
        }
        else if (self.type == MJTopicsTypeVoice)
        {
            //             拿到图片的大小，将其转换为宽度跟图片控件宽度一致，此时的等比例的高度就是我们所要
            CGFloat height = self.height * maxSize.width / self.width;

            _cellHeight += MJTopicsCellMargin + height;
            CGFloat picY = MJTopicsCellTextY + textHeight + MJTopicsCellMargin;
            self.pictureFrame = CGRectMake(MJTopicsCellMargin, picY, maxSize.width, height);
        }
        else if (self.type == MJTopicsTypeVideo)
        {
            //             拿到图片的大小，将其转换为宽度跟图片控件宽度一致，此时的等比例的高度就是我们所要
            CGFloat height = self.height * maxSize.width / self.width;
            
            _cellHeight += MJTopicsCellMargin + height;
            CGFloat picY = MJTopicsCellTextY + textHeight + MJTopicsCellMargin;
            self.pictureFrame = CGRectMake(MJTopicsCellMargin, picY, maxSize.width, height);
        }

        if (self.top_cmt != nil)
        {
            NSString * nameWithContent = [self.top_cmt.user.username stringByAppendingString:self.top_cmt.content];
    CGSize topCmtMaxSize = CGSizeMake(MJScreenW - 3 * MJTopicsCellMargin, MAXFLOAT);
            CGFloat top_cmtHeight = [nameWithContent boundingRectWithSize:topCmtMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size.height;
            self.hotCommentViewFrame = CGRectMake(MJTopicsCellMargin, _cellHeight + MJTopicsCellMargin, MJScreenW - 2* MJTopicsCellMargin, top_cmtHeight);
            _cellHeight += top_cmtHeight + 2 * MJTopicsCellMargin;
        }
        
        _cellHeight += MJTopicsCellBottomToolsH + 2*MJTopicsCellMargin;
    }
    
    return _cellHeight;
    
}

@end
