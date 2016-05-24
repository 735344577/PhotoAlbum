//
//  CollectionViewCell.h
//  PhotoAlbum
//
//  Created by nice on 16/5/23.
//  Copyright © 2016年 NICE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoItem;
@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) PhotoItem * item;

@end
