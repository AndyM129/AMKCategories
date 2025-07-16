//
//  AMK10090ExampleWebViewTableViewCell.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/15.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMK10090ExampleWebViewTableViewCell.h"

@interface AMK10090ExampleWebView : WKWebView

@end

@implementation AMK10090ExampleWebView

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    BOOL shouldBegin = [super gestureRecognizerShouldBegin:gestureRecognizer];
//    NSLog(@"%@ => %@", gestureRecognizer, @(shouldBegin));
//    return shouldBegin;
//}

@end

#pragma mark -
#pragma mark -

@interface AMK10090ExampleWebViewTableViewCell () <UIGestureRecognizerDelegate>
@property (nonatomic, strong, readwrite, nullable) AMK10090ExampleWebView *webView;
//@property (nonatomic, strong, readwrite, nullable) UIPanGestureRecognizer *customWebScrollViewPanGestureRecognizer;
@end

@implementation AMK10090ExampleWebViewTableViewCell

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

- (AMK10090ExampleWebView *)webView {
    if (!_webView) {
        NSString *urlString = @"http://wenku.baidu.com";
        NSURL *URL = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest.alloc initWithURL:URL];
        
        _webView = [AMK10090ExampleWebView.alloc init];
        _webView.scrollView.bounces = NO;
        [_webView loadRequest:request];
        [self.contentView addSubview:_webView];
        
//        [_webView.scrollView addGestureRecognizer:self.customWebScrollViewPanGestureRecognizer];
    }
    return _webView;
}

//- (UIPanGestureRecognizer *)customWebScrollViewPanGestureRecognizer {
//    if (!_customWebScrollViewPanGestureRecognizer) {
//        _customWebScrollViewPanGestureRecognizer = [UIPanGestureRecognizer.alloc init];
//        _customWebScrollViewPanGestureRecognizer.cancelsTouchesInView = YES;
////        _customWebScrollViewPanGestureRecognizer.delegate = self;
//    }
//    return _customWebScrollViewPanGestureRecognizer;
//}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // 不调用父类实现，以避免编辑模式下的默认处理
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (CGFloat)tableView:(UITableView *_Nullable)tableView heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath {
    return UIScreen.mainScreen.bounds.size.height;
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

#pragma mark UIGestureRecognizerDelegate

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    return YES;
//}

#pragma mark - Helper Methods

@end
