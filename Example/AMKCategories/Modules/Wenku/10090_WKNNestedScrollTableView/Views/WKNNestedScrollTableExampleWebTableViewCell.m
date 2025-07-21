//
//  WKNNestedScrollTableExampleWebTableViewCell.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableExampleWebTableViewCell.h"
#import <AMKCategories/UIResponder+AMKUIResponderExtensionMethods.h>
#import "WKNNestedScrollTableView+WKNDebug.h"
#import <objc/runtime.h>

@interface WKNNestedScrollTableExampleWebTableViewCell () <UIScrollViewDelegate>
@property (nonatomic, strong, readwrite, nullable) UIView *webContainerView;
@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
@end

@implementation WKNNestedScrollTableExampleWebTableViewCell

#pragma mark - Init Methods

- (void)dealloc {
    [_webView.scrollView removeObserverBlocks];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        WKNNestedScrollTableViewLog(@"Style %ld - %@", style, reuseIdentifier);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Getters & Setters

- (UIView *)webContainerView {
    if (!_webContainerView) {
        _webContainerView = [UIView.alloc init];
        _webContainerView.backgroundColor = [UIColor.yellowColor colorWithAlphaComponent:0.1];
        [self.contentView insertSubview:_webContainerView atIndex:0];
    }
    return _webContainerView;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView.alloc init];
        _webView.scrollView.delegate = self;
        if (@available(iOS 13.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.contentView addSubview:_webView];
        
        __weak __typeof__(self)weakSelf = self;
        [_webView.scrollView addObserverBlockForKeyPath:@"contentSize" block:^(UIScrollView * _Nonnull scrollView, NSNumber * oldVal, NSNumber * newVal) {
            if (!CGSizeEqualToSize(newVal.CGSizeValue, oldVal.CGSizeValue)) {
                WKNNestedScrollTableViewLog(@"contentSize: %@ => %@", oldVal, newVal);
                
                
//                [weakSelf.webContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.height.mas_equalTo(newVal);
//                }];
                
                [weakSelf.webContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.right.mas_equalTo(weakSelf.contentView);
                    make.height.mas_equalTo(scrollView.contentSize.height);
                    make.bottom.mas_equalTo(weakSelf.contentView);
                }];
                
//                [weakSelf setNeedsUpdateConstraints];
//                [weakSelf updateConstraintsIfNeeded];
                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UITableView *tableView = [weakSelf amk_nextResponderWithClass:UITableView.class];
//                    [tableView beginUpdates];
//                    [tableView endUpdates];
//                });
            }
        }];
    }
    return _webView;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // 不调用父类实现，以避免编辑模式下的默认处理
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

//+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params {
//    return tableView.height;
//}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    CGFloat height = self.webView.scrollView.contentSize.height;
    WKNNestedScrollTableViewLog(@"self.webView.scrollView.contentSize: %@", @(self.webView.scrollView.contentSize));
    [self.webContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(self.contentView);
    }];
//    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.mas_equalTo(0);
//        make.height.mas_equalTo(50);
//    }];
    
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
    
}

