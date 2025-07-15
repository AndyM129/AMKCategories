//
//  AMK10090ExampleCategoryTitleTableViewCell.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/15.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMK10090ExampleCategoryTitleTableViewCell.h"

@interface AMK10090ExampleCategoryTitleTableViewCell ()
@property (nonatomic, strong, readwrite, nullable) JXCategoryTitleView *categoryTitleView;
@end

@implementation AMK10090ExampleCategoryTitleTableViewCell

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.layer.borderWidth = 1 / UIScreen.mainScreen.scale;
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

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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

#pragma mark - Helper Methods


@end
