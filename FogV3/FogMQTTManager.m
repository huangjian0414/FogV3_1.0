//
//  FogMQTTManager.m
//  FogV3
//
//  Created by 黄坚 on 2017/10/20.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import "FogMQTTManager.h"
#import <XMNetworking.h>
#import <MQTTClient/MQTTClient.h>
#import "MqttInfo.h"

@interface FogMQTTManager ()<MQTTSessionDelegate>
@property (nonatomic,strong)MQTTSession *mqttSession;
@end
@implementation FogMQTTManager
+(instancetype)sharedInstance
{
    static FogMQTTManager *mqttManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mqttManager=[[FogMQTTManager alloc]init];
    });
    return mqttManager;
}


-(void)getMqttInfoWithToken:(NSString *)token success:(MqttSuccess)mqttSuccess failure:(MqttFailure)mqttFailure
{
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api=@"/v3/enduser/mqttInfo/";
        request.httpMethod=kXMHTTPMethodGET;
        request.headers=@{@"Authorization":[NSString stringWithFormat:@"JWT %@", token]};
        
    } onSuccess:^(id  _Nullable responseObject) {
        mqttSuccess(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        mqttFailure(error);
    }];
}

-(void)startListenDeviceWithMqttInfo:(MqttInfo *)mqttInfo usingSSL:(BOOL)usingSSL connectHandler:(MqttFailure)mqttFailure
{
    MQTTCFSocketTransport *transport=[[MQTTCFSocketTransport alloc]init];
    transport.host=mqttInfo.mqtthost;
    transport.port=(UInt32)mqttInfo.mqttport;
    if (!self.mqttSession) {
        self.mqttSession=[[MQTTSession alloc]init];
    }
    self.mqttSession.transport=transport;
    self.mqttSession.delegate=self;
    
    self.mqttSession.userName = mqttInfo.loginname;
    self.mqttSession.clientId = mqttInfo.clientid;
    self.mqttSession.password = mqttInfo.password;
    [self.mqttSession connectToHost:transport.host port:transport.port usingSSL:usingSSL connectHandler:^(NSError *error) {

        mqttFailure(error);
    }];
//    [self.mqttSession connectWithConnectHandler:^(NSError *error) {
//        mqttFailure(error);
//    }];
}
-(void)newMessage:(MQTTSession *)session data:(NSData *)data onTopic:(NSString *)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid
{
    if ([self.delegate respondsToSelector:@selector(reciveData:onTopic:qos:retained:mid:)]) {
        [self.delegate reciveData:data onTopic:topic qos:(QosLevel)qos retained:retained mid:mid];
    }
}

-(void)addDeviceListenerWithTopic:(NSString *)topic atLevel:(QosLevel)qosLevel mqttReturn:(MqttReturn)mqttReturn
{
    [self.mqttSession subscribeToTopic:topic atLevel:(MQTTQosLevel)qosLevel subscribeHandler:^(NSError *error, NSArray<NSNumber *> *gQoss) {
        mqttReturn(error,gQoss);
        
    }];
}
-(void)sendCommandWithData:(NSData *)data  onTopic:(NSString *)topic retain:(BOOL)retainFlag qos:(QosLevel)qosLevel sendReturn:(MqttFailure)mqttFailure
{
    [self.mqttSession publishData:data onTopic:topic retain:retainFlag qos:(MQTTQosLevel)qosLevel publishHandler:^(NSError *error) {
        mqttFailure(error);
        
    }];
}

-(void)removeDeviceListenerWithTopic:(NSString *)topic connectHandler:(MqttFailure)mqttFailure
{
    [self.mqttSession unsubscribeTopic:topic unsubscribeHandler:^(NSError *error) {
        mqttFailure(error);
    }];
}
-(void)stopListenDevice
{
    [self.mqttSession close];
}
@end