- (void)_scrollViewDidScroll:(UIScrollView *)nestedScrollView {
    if (nestedScrollView != self.nestedScrollView) {
        return;
    }
    
    static void *kLastContentOffsetYKey = &kLastContentOffsetYKey;
    static void *kLastScrollOffsetYKey = &kLastScrollOffsetYKey;
    static void *kLastScrollingForFixOffsetYKey = &kLastScrollingForFixOffsetYKey;
    CGFloat lastContentOffsetY = [objc_getAssociatedObject(self, kLastContentOffsetYKey) floatValue]; //!< 上次的 内容偏移Y
    CGFloat lastScrollOffsetY = [objc_getAssociatedObject(self, kLastScrollOffsetYKey) floatValue]; //!< 上次的 Y的偏移差值
    BOOL isLastScrollingForFixOffsetY = [objc_getAssociatedObject(self, kLastScrollingForFixOffsetYKey) boolValue];
    CGFloat currentContentOffsetY = nestedScrollView.contentOffset.y; //!< 当前的内容偏移Y
    CGFloat currentScrollOffsetY = currentContentOffsetY - lastContentOffsetY; //!< 本次 相较于上次，Y的偏移差值
    BOOL isScrollingToDown = currentScrollOffsetY > 0; //!< 是否在向下滚动
    BOOL isScrollingForFixOffsetY = !isLastScrollingForFixOffsetY && (currentScrollOffsetY * lastScrollOffsetY < 0) && (fabs(currentScrollOffsetY + lastScrollOffsetY) < 0.001); //!< 是否因修正 OffsetY 而触发的本次执行
    objc_setAssociatedObject(self, kLastContentOffsetYKey, @(currentContentOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kLastScrollOffsetYKey, @(currentScrollOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kLastScrollingForFixOffsetYKey, @(isScrollingForFixOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!self.isHidden && self.alpha > 0 && nestedScrollView.scrollEnabled) {
        WKNNestedScrollTableViewLog(@"🔲 %@ —— ΔY = %g %@%@", nestedScrollView.wknNestedScrollTableViewDebug_debugDescription, currentScrollOffsetY, (isScrollingToDown ? @"⇣" : @"⇡"), (isScrollingForFixOffsetY ? @" 🔧" : @""));
    }
    
    UITableView *tableView = [self amk_nextResponderWithClass:UITableView.class];
    if (tableView) {
        CGFloat cellTop = self.frame.origin.y;
        CGFloat tableViewContentOffsetY = tableView.contentOffset.y;
        
        // 值修正
        if (!isScrollingToDown) {
            tableViewContentOffsetY = tableViewContentOffsetY + -currentScrollOffsetY;
        } else if (isScrollingForFixOffsetY && isScrollingToDown) {
            tableViewContentOffsetY = tableViewContentOffsetY + currentScrollOffsetY;
        }
        
        // 若当前 cell 还未滚到 tableView 可视区域的顶部
        if (tableViewContentOffsetY < cellTop) {
            nestedScrollView.contentOffset = CGPointZero;
            nestedScrollView.showsVerticalScrollIndicator = NO;
        }
        // 若当前 cell 已滚到 tableView 可视区域的顶部
        else {
            // 当前 cell 已顶部已经滑出 tableView 可视区域，则固定 scrollView 的 contentOffset，让其不动
            if (nestedScrollView.contentOffset.y > 0) {
                if (!isScrollingToDown) {
                    nestedScrollView.contentOffset = CGPointMake(0, nestedScrollView.contentSize.height - nestedScrollView.height);
                    nestedScrollView.showsVerticalScrollIndicator = NO;
                }
            }
            //scrollView.showsVerticalScrollIndicator = scrollView.contentOffset.y > 0;
        }
    }
}

#pragma mark WKNNestedScrollTableViewCellProtocol

- (UIScrollView *)nestedScrollView {
    return self.webView.scrollView;
}

#pragma mark - Helper Methods

@end


#pragma mark -
#pragma mark -

/// 长Web
@implementation WKNNestedScrollTableExampleLongWebTableViewCell

+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params {
    return tableView.height;
}

@end

#pragma mark -
#pragma mark -

/// 短Web
@implementation WKNNestedScrollTableExampleShortWebTableViewCell

+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params {
    return 200;
}

@end

#pragma mark -
#pragma mark -

@implementation WKWebView (WKNNestedScrollTableView)

- (nullable WKNavigation *)wknNestedScrollTableView_loadHTMLStringWithContentHeight:(CGFloat)contentHeight {
    NSString *htmlString = @"<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Gradient Background</title><style>body,html{margin:0;padding:0;}.gradient-container{display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;width:100%;height:321px;background:linear-gradient(to bottom,#6ec89f,#6895da)}.gradient-container p{display:block}</style></head><body><div class=\"gradient-container\">这是 WebView，内容高度 321px</div></body></html>";
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"321px" withString:[NSString stringWithFormat:@"%.0fpx", contentHeight]];
    return [self loadHTMLString:htmlString baseURL:nil];
}

@end
