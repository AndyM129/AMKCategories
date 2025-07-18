//
//  WKNNestedScrollTableExampleCategoryTitleTableViewCell.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableExampleCategoryTitleTableViewCell.h"
#import "WKNNestedScrollTableView+WKNDebug.h"

@interface WKNNestedScrollTableExampleCategoryTitleTableViewCell () <JXCategoryViewDelegate>
@property (nonatomic, strong, readwrite, nullable) JXCategoryTitleView *categoryTitleView;
@end

@implementation WKNNestedScrollTableExampleCategoryTitleTableViewCell

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        WKNNestedScrollTableViewLog(@"Style %ld - %@", style, reuseIdentifier);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Getters & Setters

- (JXCategoryTitleView *)categoryTitleView {
    if (!_categoryTitleView) {
        _categoryTitleView = [JXCategoryTitleView.alloc init];
        _categoryTitleView.titleSelectedColor = [UIColor colorWithRed:70/255.0 green:157/255.0 blue:227/255.0 alpha:1.0];
        _categoryTitleView.titles = @[@"Tab 1", @"Tab 2"];
        _categoryTitleView.averageCellSpacingEnabled = NO;
        _categoryTitleView.delegate = self;
        
        JXCategoryIndicatorLineView *lineView = [JXCategoryIndicatorLineView.alloc init];
        lineView.indicatorColor = _categoryTitleView.titleSelectedColor;
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
        _categoryTitleView.indicators = @[lineView];
        
        [self.contentView addSubview:_categoryTitleView];
    }
    return _categoryTitleView;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // 不调用父类实现，以避免编辑模式下的默认处理
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params {
    return 40;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.categoryTitleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
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

#pragma mark JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    !self.categoryTitleViewDidSelectItemBlock ?: self.categoryTitleViewDidSelectItemBlock(self, index);
}

#pragma mark - Helper Methods

@end
