//
//  UICollectionView+AMKCollectionViewDelegate.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/11/21.
//

#import "UICollectionView+AMKCollectionViewDelegate.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

@interface UICollectionView (AMKCollectionViewDelegate)

@end

@implementation UICollectionView (AMKCollectionViewDelegate)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UICollectionView amk_swizzleInstanceMethod:@selector(reloadData) withMethod:@selector(AMKCollectionViewDelegate_UICollectionView_reloadData)];
    });
}

#pragma mark - Init Methods

#pragma mark - Properties

#pragma mark - Layout Subviews

#pragma mark - Public Methods

- (void)AMKCollectionViewDelegate_UICollectionView_reloadData {
    [self AMKCollectionViewDelegate_UICollectionView_delegatePerformSelector:@selector(amk_collectionViewWillReloadData:) withObject:self];
    [self AMKCollectionViewDelegate_UICollectionView_reloadData];
    [self AMKCollectionViewDelegate_UICollectionView_delegatePerformSelector:@selector(amk_collectionViewDidReloadData:) withObject:self];
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

- (BOOL)AMKCollectionViewDelegate_UICollectionView_delegatePerformSelector:(SEL)aSelector withObject:(id)anArgument {
    if (!self.delegate) return NO;
    if (![self.delegate conformsToProtocol:@protocol(AMKCollectionViewDelegate)]) return NO;
    if (![self.delegate respondsToSelector:aSelector]) return NO;

#   pragma clang diagnostic push
#   pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.delegate performSelector:aSelector withObject:anArgument];
#   pragma clang diagnostic pop
    return YES;
}

@end
