//
//  NSData+IPAddress.m
//  MiCO2
//
//  Created by WuZhengBin on 16/5/18.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "NSData+IPAddress.h"


@implementation NSData (IPAddress)
- (NSString *)ipAddress {
    struct sockaddr *addr = (struct sockaddr *)[self bytes];
    if(addr->sa_family == AF_INET) {
        char *address = inet_ntoa(((struct sockaddr_in *)addr)->sin_addr);
        if (address)
            return [NSString stringWithCString: address encoding: NSASCIIStringEncoding];
    }
    else if(addr->sa_family == AF_INET6) {
        struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)addr;
        char straddr[INET6_ADDRSTRLEN];
        inet_ntop(AF_INET6, &(addr6->sin6_addr), straddr,
                  sizeof(straddr));
        return [NSString stringWithCString: straddr encoding: NSASCIIStringEncoding];
    }
    return nil;
}
@end
