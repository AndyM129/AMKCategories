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

@interface WKNNestedScrollTableExampleWebTableViewCell ()
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
        self.contentView.layer.borderWidth = 1 / UIScreen.mainScreen.scale;
    }
    return self;
}

#pragma mark - Getters & Setters

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView.alloc init];
        _webView.layer.borderColor = [UIColor.redColor colorWithAlphaComponent:0.5].CGColor;
        _webView.layer.borderWidth = 3;
        if (@available(iOS 13.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.contentView addSubview:_webView];
    }
    return _webView;
}

- (UIScrollView *)nestedScrollView {
    return self.webView.scrollView;
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


#pragma mark -
#pragma mark -

/// 长Web
@implementation WKNNestedScrollTableExampleLongWebTableViewCell

@end

#pragma mark -
#pragma mark -

/// 长Web 2
@implementation WKNNestedScrollTableExampleLongWebTableViewCell2

@end

#pragma mark -
#pragma mark -

/// 短Web
@implementation WKNNestedScrollTableExampleShortWebTableViewCell

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
