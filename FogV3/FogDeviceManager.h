//
//  FogDeviceManager.h
//  FogV3
//
//  Created by 黄坚 on 2017/10/20.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol FogDeviceDelegate <NSObject>

-(void)didSearchDeviceReturnArray:(NSArray *)array;

@end

typedef NS_ENUM(NSInteger,BindingType) {
    BINDTYPE_HOME=0,
    BINDTYPE_GUEST=1,
    BINDTYPE_OTHER=2
};
typedef void(^DeviceSuccess)(id responseObject);
typedef void(^DeviceFailure)(NSError *error);
@interface FogDeviceManager : NSObject

@property (nonatomic,weak)id<FogDeviceDelegate>delegate;
@property (nonatomic,copy)DeviceSuccess deviceSuccess;
@property (nonatomic,copy)DeviceFailure deviceFailure;

/**
 设备管理类
 
 @return self
 */
+(instancetype)sharedInstance;
/**
 开始搜索设备
 */
-(void)startSearchDevices;

/**
 停止搜索设备
 */
-(void)stopSearchDevices;

/**
 绑定设备

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)bindDeviceWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure;
/**
 绑定设备  (旧)

 @param deviceId 设备id
 @param token token
 @param extend 扩展参数(没有传nil)
 @param success 成功回调
 @param failure 失败回调
 */
-(void)bindDeviceWithDeviceId:(NSString *)deviceId token:(NSString *)token extend:(NSString *)extend success:(DeviceSuccess)success failure:(DeviceFailure)failure;

/**
 解绑设备

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)unBindDeviceWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure;
/**
 解绑设备  (旧)
 
 @param deviceId 设备id
 @param token token
 @param success 成功回调
 @param failure 失败回调
 */
-(void)unBindDeviceWithDeviceId:(NSString *)deviceId token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure;


/**
 获取设备列表

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)getDeviceListWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure;
/**
 获取设备列表  (旧)
 
 @param token token
 */
-(void)getDeviceListWithToken:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure;


/**
 获取设备详情

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)getDeviceInfoWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure;
/**
 获取设备详情  (旧)
 
 @param deviceId 设备id
 @param token token
 @param success 成功回调
 @param failure 失败回调
 */
-(void)getDeviceInfoWithDeviceId:(NSString *)deviceId token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure;

/**
 修改设备名称

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)updateDeviceAliasWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure;
/**
 修改设备名称  (旧)
 
 @param deviceId 设备id
 @param token token
 @param alias 要修改的设备名
 @param success 成功回调
 @param failure 失败回调
 */
-(void)updateDeviceAliasWithDeviceId:(NSString *)deviceId  alias:(NSString *)alias token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure;


/**
 获取设备分享码

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)getShareVerCodeWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure;
/**
 获取设备分享码  (旧)
 
 @param deviceId 设备id
 @param role 授权级别
 @param granttimes 验证码是否一次有效
 @param token token
 @param success 成功回调
 @param failure 失败回调
 */
-(void)getShareVerCodeWithDeviceId:(NSString *)deviceId role:(NSInteger)role granttimes:(NSInteger)granttimes token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure;


/**
 通过分享码绑定设备

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)addDeviceByVerCodeWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure;
/**
 通过分享码绑定设备  (旧)
 
 @param deviceId 设备id
 @param vercode 分享码
 @param bindingtype 用户分组
 @param extend 扩展参数(没有传nil)
 @param iscallback 是否需要发送mqtt消息通知设备 (没用)
 @param token token
 @param success 成功回调
 @param failure 失败回调
 */
-(void)addDeviceByVerCodeWithDeviceId:(NSString *)deviceId vercode:(NSString *)vercode bindingtype:(BindingType)bindingtype     extend:(NSString *)extend iscallback:(BOOL)iscallback token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure;


/**
 获取设备用户列表

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)getMemberListWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure;
/**
 获取设备用户列表  (旧)
 
 @param deviceId 设备id
 @param token token
 @param success 成功回调
 @param failure 失败回调
 */
-(void)getMemberListWithDeviceId:(NSString *)deviceId token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure;


/**
 移除用户权限

 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(void)removeBindRoleWithParams:(NSDictionary *)params success:(DeviceSuccess)success failure:(DeviceFailure)failure;
/**
 移除用户权限  (旧)
 
 @param deviceId 设备id
 @param enduserid 用户id
 @param token token
 @param success 成功回调
 @param failure 失败回调
 */
-(void)removeBindRoleWithDeviceId:(NSString *)deviceId enduserid:(NSString *)enduserid token:(NSString *)token success:(DeviceSuccess)success failure:(DeviceFailure)failure;
@end
