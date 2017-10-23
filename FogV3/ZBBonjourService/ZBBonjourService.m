//
//  ZBBonjourService.m
//  SmartCurtain
//
//  Created by WuZhengBin on 2016/8/17.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "ZBBonjourService.h"
#import "NSData+IPAddress.h"
#import "NSDictionary+ZBAdd.h"

@interface NSMutableArray (ZBAdd)
- (NSArray *)removeSameObject;
@end

@implementation NSMutableArray (ZBAdd)
- (NSArray *)removeSameObject {
    NSSet *set = [NSSet setWithArray:self];
    return [set allObjects];
}
@end

static NSString * const KEY_OF_NETSERVICE = @"NetService";
static NSString * const KEY_OF_RECORDDATA = @"RecordData";

@interface ZBBonjourService () <NSNetServiceDelegate, NSNetServiceBrowserDelegate>
@property (nonatomic, strong) NSMutableArray *devicesArray;
@property (nonatomic, strong) NSNetServiceBrowser *serviceBrowser;

@property (nonatomic, copy) NSString *serviceDomain;
@end

@implementation ZBBonjourService

+ (instancetype)sharedInstance {
    static ZBBonjourService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZBBonjourService alloc] init];
        
    });
    return instance;
}

- (void)startSearchDevicesWithService:(NSString *)serviceType inDomain:(NSString *)domain {
    [self.devicesArray removeAllObjects];
    self.serviceType = [serviceType copy];
    self.serviceDomain = [domain copy];
    
    [self.serviceBrowser searchForServicesOfType:serviceType inDomain:domain];
}
-(void)setServiceType:(NSString *)serviceType
{
    _serviceType=serviceType;
}
- (void)startSearchDevice {
    if (self.serviceType.length == 0) {
        self.serviceType = @"_easylink._tcp";
    }
    if (self.serviceDomain.length == 0) {
        self.serviceDomain = @"local";
    }
    //self.serviceType = @"_easylink_config._tcp";
    //self.serviceDomain = @"local";
    [self.serviceBrowser searchForServicesOfType:self.serviceType inDomain:self.serviceDomain];
}

- (void)stopSearchDevice {
    [self.serviceBrowser stop];
    [self.devicesArray removeAllObjects];
}

#pragma mark - NSNetServiceBrowser Delegate
- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict safeSetObject:service forKey:KEY_OF_NETSERVICE];
    
    NSArray *services = [self.devicesArray valueForKey:@"NetService"];
    if (![services containsObject:service]) {
        [self.devicesArray addObject:dict];
        service.delegate = self;
        [service resolveWithTimeout:1.0];
        
        if (!moreComing) {
            //        [self.delegate bonjourService:self didReturnDevicesArray:self.devicesArray];
        }
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing {
    
    [self.devicesArray enumerateObjectsUsingBlock:^(NSMutableDictionary *dic, NSUInteger idx, BOOL * stop) {
        NSNetService *existedService = dic[KEY_OF_NETSERVICE];
        if ([[existedService name] isEqualToString:[service name]]) {
            [self.devicesArray removeObject:dic];
        }
    }];
    
    if (!moreComing) {
        // 可以往外发送数据
        [self.delegate bonjourService:self didReturnDevicesArray:self.devicesArray];
    }
}

#pragma mark - 
#pragma mark NetServiceDelegate
- (void)netServiceDidResolveAddress:(NSNetService *)service {
    //    assert(service == self.currentResolve);
    
    NSDictionary *dict = [NSNetService dictionaryFromTXTRecordData:[service TXTRecordData]];
    NSMutableDictionary *prettyDict = [NSMutableDictionary dictionary];
    [prettyDict safeSetObject:@(service.port) forKey:@"Port"];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSData *data, BOOL *stop) {
        NSString *stringFromData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        [prettyDict safeSetObject:stringFromData forKey:key];
    }];
    [prettyDict setObject:[service name] forKey:@"Name"];
    [prettyDict safeSetObject:[[[service addresses] firstObject] ipAddress] forKey:@"IP"];
    for (NSMutableDictionary *dic in self.devicesArray) {
        if ([dic valueForKey:@"NetService"] == service) {
            [dic setObject:prettyDict forKey:KEY_OF_RECORDDATA];
        }
    }
    
    // 可以往外发送数据
    [self.delegate bonjourService:self didReturnDevicesArray:self.devicesArray];
}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary<NSString *,NSNumber *> *)errorDict {
    
}

#pragma mark - 
#pragma mark Lazy initial
- (NSMutableArray *)devicesArray {
    if (!_devicesArray) {
        _devicesArray = [NSMutableArray array];
    }
    return _devicesArray;
}

- (NSNetServiceBrowser *)serviceBrowser {
    if (!_serviceBrowser) {
        _serviceBrowser = [[NSNetServiceBrowser alloc] init];
        _serviceBrowser.delegate = self;
    }
    return _serviceBrowser;
}

@end
