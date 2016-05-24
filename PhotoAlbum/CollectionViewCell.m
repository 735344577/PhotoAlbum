//
//  CollectionViewCell.m
//  PhotoAlbum
//
//  Created by nice on 16/5/23.
//  Copyright © 2016年 NICE. All rights reserved.
//

#import "CollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PhotoItem.h"
@interface CollectionViewCell ()



@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_imageView.image) {
        return ;
    }
    
    UIImage * image = _imageView.image;
    if (!image) {
        return ;
    }
    CGFloat width = self.item.showBigImage ? [UIScreen mainScreen].bounds.size.width : self.frame.size.width;
    CGFloat height = width * image.size.height / image.size.width;
    CGFloat y = (self.frame.size.height - height) * 0.5;
    _imageView.frame = CGRectMake(0, y, width, height);
}


- (void)setItem:(PhotoItem *)item{
    if (!item) {
        return ;
    }
    if (item.showBigImage) {
        NSURL * url = [NSURL URLWithString:item.z_pic_url];
        UIImage * placeholderImage =  [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:item.q_pic_url];
        if (!placeholderImage) {
            placeholderImage = [UIImage imageNamed:@"empty_picture"];
        }
        [_imageView sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self layoutIfNeeded];
        }];
        
    }else{
        NSURL * url = [NSURL URLWithString:item.q_pic_url];
        UIImage * placeholderImage =  [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:item.q_pic_url];
        if (!placeholderImage) {
            placeholderImage = [UIImage imageNamed:@"empty_picture"];
        }
        [_imageView sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self layoutIfNeeded];
        }];
    }
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
