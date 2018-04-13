//
//  FogUserManager.m
//  FogV3
//
//  Created by 黄坚 on 2017/10/19.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import "FogUserManager.h"
#import "HJNetworking.h"
#import "NSMutableDictionary+HJSafeSet.h"
@implementation FogUserManager

+(instancetype)sharedInstance
{
    static FogUserManager *userManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager=[[FogUserManager alloc]init];
    });
    return userManager;
}

-(void)getVerifyCodeWithLoginName:(NSString *)loginName andAppid:(NSString *)appid success: (UserSuccess)success failure:(UserFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:loginName forKey:@"loginname"];
    [params hj_dictSet:appid forKey:@"appid"];
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/getVerCode/" Params:params Header:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)getVerifyCodeWithParams:(NSDictionary *)params success: (UserSuccess)success failure:(UserFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/getVerCode/" Params:params Header:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)checkVerifyCodeWithParams:(NSDictionary *)params success: (UserSuccess)success failure:(UserFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/checkVerCode/" Params:params Header:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)checkVerifyCodeWithLoginName:(NSString *)loginName vercode:(NSString *)vercode appid:(NSString *)appid success: (UserSuccess)success failure:(UserFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:loginName forKey:@"loginname"];
    [params hj_dictSet:appid forKey:@"appid"];
    [params hj_dictSet:vercode forKey:@"vercode"];
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/checkVerCode/" Params:params Header:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
-(void)setPasswordWithParams:(NSDictionary *)params success: (UserSuccess)success failure:(UserFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/resetPassword/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)setPassword:(NSString *)password token:(NSString *)token success: (UserSuccess)success failure:(UserFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:password forKey:@"password1"];
    [params hj_dictSet:password forKey:@"password2"];
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/resetPassword/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
-(void)loginWithParams:(NSDictionary *)params success: (UserSuccess)success failure:(UserFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/login/" Params:params Header:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)loginWithName:(NSString *)loginName password:(NSString *)password appid:(NSString *)appid extend:(NSString *)extend success: (UserSuccess)success failure:(UserFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:loginName forKey:@"loginname"];
    [params hj_dictSet:password forKey:@"password"];
    if (extend) {
        [params hj_dictSet:extend forKey:@"extend"];
    }
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/login/" Params:params Header:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
-(void)refreshTokenWithParams:(NSDictionary *)params success: (UserSuccess)success failure:(UserFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/refreshToken/" Params:params Header:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)refreshTokenWithOldToken:(NSString *)token success: (UserSuccess)success failure:(UserFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:token forKey:@"token"];
   
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/refreshToken/" Params:params Header:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
