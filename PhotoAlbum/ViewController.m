//
//  ViewController.m
//  PhotoAlbum
//
//  Created by nice on 16/5/23.
//  Copyright © 2016年 NICE. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "PhotoItem.h"
#import "PhotoAlbumViewController.h"
#import "ModalAnimationDelegate.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray * array;
@property (nonatomic, strong) ModalAnimationDelegate * modalDelegate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 5 * 20) / 4;
    layout.itemSize = CGSizeMake(width, width);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = layout;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 20, 20, 20);
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
    self.array = @[].mutableCopy;
    [PhotoItem getObjectWithPage:0 result:^(id result, NSString *error) {
        NSArray * arr = result[@"data"];
        for (NSDictionary * dic in arr) {
            [self.array addObject:[PhotoItem creatWithDic:dic]];
        }
        [self.collectionView reloadData];
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class]) forIndexPath:indexPath];
    PhotoItem * item = [_array objectAtIndex:indexPath.item];
    item.showBigImage = NO;
    cell.item = item;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 != 0) {
        cell.transform = CGAffineTransformTranslate(cell.transform, CGRectGetWidth(self.view.frame) / 2, 0);
    }else{
        cell.transform = CGAffineTransformTranslate(cell.transform, -CGRectGetWidth(self.view.frame) / 2, 0);
    }
    cell.alpha = 0.0;
    [UIView animateWithDuration:0.7 animations:^{
        cell.transform = CGAffineTransformIdentity;
        cell.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoAlbumViewController * photoVC = [[PhotoAlbumViewController alloc] init];
    photoVC.indexPath = indexPath;
    photoVC.array = _array;
    NSLog(@"indexPath1 = %@", indexPath);
    photoVC.transitioningDelegate = self.modalDelegate;
    photoVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:photoVC animated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ModalAnimationDelegate *)modalDelegate{
    if (!_modalDelegate) {
        _modalDelegate = [[ModalAnimationDelegate alloc] init];
        
    }
    return _modalDelegate;
}

@end
