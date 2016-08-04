//
//  MJTableViewCell.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTableViewCell.h"
#import "MJCategotyList.h"
@interface MJTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *followButton;

@end

@implementation MJTableViewCell

static NSString *listCellID = @"listCell";
+ (instancetype)cellWithTableview:(UITableView *)tableView
{
    MJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:listCellID];
    
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
- (void)setList:(MJCategotyList *)list
{
    _list = list;
    
    [self.iconImageView circleImageViewWithUrl:self.list.header];
    self.nameLabel.text = self.list.screen_name;
    
    NSInteger count = self.list.fans_count;
    if (count >= 10000)
    {
        self.followCountLabel.text = [NSString stringWithFormat:@"%.2f万人关注",count / 10000.0];
    }
    else
    {
        self.followCountLabel.text = [NSString stringWithFormat:@"%zd人关注",count];
    }
    
    self.followButton.selected = self.list.isFans;
    
}
@end
