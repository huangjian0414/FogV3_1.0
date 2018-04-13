//
//  FogV3Center.h
//  FogV3
//
//  Created by 黄坚 on 2018/4/13.
//  Copyright © 2018年 黄坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FogV3Config;
@interface FogV3Center : NSObject
//初始设置 
+ (void)setupConfig:(void(^)(FogV3Config *config))block;
@end


@interface FogV3Config : NSObject
//通用域名部分  default is @"".
@property (nonatomic,copy)NSString *generalServer;
//通用头部   default is nil.
@property (nonatomic,strong)NSDictionary *generalHeader;
//是否显示请求log  default is NO.
@property (nonatomic,assign)BOOL showRequestLog;

@end
