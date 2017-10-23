//
//  FogEasyLinkManager.h
//  FogV3
//
//  Created by 黄坚 on 2017/10/20.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FogEasyLinkManager : NSObject
/**
 设备管理类
 
 @return self
 */
+(instancetype)sharedInstance;


/**
 获取SSID
 
 @return 当前wifi名称
 */
-(NSString *)getSSID;

/**
 开始配网
 
 @param password 当前wifi密码
 */
-(void)startEasyLinkWithPassword:(NSString *)password;

/**
 停止配网
 */
-(void)stopEasyLink;
@end
