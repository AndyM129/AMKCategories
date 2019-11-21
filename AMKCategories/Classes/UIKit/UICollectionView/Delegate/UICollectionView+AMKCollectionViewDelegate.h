//
//  UICollectionView+AMKCollectionViewDelegate.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/11/21.
//

#import <UIKit/UIKit.h>

/// UICollectionView 代理扩展
@protocol AMKCollectionViewDelegate <UICollectionViewDelegate>

@optional

/// 即将刷新数据
- (void)amk_collectionViewWillReloadData:(UICollectionView *_Nullable)collectionView;

/// 已刷新数据
- (void)amk_collectionViewDidReloadData:(UICollectionView *_Nullable)collectionView;

@end
