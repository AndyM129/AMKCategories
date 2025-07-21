//
//  WKNNestedScrollTableExampleNormalTableViewCell.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableExampleNormalTableViewCell.h"
#import "WKNNestedScrollTableView+WKNDebug.h"

@implementation WKNNestedScrollTableExampleNormalTableViewCell

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        WKNNestedScrollTableViewLog(@"Style %ld - %@", style, reuseIdentifier);
        self.selectedBackgroundView = [UIView.alloc initWithFrame:self.bounds];
        self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return self;
}

#pragma mark - Getters & Setters

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // 不调用父类实现，以避免编辑模式下的默认处理
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [UIView animateWithDuration:0.15 animations:^{
        self.contentView.alpha = highlighted ? 0.8 : 1;
    }];
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withParams:(id)params {
    return 50;
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

#pragma mark - Helper Methods

@end
