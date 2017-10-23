//
//  ZBBonjourService.h
//  SmartCurtain
//
//  Created by WuZhengBin on 2016/8/17.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZBBonjourService;

@protocol ZBBonjourServiceDelegate <NSObject>
@optional
- (void)bonjourService:(ZBBonjourService *)service didReturnDevicesArray:(NSArray *)array;
@end

@interface ZBBonjourService : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic, weak) id<ZBBonjourServiceDelegate> delegate;
@property (nonatomic, copy) NSString *serviceType;
- (void)startSearchDevice;
- (void)stopSearchDevice;
@end
