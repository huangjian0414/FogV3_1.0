//
//  FogDeviceManager.m
//  FogV3
//
//  Created by 黄坚 on 2017/10/20.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import "FogDeviceManager.h"
#import "ZBBonjourService.h"
#import "HJNetworking.h"
#import "NSMutableDictionary+HJSafeSet.h"
@interface FogDeviceManager ()<ZBBonjourServiceDelegate>

@end
@implementation FogDeviceManager
+(instancetype)sharedInstance
{
    static FogDeviceManager *deviceManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceManager=[[FogDeviceManager alloc]init];
    });
    return deviceManager;
}
-(void)startSearchDevices
{
    [[ZBBonjourService sharedInstance]stopSearchDevice];
    [ZBBonjourService sharedInstance].delegate=self;
    [[ZBBonjourService sharedInstance]startSearchDevice];
}
-(void)bonjourService:(ZBBonjourService *)service didReturnDevicesArray:(NSArray *)array
{
    if ([_delegate respondsToSelector:@selector(didSearchDeviceReturnArray:)]) {
        [_delegate didSearchDeviceReturnArray:array];
    }
}
-(void)stopSearchDevices
{
    [[ZBBonjourService sharedInstance]stopSearchDevice];
}
-(void)bindDeviceWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/bindDevice/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)bindDeviceWithDeviceId:(NSString *)deviceId token:(NSString *)token extend:(NSString *)extend success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:deviceId forKey:@"deviceid"];
    if (extend) {
        [params hj_dictSet:extend forKey:@"extend"];
    }
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/bindDevice/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
-(void)unBindDeviceWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_PUT Api:@"/enduser/unbindDevice/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)unBindDeviceWithDeviceId:(NSString *)deviceId token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:deviceId forKey:@"deviceid"];
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_PUT Api:@"/enduser/unbindDevice/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
-(void)getDeviceListWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_GET Api:@"/enduser/deviceList/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)getDeviceListWithToken:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_GET Api:@"/enduser/deviceList/" Params:nil Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)getDeviceInfoWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_GET Api:@"/enduser/deviceInfo/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)getDeviceInfoWithDeviceId:(NSString *)deviceId token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:deviceId forKey:@"deviceid"];
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_GET Api:@"/enduser/deviceInfo/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
-(void)updateDeviceAliasWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_PUT Api:@"/enduser/updateDeviceAlias/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)updateDeviceAliasWithDeviceId:(NSString *)deviceId  alias:(NSString *)alias token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:deviceId forKey:@"deviceid"];
    [params hj_dictSet:alias forKey:@"alias"];
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_PUT Api:@"/enduser/updateDeviceAlias/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
   
}
-(void)getShareVerCodeWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/shareCode/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)getShareVerCodeWithDeviceId:(NSString *)deviceId role:(NSInteger)role granttimes:(NSInteger)granttimes token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:deviceId forKey:@"deviceid"];
    [params hj_dictSet:@(role) forKey:@"role"];
    [params hj_dictSet:@(granttimes) forKey:@"granttimes"];
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/shareCode/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
   
}
-(void)addDeviceByVerCodeWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/grantDevice/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)addDeviceByVerCodeWithDeviceId:(NSString *)deviceId vercode:(NSString *)vercode bindingtype:(BindingType)bindingtype     extend:(NSString *)extend iscallback:(BOOL)iscallback token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    NSString *type;
    if (bindingtype==BINDTYPE_HOME) {
        type=@"home";
    }else if (bindingtype==BINDTYPE_GUEST)
    {
        type=@"guest";
    }else
    {
        type=@"other";
    }
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:deviceId forKey:@"deviceid"];
    [params hj_dictSet:vercode forKey:@"vercode"];
    [params hj_dictSet:type forKey:@"bindingtype"];
    if (extend) {
        [params hj_dictSet:extend forKey:@"extend"];
    }
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_POST Api:@"/enduser/grantDevice/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
-(void)getMemberListWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_GET Api:@"/enduser/enduserList/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)getMemberListWithDeviceId:(NSString *)deviceId token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure;
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:deviceId forKey:@"deviceid"];
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_GET Api:@"/enduser/enduserList/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
-(void)removeBindRoleWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_PUT Api:@"/enduser/removeBindRole/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(void)removeBindRoleWithDeviceId:(NSString *)deviceId enduserid:(NSString *)enduserid token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params hj_dictSet:deviceId forKey:@"deviceid"];
    [params hj_dictSet:enduserid forKey:@"enduserid"];
    [[HJNetworking sharedInstance]hj_RequestWithType:HJHTTPMethod_PUT Api:@"/enduser/removeBindRole/" Params:params Header:[HJNetworking sharedInstance].generalHeader success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
@end
