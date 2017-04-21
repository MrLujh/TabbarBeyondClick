//
//  CESHttpTool.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/12.
//  Copyright © 2016年 卢家浩. All rights reserved.
//


#import "CESHttpTool.h"

static NSString * kBaseUrl = SERVER_HOST;

@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@implementation AFHttpClient

+ (instancetype)sharedClient {
    
    static AFHttpClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:configuration];
        //接收参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //设置超时时间
        client.requestSerializer.timeoutInterval = 15;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    
    return client;
}

@end

@implementation CESHttpTool

+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure {
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    [[AFHttpClient sharedClient] GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
    
}

+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure {
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    
    [[AFHttpClient sharedClient] POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
         failure(error);
    }];
    
}

@end
