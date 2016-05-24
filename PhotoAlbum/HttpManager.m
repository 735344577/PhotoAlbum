//
//  HttpManager.m
//  PhotoAlbum
//
//  Created by nice on 16/5/23.
//  Copyright © 2016年 NICE. All rights reserved.
//

#import "HttpManager.h"
#import <AFNetworking/AFNetworking.h>

@interface HttpManager ()

@property (nonatomic, strong) AFHTTPSessionManager * manager;

@end

@implementation HttpManager

+ (instancetype)shareManager{
    static HttpManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HttpManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", nil];
        
    }
    return self;
}

- (void)requestWithMethod:(RequestType)type url:(NSString *)url params:(NSDictionary *)params success:(void(^)(id result))success failed:(void(^)(NSString * error))failed{
    switch (type) {
        case GET:
        {
            [_manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failed([error debugDescription]);
            }];
        }
            break;
        case POST:{
            [_manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failed([error debugDescription]);
            }];
        }
            break;
            
            
        default:
            break;
    }
}


@end
