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
@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
@end

@implementation WKNNestedScrollTableExampleWebTableViewCell

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

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView.alloc init];
        _webView.scrollView.delegate = self;
        [self.contentView addSubview:_webView];
    }
    return _webView;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // 不调用父类实现，以避免编辑模式下的默认处理
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params {
    return tableView.height;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
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

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isHidden || self.alpha <= 0 || !scrollView.scrollEnabled) {
        return;
    }
    
    static void *kLastContentOffsetYKey = &kLastContentOffsetYKey;
    CGFloat lastContentOffsetY = [objc_getAssociatedObject(self, kLastContentOffsetYKey) floatValue]; // 上次的内容偏移Y
    CGFloat currentScrollOffsetY = scrollView.contentOffset.y - lastContentOffsetY; // 本次 相较于上次，Y的偏移差值，正值为向下滚，负值为向上滚
    objc_setAssociatedObject(self, kLastContentOffsetYKey, @(scrollView.contentOffset.y), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    WKNNestedScrollTableViewLog(@"🔲 %@ —— ΔY = %g", scrollView.wknNestedScrollTableViewDebug_debugDescription, currentScrollOffsetY);
        
    UITableView *tableView = [self amk_nextResponderWithClass:UITableView.class];
    if (tableView) {
        CGFloat cellTop = self.frame.origin.y;
        CGFloat tableViewContentOffsetY = tableView.contentOffset.y;
        
        // 当前cell 还未滚到 tableView 顶部
        if (tableViewContentOffsetY + (currentScrollOffsetY < 0 ? -currentScrollOffsetY : 0) < cellTop) {
            scrollView.contentOffset = CGPointZero;
            scrollView.showsVerticalScrollIndicator = NO;
        }
        // 当前cell 已露出
        else {
            scrollView.showsVerticalScrollIndicator = YES;
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
    NSString *htmlString = @"<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Gradient Background</title><style>body,html{margin:0;padding:0;height:100%;overflow:hidden}.gradient-container{display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;width:100%;height:321px;background:linear-gradient(to bottom,#6ec89f,#6895da)}.gradient-container p{display:block}</style></head><body><div class=\"gradient-container\">这是 WebView，内容高度 321px</div></body></html>";
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"321px" withString:[NSString stringWithFormat:@"%.0fpx", contentHeight]];
    return [self loadHTMLString:htmlString baseURL:nil];
}

@end
