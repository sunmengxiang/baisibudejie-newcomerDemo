//
//  MJCategoryCell.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJCategoryCell.h"
#import "MJCategory.h"
@interface MJCategoryCell()

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;



@end

@implementation MJCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = MJColor(244, 244, 244);
    self.selectImageView.backgroundColor = MJColor(219, 21, 26);
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.x = 10;
    
}
static NSString* categoryID = @"categoryCell";
+ (instancetype)cellWithTableview:(UITableView *)tableView
{
    MJCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    }
    
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectImageView.hidden = !selected;
    
    self.textLabel.textColor = selected?self.selectImageView.backgroundColor :[UIColor blackColor];
    
}


- (void)setCategory:(MJCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}
//- (IBAction)categoryBtnClick:(UIButton *)btn
//{
//    self.selectedtButton.enabled = YES;
//    
//
//    if ([self.delegate respondsToSelector:@selector(MJCategoryCellDidClickWithCategory:)])
//    {
//        [self.delegate MJCategoryCellDidClickWithCategory:self.category];
//    }
//    
//    btn.enabled = NO;
//    
//    
//    self.selectedtButton = btn;
//    
//}
@end
