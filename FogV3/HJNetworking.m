//
//  HJNetworking.m
//  mxchipApp
//
//  Created by 黄坚 on 2017/11/30.
//  Copyright © 2017年 黄坚. All rights reserved.
//

#import "HJNetworking.h"

@implementation HJNetworking
+(instancetype)sharedInstance
{
    static HJNetworking *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[HJNetworking alloc]init];
        instance.generalServer=@"";
        instance.generalHeader=nil;
        instance.showRequestLog=NO;
    });
    return instance;
}
-(void)hj_RequestWithType:(HJREQUEST_TYPE)type Api:(NSString *)api Params:(NSDictionary *)params Header:(NSDictionary *)header success:(Success)success failure:(Failure)failure;
{
    if (type==HJHTTPMethod_GET) {
        [self GetRequestWithApi:api Params:params Header:header success:success failure:failure];
    }else if (type==HJHTTPMethod_POST)
    {
        [self PostRequestWithApi:api Params:params Header:header success:success failure:failure];
    }else if (type==HJHTTPMethod_PUT)
    {
        [self PUTRequestWithApi:api Params:params Header:header success:success failure:failure];
    }else if (type==HJHTTPMethod_DELETE)
    {
        [self DeleteRequestWithApi:api Params:params Header:header success:success failure:failure];
    }
    
}
-(void)GetRequestWithApi:(NSString *)api Params:(NSDictionary *)params Header:(NSDictionary *)header success:(Success)success failure:(Failure)failure
{
    NSString *path=[HJNetworking sharedInstance].generalServer;
    path=[NSString stringWithFormat:@"%@%@",path,api];
    if (params) {
        NSString *param=[self dealWithParam:params];
         path=[NSString stringWithFormat:@"%@?%@",path,param];
    }
    NSString*  pathStr = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (self.showRequestLog) {
        NSLog(@"\n============ [HJNetworking Info] ============\nrequest url: %@ \nrequest headers: \n%@ \nrequest parameters: \n%@ \n==========================================\n", pathStr, header, params);
    }
    NSURL *url = [NSURL URLWithString:pathStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (header) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [request setValue:obj forHTTPHeaderField:key];
        }];
    }
    request.timeoutInterval=30;
    request.HTTPMethod=@"GET";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                if (failure) {
                    failure(error);
                    if (self.showRequestLog) {
                        NSLog(@"\n============ [HJNetworkingResponse Error] ===========\nresponse data: \n%@\n==========================================\n", error);
                    }
                }
            }else
            {
                id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                if (success) {
                    success(jsonData);
                    if (self.showRequestLog) {
                        NSLog(@"\n============ [HJNetworkingResponse Data] ===========\nresponse data: \n%@\n==========================================\n", jsonData);
                    }
                }
            }
        });
    }];
    //开始请求
    [task resume];
}
-(void)PostRequestWithApi:(NSString *)api Params:(NSDictionary *)params Header:(NSDictionary *)header success:(Success)success failure:(Failure)failure
{
    NSString *path=[HJNetworking sharedInstance].generalServer;
    path=[NSString stringWithFormat:@"%@%@",path,api];
    NSString*  pathStr = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:pathStr];
    if (self.showRequestLog) {
        NSLog(@"\n============ [HJNetworking Info] ============\nrequest url: %@ \nrequest headers: \n%@ \nrequest parameters: \n%@ \n==========================================\n", pathStr, header, params);
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (header) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [request setValue:obj forHTTPHeaderField:key];
        }];
    }
    request.timeoutInterval=30;
    [request setHTTPMethod:@"POST"];
    if (params &&[NSJSONSerialization isValidJSONObject:params]) {
        NSData *jsonData = [[self dealWithParam:params]dataUsingEncoding:NSUTF8StringEncoding];
        [request  setHTTPBody:jsonData];
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (failure) {
                    failure(error);
                    if (self.showRequestLog) {
                        NSLog(@"\n============ [HJNetworkingResponse Error] ===========\nresponse data: \n%@\n==========================================\n", error);
                    }
                }
            }else
            {
            id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (success) {
                    success(jsonData);
                    if (self.showRequestLog) {
                        NSLog(@"\n============ [HJNetworkingResponse Data] ===========\nresponse data: \n%@\n==========================================\n", jsonData);
                    }
                }
            }
        });
        
    }];
    //开始请求
    [task resume];
    
}

-(void)PUTRequestWithApi:(NSString *)api Params:(NSDictionary *)params Header:(NSDictionary *)header success:(Success)success failure:(Failure)failure
{
    NSString *path=[HJNetworking sharedInstance].generalServer;
    path=[NSString stringWithFormat:@"%@%@",path,api];
    NSString*  pathStr = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:pathStr];
    if (self.showRequestLog) {
        NSLog(@"\n============ [HJNetworking Info] ============\nrequest url: %@ \nrequest headers: \n%@ \nrequest parameters: \n%@ \n==========================================\n", pathStr, header, params);
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval=30;
    if (header) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [request setValue:obj forHTTPHeaderField:key];
        }];
    }
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"PUT";
    NSData *jsonData;
    if (params &&[NSJSONSerialization isValidJSONObject:params]) {
        jsonData = [[self dealWithParam:params] dataUsingEncoding:NSUTF8StringEncoding];
        [request  setHTTPBody:jsonData];
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (failure) {
                    failure(error);
                    if (self.showRequestLog) {
                        NSLog(@"\n============ [HJNetworkingResponse Error] ===========\nresponse data: \n%@\n==========================================\n", error);
                    }
                }
            }else
            {
                id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (success) {
                    success(jsonData);
                    if (self.showRequestLog) {
                        NSLog(@"\n============ [HJNetworkingResponse Data] ===========\nresponse data: \n%@\n==========================================\n", jsonData);
                    }
                    
                }
            }
        });

    }];
    //开始请求
    
    [task resume];
    
}
-(void)DeleteRequestWithApi:(NSString *)api Params:(NSDictionary *)params Header:(NSDictionary *)header success:(Success)success failure:(Failure)failure
{
    NSString *path=[HJNetworking sharedInstance].generalServer;
    path=[NSString stringWithFormat:@"%@%@",path,api];
    if (params) {
        NSString *param=[self dealWithParam:params];
        path=[NSString stringWithFormat:@"%@?%@",path,param];
    }
    NSString*  pathStr = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:pathStr];
    if (self.showRequestLog) {
        NSLog(@"\n============ [HJNetworking Info] ============\nrequest url: %@ \nrequest headers: \n%@ \nrequest parameters: \n%@ \n==========================================\n", pathStr, header, params);
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval=30;
    if (header) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [request setValue:obj forHTTPHeaderField:key];
        }];
    }
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"DELETE";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (failure) {
                    failure(error);
                    if (self.showRequestLog) {
                        NSLog(@"\n============ [HJNetworkingResponse Error] ===========\nresponse data: \n%@\n==========================================\n", error);
                    }
                }
            }else
            {
                id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (success) {
                    success(jsonData);
                    if (self.showRequestLog) {
                         NSLog(@"\n============ [HJNetworkingResponse Data] ===========\nresponse data: \n%@\n==========================================\n", jsonData);
                    }
                   
                }
            }
        });
        
    }];
    //开始请求
    [task resume];
    
}
// 处理字典参数
-(NSString *)dealWithParam:(NSDictionary *)param
{
    NSMutableString *result = [NSMutableString string];
    [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"%@=%@&",key,obj];
        
        [result appendString:str];
    }];
    
    return [result substringWithRange:NSMakeRange(0, result.length-1)];
    
}
    
@end
