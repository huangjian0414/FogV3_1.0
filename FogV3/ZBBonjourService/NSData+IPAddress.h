//
//  NSData+IPAddress.h
//  MiCO2
//
//  Created by WuZhengBin on 16/5/18.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface NSData (IPAddress)
- (NSString *)ipAddress;
@end
