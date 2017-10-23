//
//  FogUserManager.h
//  FogV3
//
//  Created by 黄坚 on 2017/10/19.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UserSuccess)(id responseObject);
typedef void(^UserFailure)(NSError *error);
@interface FogUserManager : NSObject
@property (nonatomic,copy)UserSuccess userSuccess;
@property (nonatomic,copy)UserFailure userFailure;

/**
 单例管理类
 
 @return self
 */
+(instancetype)sharedInstance;


/**
 获取验证码
 
 @param loginName 登录用户名
 @param appid AppID
 @param success 成功回调
 @param failure 失败回调
 */
-(void)getVerifyCodeWithLoginName:(NSString *)loginName andAppid:(NSString *)appid success: (UserSuccess)success failure:(UserFailure)failure;

/**
 校验验证码
 
 @param loginName 登录用户名
 @param vercode 验证码
 @param appid AppID
 @param success 成功回调
 @param failure 失败回调
 */
-(void)checkVerifyCodeWithLoginName:(NSString *)loginName vercode:(NSString *)vercode appid:(NSString *)appid success: (UserSuccess)success failure:(UserFailure)failure;

/**
 设置初始密码或重置密码
 
 @param password 密码
 @param token token
 @param success 成功回调
 @param failure 失败回调
 */
-(void)setPassword:(NSString *)password token:(NSString *)token success: (UserSuccess)success failure:(UserFailure)failure;

/**
 登录
 
 @param loginName 登录用户名
 @param password 登录密码
 @param appid AppID
 @param success 成功回调
 @param failure 失败回调
 */
-(void)loginWithName:(NSString *)loginName password:(NSString *)password appid:(NSString *)appid extend:(NSString *)extend success: (UserSuccess)success failure:(UserFailure)failure;

/**
 刷新token
 
 @param token 旧的token
 @param success 成功回调
 @param failure 失败回调
 */
-(void)refreshTokenWithOldToken:(NSString *)token success: (UserSuccess)success failure:(UserFailure)failure;

@end
