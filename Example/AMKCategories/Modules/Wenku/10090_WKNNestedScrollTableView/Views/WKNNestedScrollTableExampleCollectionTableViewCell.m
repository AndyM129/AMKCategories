//
//  WKNNestedScrollTableExampleCollectionTableViewCell.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableExampleCollectionTableViewCell.h"

@interface WKNNestedScrollTableExampleCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong, readwrite, nullable) UILabel *titleLabel;
@end

@implementation WKNNestedScrollTableExampleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.selectedBackgroundView = [UIView.alloc initWithFrame:self.bounds];
        self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel.alloc init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _titleLabel;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [UIView animateWithDuration:0.15 animations:^{
        self.contentView.alpha = highlighted ? 0.8 : 1;
    }];
}

@end

#pragma mark -
#pragma mark -

@interface WKNNestedScrollTableExampleCollectionTableViewCell () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong, readwrite, nullable) UICollectionView *collectionView;
@end

@implementation WKNNestedScrollTableExampleCollectionTableViewCell

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Getters & Setters

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *collectionViewFlowLayout = [UICollectionViewFlowLayout.alloc init];
        _collectionView = [UICollectionView.alloc initWithFrame:self.contentView.bounds collectionViewLayout:collectionViewFlowLayout];
        _collectionView.layer.borderColor = [UIColor.redColor colorWithAlphaComponent:0.5].CGColor;
        _collectionView.layer.borderWidth = 3;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:WKNNestedScrollTableExampleCollectionViewCell.class forCellWithReuseIdentifier:WKNNestedScrollTableExampleCollectionViewCell.className];
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

- (UIScrollView *)nestedScrollView {
    return self.collectionView;
}

- (CGFloat)nestedScrollViewDefaultHeight {
    return 50;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // 不调用父类实现，以避免编辑模式下的默认处理
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params {
    return UITableViewAutomaticDimension;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    // Coding ...
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    // Clear subviews data ...
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WKNNestedScrollTableExampleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WKNNestedScrollTableExampleCollectionViewCell.className forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithHue:fmod(0.6 + indexPath.section * 0.13, 1.0) saturation:fabs(0.8 - indexPath.row * 0.05) brightness:1 alpha:1.0];
    cell.titleLabel.text = [NSString stringWithFormat:@"Item <%ld, %ld>", indexPath.section, indexPath.row];
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"");
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger columnCount = 2; // 列数
    CGSize size = CGSizeMake(0, 150);
    if (indexPath.item%columnCount < (columnCount-1)) {
        size.width = CGRectGetWidth(collectionView.bounds) / columnCount;
    } else {
        size.width = CGRectGetWidth(collectionView.bounds) - CGRectGetWidth(collectionView.bounds) / columnCount * (columnCount-1);
    }
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

#pragma mark - Helper Methods

@end
