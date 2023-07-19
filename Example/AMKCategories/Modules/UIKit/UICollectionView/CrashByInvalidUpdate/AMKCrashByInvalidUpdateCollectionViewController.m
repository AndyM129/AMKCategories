//
//  AMKCrashByInvalidUpdateCollectionViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/19.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMKCrashByInvalidUpdateCollectionViewController.h"

@interface AMKCrashByInvalidUpdateCollectionViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong, readwrite, nullable) UICollectionView *collectionView;
@property (nonatomic, strong, readwrite, nullable) NSMutableArray<NSMutableArray *> *dataSource;
@end

@implementation AMKCrashByInvalidUpdateCollectionViewController

//+ (void)load {
//    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
//        [NSNotificationCenter.defaultCenter removeObserver:token];
//        [(UINavigationController *)UIApplication.sharedApplication.delegate.window.rootViewController pushViewController:self.new animated:YES];
//    }];
//}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor?:[UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[
        [UIBarButtonItem.alloc initWithTitle:@"Crash0" style:UIBarButtonItemStylePlain target:self action:@selector(crashByInvalidUpdate_0:)],
        [UIBarButtonItem.alloc initWithTitle:@"Crash1" style:UIBarButtonItemStylePlain target:self action:@selector(crashByInvalidUpdate_1:)],
        [UIBarButtonItem.alloc initWithTitle:@"Crash2" style:UIBarButtonItemStylePlain target:self action:@selector(crashByInvalidUpdate_2:)],
        [UIBarButtonItem.alloc initWithTitle:@"Crash3" style:UIBarButtonItemStylePlain target:self action:@selector(crashByInvalidUpdate_3:)],
        [UIBarButtonItem.alloc initWithTitle:@"Reload" style:UIBarButtonItemStylePlain target:self.collectionView action:@selector(reloadData)]
    ];
    [self.collectionView reloadData];
}

#pragma mark - Getters & Setters

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *collectionViewFlowLayout = [UICollectionViewFlowLayout.alloc init];
        _collectionView = [UICollectionView.alloc initWithFrame:self.view.bounds collectionViewLayout:collectionViewFlowLayout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(UICollectionReusableView.class)];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(UICollectionReusableView.class)];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - Data & Networking

- (NSMutableArray<NSMutableArray *> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
        [_dataSource addObject:@[@0, @1, @2].mutableCopy];
    }
    return _dataSource;
}

#pragma mark - Layout Subviews

#pragma mark - Action Methods

// 2023-07-19 11:43:35.418265+0800 AMKCategories_Example[29884:11021065] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: invalid number of items in section 0. The number of items contained in an existing section after the update (5) must be equal to the number of items contained in that section before the update (3), plus or minus the number of items inserted or deleted from that section (0 inserted, 0 deleted) and plus or minus the number of items moved into or out of that section (0 moved in, 0 moved out). Collection view: <UICollectionView: 0x106020800; frame = (0 0; 414 808); clipsToBounds = YES; autoresize = W+H; gestureRecognizers = <NSArray: 0x282268c60>; backgroundColor = <UIDynamicSystemColor: 0x2839a1ec0; name = systemBackgroundColor>; layer = <CALayer: 0x282c946a0>; contentOffset: {0, 0}; contentSize: {414, 50}; adjustedContentInset: {0, 0, 34, 0}; layout: <UICollectionViewFlowLayout: 0x105d55900>; dataSource: <AMKCrashByInvalidUpdateCollectionViewController: 0x105f21440>>'
- (void)crashByInvalidUpdate_0:(id)sender {
    [self.dataSource[0] addObjectsFromArray:@[@3, @4]];
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]]];
}

- (void)crashByInvalidUpdate_1:(id)sender {
    [self.dataSource[0] addObjectsFromArray:@[@3, @4]];
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:1]]];
}

- (void)crashByInvalidUpdate_2:(id)sender {
    [self.dataSource[0] addObjectsFromArray:@[@3, @4]];
    [self.collectionView reloadItemsAtIndexPaths:@[]];
}

// 2023-07-19 11:18:20.410828+0800 AMKCategories_Example[29850:11010021] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid batch updates detected: the number of sections and/or items returned by the data source before and/or after performing the batch updates are inconsistent with the updates.
- (void)crashByInvalidUpdate_3:(id)sender {
    [self.dataSource[0] addObjectsFromArray:@[@3, @4]];
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]]];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.2];
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%@", indexPath);
}

#pragma mark - Helper Methods

@end
