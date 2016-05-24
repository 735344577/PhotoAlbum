//
//  PhotoItem.h
//  PhotoAlbum
//
//  Created by nice on 16/5/23.
//  Copyright © 2016年 NICE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoItem : NSObject

@property (nonatomic, copy) NSString * q_pic_url;

@property (nonatomic, copy) NSString * z_pic_url;

@property (nonatomic, assign) BOOL showBigImage;

+ (instancetype)creatWithDic:(NSDictionary *)dic;

+ (void)getObjectWithPage:(NSInteger)page result:(void (^)(id result, NSString * error))results;

@end
