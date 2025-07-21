//
//  WKNNestedScrollTableViewCell.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/7/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableViewCell.h"
#import <AMKCategories/UIResponder+AMKUIResponderExtensionMethods.h>
#import "WKNNestedScrollTableView+WKNDebug.h"
#import <WebKit/WebKit.h>
#import <objc/runtime.h>

@interface _WKNNestedScrollTableCellIntrinsicSizeView : UIView
@property (nonatomic, assign, readwrite) CGFloat intrinsicContentHeight;
@end

@implementation _WKNNestedScrollTableCellIntrinsicSizeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setIntrinsicContentHeight:(CGFloat)intrinsicContentHeight {
//    if (_intrinsicContentHeight == intrinsicContentHeight) {
//        return;
//    }
    
    WKNNestedScrollTableViewCell *tableViewCell = [self amk_nextResponderWithClass:WKNNestedScrollTableViewCell.class];
    UITableView *tableView = [tableViewCell amk_nextResponderWithClass:UITableView.class];
    WKNNestedScrollTableViewLog(@"%@: %g => %g", tableViewCell.className, _intrinsicContentHeight, intrinsicContentHeight);

    _intrinsicContentHeight = intrinsicContentHeight;
    [self invalidateIntrinsicContentSize];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [UIView performWithoutAnimation:^{
            [tableViewCell setNeedsUpdateConstraints];
            [tableViewCell updateConstraintsIfNeeded];
            [tableView performBatchUpdates:nil completion:nil];
        }];
    });
}

- (CGSize)intrinsicContentSize {
    CGSize intrinsicContentSize = [super intrinsicContentSize];
    intrinsicContentSize.height = self.intrinsicContentHeight;
    return intrinsicContentSize;
}

@end

#pragma mark -
#pragma mark -

@interface WKNNestedScrollTableViewCell () <UIScrollViewDelegate>
@property (nonatomic, strong, readwrite, nullable) _WKNNestedScrollTableCellIntrinsicSizeView *intrinsicSizeView;
@end

@implementation WKNNestedScrollTableViewCell

#pragma mark - Init Methods

- (void)dealloc {
    [self removeObserverBlocks];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.nestedScrollView.delegate = self;
    }
    return self;
}

#pragma mark - Getters & Setters

- (_WKNNestedScrollTableCellIntrinsicSizeView *)intrinsicSizeView {
    if (!_intrinsicSizeView) {
        _intrinsicSizeView = [_WKNNestedScrollTableCellIntrinsicSizeView.alloc init];
        _intrinsicSizeView.intrinsicContentHeight = self.nestedScrollViewDefaultHeight;
        [self.contentView insertSubview:_intrinsicSizeView atIndex:0];
        
        __weak __typeof__(self)weakSelf = self;
        if (self.nestedScrollView) {
            [self addObserverBlockForKeyPath:@"nestedScrollView.contentSize" block:^(WKNNestedScrollTableViewCell * _Nonnull nestedScrollTableViewCell, NSNumber * oldVal, NSNumber * newVal) {
                if (!CGSizeEqualToSize(newVal.CGSizeValue, oldVal.CGSizeValue)) {
                    WKNNestedScrollTableViewLog(@"%@: %@ => %@", weakSelf.className, oldVal, newVal);
                    weakSelf.intrinsicSizeView.intrinsicContentHeight = nestedScrollTableViewCell.nestedScrollView.contentSize.height;
                }
            }];
        }
    }
    return _intrinsicSizeView;
}

- (UIScrollView *)nestedScrollView {
    return nil;
}

- (CGFloat)nestedScrollViewDefaultHeight {
    return 0;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // 不调用父类实现，以避免编辑模式下的默认处理
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.intrinsicSizeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    UIScrollView *nestedScrollView = self.nestedScrollView;
    if ([nestedScrollView.superview isKindOfClass:WKWebView.class]) { // WKWebView
        [nestedScrollView.superview mas_remakeConstraints:^(MASConstraintMaker *make) {
            UITableView *tableView = [self amk_nextResponderWithClass:UITableView.class];
            make.left.top.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(MIN(tableView.height, self.nestedScrollView.contentSize.height ?: self.intrinsicSizeView.intrinsicContentHeight));
        }];
    } else { // UIScrollView 的子类
        [nestedScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            UITableView *tableView = [self amk_nextResponderWithClass:UITableView.class];
            make.left.top.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(MIN(tableView.height, self.nestedScrollView.contentSize.height ?: self.intrinsicSizeView.intrinsicContentHeight));
        }];
    }
    
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

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)nestedScrollView {
    if (nestedScrollView != self.nestedScrollView) {
        return;
    }
    
    UITableView *tableView = [self amk_nextResponderWithClass:UITableView.class];
    if (tableView) {
        CGFloat cellTop = self.frame.origin.y;
        CGFloat tableViewContentOffsetY = tableView.contentOffset.y;
        NSLog(@"🔲 %@: cellTop = %g, tableViewContentOffsetY = %g, Y-Top差值 = %g", self.className, cellTop, tableViewContentOffsetY, tableViewContentOffsetY - cellTop);
        
        UIScrollView *nestedScrollView = self.nestedScrollView;
        if ([nestedScrollView.superview isKindOfClass:WKWebView.class]) { // WKWebView
            WKWebView *webView = (id)nestedScrollView.superview;
            CGFloat webViewTop = MAX(0, MIN((tableViewContentOffsetY - cellTop), (nestedScrollView.contentSize.height - nestedScrollView.height)));
            [webView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.contentView);
                make.top.mas_equalTo(webViewTop);
                make.height.mas_equalTo(MIN(tableView.height, webView.scrollView.contentSize.height));
            }];
            webView.scrollView.contentOffset = CGPointMake(0, webViewTop);
        } else { // UIScrollView 的子类
            CGFloat nestedScrollViewTop = MAX(0, MIN((tableViewContentOffsetY - cellTop), (nestedScrollView.contentSize.height - nestedScrollView.height)));
            [nestedScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.contentView);
                make.top.mas_equalTo(nestedScrollViewTop);
                make.height.mas_equalTo(MIN(tableView.height, nestedScrollView.contentSize.height));
            }];
            nestedScrollView.contentOffset = CGPointMake(0, nestedScrollViewTop);
        }
    }
}

#pragma mark - Helper Methods

@end
