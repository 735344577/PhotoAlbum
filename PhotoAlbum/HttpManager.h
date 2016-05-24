//
//  HttpManager.h
//  PhotoAlbum
//
//  Created by nice on 16/5/23.
//  Copyright © 2016年 NICE. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    GET,
    POST,
} RequestType;

@interface HttpManager : NSObject

+ (instancetype)shareManager;

- (void)requestWithMethod:(RequestType)type url:(NSString *)url params:(NSDictionary *)params success:(void(^)(id result))success failed:(void(^)(NSString * error))failed;

@end
