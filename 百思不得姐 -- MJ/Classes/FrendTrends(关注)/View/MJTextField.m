//
//  MJTextField.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/29.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJTextField.h"

@implementation MJTextField
static NSString * MJPlaceholderTextColorKeyPath = @"_placeholderLabel.textColor";
- (void)awakeFromNib
{
//    tintColor 如果没设置，会默认使用父控件的 tintColor
//    让光标的颜色同字体颜色一致
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath: MJPlaceholderTextColorKeyPath];
    
    return [super becomeFirstResponder];
    
    
}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor darkGrayColor] forKeyPath:MJPlaceholderTextColorKeyPath];
    
    return [super resignFirstResponder];
}

@end
