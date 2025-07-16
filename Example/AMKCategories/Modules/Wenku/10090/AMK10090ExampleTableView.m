//
//  AMK10090ExampleTableView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMK10090ExampleTableView.h"
#import "AMK10090ExampleWebViewTableViewCell.h"
#import <AMKCategories/UIResponder+AMKUIResponderExtensionMethods.h>
#import <WebKit/WebKit.h>

@implementation AMK10090ExampleTableView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {

    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%@", self.subviews);
    
    NSArray<UIView *> *subviews = self.subviews;
    NSInteger webViewTableViewCellIndex = [subviews indexOfObjectPassingTest:^BOOL(UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        return [subview isKindOfClass:AMK10090ExampleWebViewTableViewCell.class];
    }];
    if (webViewTableViewCellIndex != NSNotFound) {
        AMK10090ExampleWebViewTableViewCell *webViewTableViewCell = (id)subviews[webViewTableViewCellIndex];
        WKWebView *webView  = webViewTableViewCell.webView;
        webView.frame = self.bounds;
        [self insertSubview:webViewTableViewCell.webView atIndex:0];
        
        
    }
    
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
