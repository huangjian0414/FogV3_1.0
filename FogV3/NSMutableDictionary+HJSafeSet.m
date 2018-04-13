//
//  NSMutableDictionary+HJSafeSet.m
//  RunTimeTest
//
//  Created by 黄坚 on 2018/1/9.
//  Copyright © 2018年 huangjian. All rights reserved.
//

#import "NSMutableDictionary+HJSafeSet.h"
@implementation NSMutableDictionary (HJSafeSet)
-(void)hj_dictSet:(id)obj forKey:(id<NSCopying>)key
{
    if (obj && ![obj isKindOfClass:[NSNull class]] && key) {
        [self setObject:obj forKey:key];
    }else {
        return ;
    }
}

@end
