//
//  NSMutableDictionary+HJSafeSet.h
//  RunTimeTest
//
//  Created by 黄坚 on 2018/1/9.
//  Copyright © 2018年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (HJSafeSet)
-(void)hj_dictSet:(id)obj forKey:(id<NSCopying>)key;
@end
