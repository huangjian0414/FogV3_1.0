//
//  FogEasyLinkManager.m
//  FogV3
//
//  Created by 黄坚 on 2017/10/20.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import "FogEasyLinkManager.h"
//#import "EasyLink.h"

@interface FogEasyLinkManager ()
//@property (nonatomic,strong)EASYLINK *easylink;

@end
@implementation FogEasyLinkManager

+(instancetype)sharedInstance
{
    static FogEasyLinkManager *easylinkManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        easylinkManager=[[FogEasyLinkManager alloc]init];
    });
    return easylinkManager;
    
}
//-(NSString *)getSSID
//{
//    return [EASYLINK ssidForConnectedNetwork];
//}
//-(void)startEasyLinkWithPassword:(NSString *)password
//{
//    NSData *ssidData=[EASYLINK ssidDataForConnectedNetwork];
//    NSMutableDictionary *innerParams=[NSMutableDictionary dictionary];
//    [innerParams setObject:ssidData forKey:KEY_SSID];
//    [innerParams setObject:password forKey:KEY_PASSWORD];
//    [innerParams setObject:[NSNumber numberWithBool:YES] forKey:KEY_DHCP];
//    self.easylink=[[EASYLINK alloc]init];
//    [self.easylink prepareEasyLink:innerParams info:nil mode:EASYLINK_V2_PLUS];
//    [self.easylink transmitSettings];
//}
//-(void)stopEasyLink
//{
//    [self.easylink stopTransmitting];
//    [self.easylink unInit];
//}
@end
