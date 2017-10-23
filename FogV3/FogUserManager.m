//
//  FogUserManager.m
//  FogV3
//
//  Created by 黄坚 on 2017/10/19.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import "FogUserManager.h"
#import <XMNetworking.h>
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
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/v3/enduser/getVerCode/";
        request.parameters = @{@"appid":appid,@"loginname":loginName};
    } onSuccess:^(id  _Nullable responseObject) {
        success(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

-(void)checkVerifyCodeWithLoginName:(NSString *)loginName vercode:(NSString *)vercode appid:(NSString *)appid success: (UserSuccess)success failure:(UserFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/v3/enduser/checkVerCode/";
        request.parameters = @{@"appid":appid,@"loginname":loginName,@"vercode":vercode};
    }onSuccess:^(id  _Nullable responseObject) {
        
        success(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

-(void)setPassword:(NSString *)password token:(NSString *)token success: (UserSuccess)success failure:(UserFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/v3/enduser/resetPassword/";
        request.parameters = @{@"password1":password,@"password2":password};
        request.headers = @{@"Authorization":[NSString stringWithFormat:@"JWT %@", token]};
    }onSuccess:^(id  _Nullable responseObject) {
        success(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
-(void)loginWithName:(NSString *)loginName password:(NSString *)password appid:(NSString *)appid extend:(NSString *)extend success: (UserSuccess)success failure:(UserFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api=@"/v3/enduser/login/";
        if (extend==nil) {
            request.parameters = @{@"loginname":loginName,@"password":password,@"appid":appid};
        }else
        {
        request.parameters = @{@"loginname":loginName,@"password":password,@"appid":appid,@"extend":extend};
        }
        
    } onSuccess:^(id  _Nullable responseObject) {
        success(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

-(void)refreshTokenWithOldToken:(NSString *)token success: (UserSuccess)success failure:(UserFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api=@"/v3/enduser/refreshToken/";
        request.parameters=@{@"token":token};
        
    } onSuccess:^(id  _Nullable responseObject) {
        success(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

@end
