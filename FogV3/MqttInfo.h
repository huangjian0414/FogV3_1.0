//
//  MqttInfo.h
//  FogV3
//
//  Created by 黄坚 on 2017/10/20.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MqttInfo : NSObject
@property (nonatomic ,strong) NSString *password;

@property (nonatomic ,strong) NSString *endpoint;

@property (nonatomic ,assign) NSInteger mqttport;

@property (nonatomic ,strong) NSString *loginname;

@property (nonatomic ,strong) NSString *clientid;

@property (nonatomic ,strong) NSString *mqtthost;
@end
