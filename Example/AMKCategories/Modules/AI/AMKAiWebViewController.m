//
//  AMKAiWebViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/5/24.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMKAiWebViewController.h"
#import <WebKit/WebKit.h>

@interface AMKAiWebViewController ()
@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
@end

@implementation AMKAiWebViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
        self.tabBarItem.title = @"AI";
    }
    return self;
}

- (instancetype)initWithUrl:(NSString *)url {
    return [self initWithUrl:url title:nil];
}

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title {
    if (self = [super init]) {
        self.url = url;
        self.tabBarItem.title = title;
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self webViewReloadRequestIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Getters & Setters

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView.alloc init];
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [self.view addSubview:_webView];
        [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).inset(UIApplication.sharedApplication.delegate.window.safeAreaInsets.top);
            make.left.bottom.right.equalTo(self.view);
        }];
    }
    return _webView;
}

#pragma mark - Data & Networking

- (void)setUrl:(NSString *)url {
    if (![_url isEqualToString:url]) {
        _url = url.copy;
        [self webViewReloadRequestIfNeeded];
    }
}

- (void)webViewReloadRequestIfNeeded {
    if (self.isViewLoaded) {
        [self webViewReloadRequestWithUrl:self.url];
    }
}

- (void)webViewReloadRequestWithUrl:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest.alloc initWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
