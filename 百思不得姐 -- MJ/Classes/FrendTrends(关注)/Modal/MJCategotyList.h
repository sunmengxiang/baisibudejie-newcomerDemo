//
//  MJCategotyList.h
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/8/3.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJCategotyList : NSObject
/* 名字 */
@property (strong ,nonatomic)  NSString * screen_name;
/* icon */
@property (strong ,nonatomic) NSString * header;

/* followCount */
@property ( assign ,nonatomic)  NSInteger  fans_count;


/* 是否是我关注的 */
@property ( assign ,nonatomic)   BOOL  isFans;

@end
