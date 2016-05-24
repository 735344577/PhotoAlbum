//
//  PhotoAlbumViewController.h
//  PhotoAlbum
//
//  Created by nice on 16/5/24.
//  Copyright © 2016年 NICE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlbumViewController : UIViewController
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) NSMutableArray * array;
@end
