//
//  FogDeviceManager.m
//  FogV3
//
//  Created by 黄坚 on 2017/10/20.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import "FogDeviceManager.h"
#import "ZBBonjourService.h"
#import <XMNetworking.h>
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
-(void)bindDeviceWithDeviceId:(NSString *)deviceId token:(NSString *)token extend:(NSString *)extend success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api=@"/v3/enduser/bindDevice/";
        request.headers=@{@"Authorization":[NSString stringWithFormat:@"JWT %@", token]};
        request.parameters = @{@"deviceid":deviceId,@"extend":extend};
        
    } onSuccess:^(id  _Nullable responseObject) {
        success(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
-(void)unBindDeviceWithDeviceId:(NSString *)deviceId token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/v3/enduser/unbindDevice/";
        request.httpMethod = kXMHTTPMethodPUT;
        request.parameters = @{@"deviceid":deviceId};
        request.headers = @{@"Authorization": [NSString stringWithFormat:@"JWT %@", token]};
    } onSuccess:^(id  _Nullable responseObject) {
        success(responseObject);
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
-(void)getDeviceListWithToken:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api=@"/v3/enduser/deviceList/";
        request.httpMethod=kXMHTTPMethodGET;
        request.headers=@{@"Authorization":[NSString stringWithFormat:@"JWT %@", token]};
    } onSuccess:^(id  _Nullable responseObject) {
        
        success(responseObject);
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
-(void)getDeviceInfoWithDeviceId:(NSString *)deviceId token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api=@"/v3/enduser/deviceInfo/";
        request.httpMethod=kXMHTTPMethodGET;
        request.headers=@{@"Authorization":[NSString stringWithFormat:@"JWT %@", token]};
        request.parameters = @{@"deviceid":deviceId};
    } onSuccess:^(id  _Nullable responseObject) {
        
        success(responseObject);
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
-(void)updateDeviceAliasWithDeviceId:(NSString *)deviceId  alias:(NSString *)alias token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api=@"/v3/enduser/updateDeviceAlias/";
        request.httpMethod=kXMHTTPMethodPUT;
        request.headers=@{@"Authorization":[NSString stringWithFormat:@"JWT %@", token]};
        request.parameters=@{@"deviceid":deviceId,@"alias":alias};
    } onSuccess:^(id  _Nullable responseObject) {
        
        success(responseObject);
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
-(void)getShareVerCodeWithDeviceId:(NSString *)deviceId role:(NSInteger)role granttimes:(NSInteger)granttimes token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/v3/enduser/shareCode/";
        request.httpMethod = kXMHTTPMethodPOST;
        request.parameters = @{@"deviceid":deviceId,@"role":@(role),@"granttimes":@(granttimes)};
        request.headers = @{@"Authorization": [NSString stringWithFormat:@"JWT %@", token]};
    } onSuccess:^(id  _Nullable responseObject) {
        
    } onFailure:^(NSError * _Nullable error) {
        
    }];
}
-(void)addDeviceByVerCodeWithDeviceId:(NSString *)deviceId vercode:(NSString *)vercode bindingtype:(BindingType)bindingtype     extra:(NSString *)extra iscallback:(BOOL)iscallback token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
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
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/v3/enduser/grantDevice/";
        request.headers = @{@"Authorization":[NSString stringWithFormat:@"JWT %@", token]};
        request.parameters = @{@"deviceid":deviceId,
                               @"vercode":vercode,
                               @"bindingtype":type};
        
    }onSuccess:^(id  _Nullable responseObject) {
        success(responseObject);
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
-(void)getMemberListWithDeviceId:(NSString *)deviceId token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure;
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api=@"/v3/enduser/enduserList/";
        request.httpMethod=kXMHTTPMethodGET;
        request.headers=@{@"Authorization":[NSString stringWithFormat:@"JWT %@", token]};
        request.parameters = @{@"deviceid":deviceId};
    } onSuccess:^(id  _Nullable responseObject) {
        
        success(responseObject);
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
-(void)removeBindRoleWithDeviceId:(NSString *)deviceId enduserid:(NSString *)enduserid token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api=@"/v3/enduser/removeBindRole/";
        request.httpMethod=kXMHTTPMethodPUT;
        request.headers=@{@"Authorization":[NSString stringWithFormat:@"JWT %@", token]};
        request.parameters=@{@"deviceid":deviceId,@"enduserid":enduserid};
    } onSuccess:^(id  _Nullable responseObject) {
        
        success(responseObject);
    } onFailure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
@end
