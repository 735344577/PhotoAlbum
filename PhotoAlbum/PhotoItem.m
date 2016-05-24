//
//  PhotoItem.m
//  PhotoAlbum
//
//  Created by nice on 16/5/23.
//  Copyright © 2016年 NICE. All rights reserved.
//

#import "PhotoItem.h"
#import "HttpManager.h"
@implementation PhotoItem

+ (instancetype)creatWithDic:(NSDictionary *)dic{
    PhotoItem * item = [[PhotoItem alloc] initWithDic:dic];
    return item;
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
//        self.z_pic_url = dic[@"<#string#>"];
//        self.q_pic_url = dic[@"<#string#>"];
//        self.showBigImage = false;
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    
}

//- (void)setShowBigImage:(BOOL)showBigImage{
//    _showBigImage = showBigImage;
//}


+ (void)getObjectWithPage:(NSInteger)page result:(void (^)(id result, NSString * error))results{
    NSString * offset = [@(page) stringValue];
    NSDictionary * parms = @{@"offset":offset, @"limit" : @"30", @"access_token" : @"b92e0c6fd3ca919d3e7547d446d9a8c2"};
    [[HttpManager shareManager] requestWithMethod:GET url:@"http://mobapi.meilishuo.com/2.0/twitter/popular.json" params:parms success:^(id result) {
        results(result, nil);
    } failed:^(NSString *error) {
        results(nil, error);
    }];
}

@end
