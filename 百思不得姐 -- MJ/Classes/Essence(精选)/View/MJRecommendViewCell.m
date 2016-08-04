//
//  MJRecommendViewCell.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/28.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJRecommendViewCell.h"
#import "MJRecommend.h"
#import <UIImageView+WebCache.h>

@interface MJRecommendViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingyueButton;

@end
@implementation MJRecommendViewCell
static NSString * recommendCellID = @"recommendCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    MJRecommendViewCell * cell = [tableView dequeueReusableCellWithIdentifier:recommendCellID];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    }
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setRecommend:(MJRecommend *)recommend
{
    _recommend = recommend;
    
    [self.iconImageView circleImageViewWithUrl:recommend.image_list];
    
    self.nameLabel.text = recommend.theme_name;
    
    CGFloat count = recommend.sub_number;
    if (count > 10000)
    {
        count = count / 10000.0;
        self.countLabel.text = [NSString stringWithFormat:@"%.2f万人订阅",count];
    }
    else
    {
        
        self.countLabel.text = [NSString stringWithFormat:@"%zd人订阅",recommend.sub_number];
    }
   
    
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 3;
    frame.size.width = MJScreenW - 6;
    frame.origin.y += 1;
    frame.size.height = self.height - 2;
    
    [super setFrame:frame];
}
@end
