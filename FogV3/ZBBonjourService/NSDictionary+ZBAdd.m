//
//  NSDictionary+ZBAdd.m
//  
//
//  Created by WuZhengBin on 2016/8/17.
//
//

#import "NSDictionary+ZBAdd.h"

@implementation NSDictionary (ZBAdd)
- (BOOL)containsObjectForKey:(id)key {
    if (!key) {
        return NO;
    }
    return self[key] != nil;
}
@end

@implementation NSMutableDictionary (ZBAdd)
- (void)safeSetObject:(id)object forKey:(id<NSCopying>)key {
    if (object) {
        [self setObject:object forKey:key];
    }
}
@end
