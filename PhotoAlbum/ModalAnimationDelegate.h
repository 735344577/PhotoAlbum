//
//  ModalAnimationDelegate.h
//  PhotoAlbum
//
//  Created by nice on 16/5/24.
//  Copyright © 2016年 NICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ModalAnimationDelegate : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresentAnimationing;

@end
