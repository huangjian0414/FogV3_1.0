//
//  HJNetworking.h
//  mxchipApp
//
//  Created by 黄坚 on 2017/11/30.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(id responseObject);
typedef void(^Failure)(NSError *error);
typedef NS_ENUM(NSInteger,HJREQUEST_TYPE)
{
    HJHTTPMethod_GET,
    HJHTTPMethod_POST,
    HJHTTPMethod_PUT,
    HJHTTPMethod_DELETE
};
@interface HJNetworking : NSObject
+(instancetype)sharedInstance;

@property (nonatomic,copy)NSString *generalServer;
@property (nonatomic,strong)NSDictionary *generalHeader;
@property (nonatomic,assign)BOOL showRequestLog;

-(void)hj_RequestWithType:(HJREQUEST_TYPE)type Api:(NSString *)api Params:(NSDictionary *)dict Header:(NSDictionary *)header success:(Success)success failure:(Failure)failure;

@end
