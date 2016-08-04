//
//  MJCategory.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJCategory.h"
#import <MJExtension.h>
@implementation MJCategory

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };
}

- (NSMutableArray *)list
{
    if (_list == nil)
    {
        _list = [NSMutableArray array];
    }
    return _list;
}
@end
