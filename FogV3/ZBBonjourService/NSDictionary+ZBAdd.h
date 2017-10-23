//
//  NSDictionary+ZBAdd.h
//  
//
//  Created by WuZhengBin on 2016/8/17.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZBAdd)
- (BOOL)containsObjectForKey:(id)key;
@end

@interface NSMutableDictionary (ZBAdd)
- (void)safeSetObject:(id)object forKey:(id<NSCopying>)key;
@end
