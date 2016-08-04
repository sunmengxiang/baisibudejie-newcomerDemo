//
//  MJTopicsViewCell.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/29.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTopicsViewCell.h"
#import "MJTopics.h"
#import "MJCommentUsers.h"
#import "MJComments.h"
#import "MJTopicsPictureView.h"
#import "MJTopicsVideoView.h"
#import "MJTopicsVoiceView.h"
#import <UIImageView+WebCache.h>
@interface MJTopicsViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *isVipImage;
@property (weak, nonatomic) IBOutlet UILabel *topicsTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end
@implementation MJTopicsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

static NSString *topicsCellID = @"topicsCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    MJTopicsViewCell * cell = [tableView dequeueReusableCellWithIdentifier:topicsCellID];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    }
    

    return cell;
}
+ (instancetype)topicsViewCell
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];;
}
- (void)setTopics:(MJTopics *)topics
{
    
    _topics = topics;


    [self.iconImageView circleImageViewWithUrl:topics.profile_image];
    
    self.nameLabel.text = topics.name;
    
    self.creatTimeLabel.text = topics.passtime;
    self.topicsTextLabel.text = topics.text;

    self.isVipImage.hidden = !topics.jie_vip;
    [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",topics.love ] forState:UIControlStateNormal];
    [self.caiButton setTitle:[NSString stringWithFormat:@"%zd",topics.cai] forState:UIControlStateNormal];
    [self.repostButton setTitle:[NSString stringWithFormat:@"%zd",topics.repost] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd",topics.comment] forState:UIControlStateNormal];
    if (topics.type == MJTopicsTypePicture)
    {
        MJTopicsPictureView * pictureView = [MJTopicsPictureView topicsPictureView];
        pictureView.frame = topics.pictureFrame;
        pictureView.topics = topics;
        [self addSubview:pictureView];
    }
    if (topics.type == MJTopicsTypeVideo)
    {
        MJTopicsVideoView * videoView = [MJTopicsVideoView topicsVideoView];
        videoView.topics = topics;
        videoView.frame = topics.pictureFrame;
        [self addSubview:videoView];
    }
    if (topics.type == MJTopicsTypeVoice)
    {
        MJTopicsVoiceView * voiceView = [MJTopicsVoiceView topicsVoiceView];
        voiceView.topics = topics;
        voiceView.frame = topics.pictureFrame;
        [self addSubview:voiceView];
    }
    
    
    if (self.topics.top_cmt.content.length != 0)
    {
        
//        创建装热评label 的 view
        UIView * labelView = [[UIView alloc]init];
        labelView.backgroundColor = MJColor(177,177, 177);
        labelView.frame = topics.hotCommentViewFrame;
        labelView.height += MJTopicsCellMargin;
        
//        热评标签制作
        UILabel * labelLogo = [[UILabel alloc]init];
        labelLogo.backgroundColor = [UIColor darkGrayColor];
        labelLogo.font = [UIFont systemFontOfSize:7];
        labelLogo.textColor = [UIColor whiteColor];
        labelLogo.numberOfLines = 2;
        labelLogo.text = @"热评";
        labelLogo.textAlignment = NSTextAlignmentCenter;
        labelLogo.frame = CGRectMake(0, 0, 9, 18);
        [labelView addSubview:labelLogo];
        
//        热评内容 label
        UILabel * top_cmtLabel = [[UILabel alloc]init];
        top_cmtLabel.numberOfLines = 0;

        top_cmtLabel.backgroundColor = [UIColor clearColor];
        
        NSString * userName = [NSString stringWithFormat:@"%@ : ",self.topics.top_cmt.user.username];
       
        NSString * content = self.topics.top_cmt.content;
        NSString * finalText = [userName stringByAppendingString:content];
//        userName 富文本
        NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:finalText];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, [userName length])];
        [attrString addAttribute:NSForegroundColorAttributeName  value:[UIColor whiteColor] range:NSMakeRange([userName length], [content length])];
        CGFloat labelX = labelView.x + MJTopicsCellMargin / 2.0;
        CGFloat labelY =  MJTopicsCellMargin / 2.0;
        CGFloat labelW = MJScreenW - 3 * MJTopicsCellMargin;
        CGFloat labelH = topics.hotCommentViewFrame.size.height;
        top_cmtLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
//        top_cmtLabel.frame = topics.hotCommentViewFrame;
        top_cmtLabel.attributedText = attrString;
        
        top_cmtLabel.font = [UIFont systemFontOfSize:13];
        
        [labelView addSubview:top_cmtLabel];
        [self.contentView addSubview:labelView];
//        [self.contentView addSubview:top_cmtLabel];
       
    }
    
    
}
//设置 cell 的 contentView 的尺寸
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += MJTopicsCellMargin / 2.0;
    frame.size.height -=  MJTopicsCellMargin;
    
    [super setFrame:frame];
    
}
@end
