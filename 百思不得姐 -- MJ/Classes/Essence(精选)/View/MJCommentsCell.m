//
//  MJCommentsCell.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/1.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJCommentsCell.h"
#import "MJComments.h"
#import "MJCommentUsers.h"
#import <UIImageView+WebCache.h>

@interface MJCommentsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation MJCommentsCell

static NSString * cellID = @"commentCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    MJCommentsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    }
    
    return cell;
}
+ (instancetype)commentCell
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)setComments:(MJComments *)comments
{
    _comments = comments;
    self.contentLabel.text = comments.content;
    [self.iconImageView circleImageViewWithUrl:comments.user.profile_image];
    self.sexTypeImageView.image = [comments.user.sex isEqualToString:MJSexTypeMale]? [UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    self.dingCountLabel.text = [NSString stringWithFormat:@"%zd",comments.like_count];
    self.nameLabel.text = comments.user.username;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}


@end
