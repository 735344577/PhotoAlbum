//
//  ModalAnimationDelegate.m
//  PhotoAlbum
//
//  Created by nice on 16/5/24.
//  Copyright © 2016年 NICE. All rights reserved.
//

#import "ModalAnimationDelegate.h"
#import "ViewController.h"
#import "PhotoAlbumViewController.h"
#import "CollectionViewCell.h"
@implementation ModalAnimationDelegate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _isPresentAnimationing = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _isPresentAnimationing = NO;
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    _isPresentAnimationing ? [self presentViewAnimation:transitionContext] : [self dismissViewAnimation:transitionContext];
    
}

- (void)presentViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView * destinationView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:destinationView];
    PhotoAlbumViewController * destinationVC = (PhotoAlbumViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSIndexPath * indexPath = destinationVC.indexPath;
    ViewController * VC = (ViewController *) [(UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] topViewController];
    UICollectionView * currentCollectionView = VC.collectionView;
    CollectionViewCell * selectedCell = (CollectionViewCell *)[currentCollectionView cellForItemAtIndexPath:indexPath];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = selectedCell.imageView.image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    CGRect originFrame = [currentCollectionView convertRect:selectedCell.frame toView:[UIApplication sharedApplication].keyWindow];
    imageView.frame = originFrame;
    [containerView addSubview:imageView];
    CGRect endFrame = [self coverImageFrameToFullScreenFrame:selectedCell.imageView.image];
    destinationView.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        imageView.frame = endFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        [UIView animateWithDuration:0.5 animations:^{
            destinationView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
    }];
}

- (void)dismissViewAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * contentView = [transitionContext containerView];
    PhotoAlbumViewController * dismissVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UICollectionView * presentView = dismissVC.collectionView;
    CollectionViewCell * dismissCell = [[presentView visibleCells] firstObject];
    UIImageView * animateImageView = [[UIImageView alloc] init];
    animateImageView.contentMode = UIViewContentModeScaleAspectFill;
    animateImageView.clipsToBounds = YES;
    animateImageView.image = dismissCell.imageView.image;
    animateImageView.frame = dismissCell.imageView.frame;
    [contentView addSubview:animateImageView];
    
    NSIndexPath * indexPath = [presentView indexPathForCell:dismissCell];
    UICollectionView * originView = [(ViewController *)[(UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] topViewController] collectionView];
    CollectionViewCell * originCell = (CollectionViewCell *)[originView cellForItemAtIndexPath:indexPath];
    if (originView == nil) {
        [originView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        [originView layoutIfNeeded];
    }
    originCell = (CollectionViewCell *)[originView cellForItemAtIndexPath:indexPath];
    CGRect originFrame = [originView convertRect:originCell.frame toView:[UIApplication sharedApplication].keyWindow];
    [UIView animateWithDuration:1 animations:^{
        animateImageView.frame = originFrame;
        fromView.alpha = 0;
    } completion:^(BOOL finished) {
        [animateImageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (CGRect)coverImageFrameToFullScreenFrame:(UIImage *)image {
    if (image) {
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        CGFloat h = w * image.size.height / image.size.width;
        CGFloat x = 0;
        CGFloat y = ([UIScreen mainScreen].bounds.size.height - h) * 0.5;
        return  CGRectMake(x, y, w, h);
    }else{
        return CGRectZero;
    }
}

@end
