//
//  FogV3Center.m
//  FogV3
//
//  Created by 黄坚 on 2018/4/13.
//  Copyright © 2018年 黄坚. All rights reserved.
//

#import "FogV3Center.h"
#import "HJNetworking.h"

#define HJ_SAFE_BLOCK(BlockName, ...) ({ !BlockName ? nil : BlockName(__VA_ARGS__); })

@implementation FogV3Center
+ (void)setupConfig:(void(^)(FogV3Config *config))block
{
    FogV3Config *conf=[[FogV3Config alloc]init];
    HJ_SAFE_BLOCK(block,conf);
    if (conf.generalServer) {
        [HJNetworking sharedInstance].generalServer = conf.generalServer;
    }
    if (conf.generalHeader.count > 0) {
        [HJNetworking sharedInstance].generalHeader=conf.generalHeader;
    }
    [HJNetworking sharedInstance].showRequestLog=conf.showRequestLog;
}
@end
@implementation FogV3Config

@end
