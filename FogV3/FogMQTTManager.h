//
//  FogMQTTManager.h
//  FogV3
//
//  Created by 黄坚 on 2017/10/20.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MqttInfo;

typedef void(^MqttSuccess)(id responseObject);
typedef void(^MqttFailure)(NSError *error);
typedef void(^MqttReturn)(NSError *error,NSArray<NSNumber *> *gQoss);

typedef NS_ENUM(UInt8, QosLevel) {
    QosLevelAtMostOnce = 0,
    QosLevelAtLeastOnce = 1,
    QosLevelExactlyOnce = 2
};
@protocol FogMQTTDelegate <NSObject>

-(void)reciveData:(NSData *)data onTopic:(NSString *)topic qos:(QosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid;

@end

@interface FogMQTTManager : NSObject

@property (nonatomic,weak)id<FogMQTTDelegate>delegate;
@property (nonatomic,copy)MqttSuccess mqttSuccess;
@property (nonatomic,copy)MqttFailure mqttFailure;
@property (nonatomic,copy)MqttReturn mqttReturn;



+(instancetype)sharedInstance;

/**
 获取mqtt信息
 
 @param token token
 @param mqttSuccess 成功回调
 @param mqttFailure 失败回调
 */
-(void)getMqttInfoWithToken:(NSString *)token success:(MqttSuccess)mqttSuccess failure:(MqttFailure)mqttFailure;

/**
 监听远程设备 mqtt connect
 
 @param mqttInfo mqtt信息
 @param usingSSL 是否使用SSL
 @param mqttFailure 连接回调
 */
-(void)startListenDeviceWithMqttInfo:(MqttInfo *)mqttInfo usingSSL:(BOOL)usingSSL connectHandler:(MqttFailure)mqttFailure;

/**
 增加订阅通道
 
 @param topic 主题
 @param qosLevel 消息质量
 @param mqttReturn mqtt回调
 */
-(void)addDeviceListenerWithTopic:(NSString *)topic atLevel:(QosLevel)qosLevel mqttReturn:(MqttReturn)mqttReturn;

/**
 发送指令
 
 @param data 发送数据
 @param topic 主题
 @param retainFlag if YES, data is stored on the MQTT broker until overwritten by the next publish with retainFlag = YES
 @param qosLevel specifies the Quality of Service for the publish
 @param mqttFailure mqtt回调
 */
-(void)sendCommandWithData:(NSData *)data  onTopic:(NSString *)topic retain:(BOOL)retainFlag qos:(QosLevel)qosLevel sendReturn:(MqttFailure)mqttFailure;

/**
 移除订阅通道
 
 @param topic 主题
 */
-(void)removeDeviceListenerWithTopic:(NSString *)topic connectHandler:(MqttFailure)mqttFailure;

-(void)stopListenDevice;
@end
