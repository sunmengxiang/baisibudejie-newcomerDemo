//
//  MJCategory.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MJCategotyList;
@interface MJCategory : NSObject

/* name */
@property (strong ,nonatomic) NSString * name;

///* 对应右侧的 list */
//@property (strong ,nonatomic) MJCategotyList * list;
/* list */
@property (strong ,nonatomic) NSMutableArray * list;
/* id */
@property (strong ,nonatomic) NSString * ID;

/* count */
@property ( assign ,nonatomic)  NSInteger  total;

/* currentPage */
@property ( assign ,nonatomic)  NSInteger  currentPage;

@end
