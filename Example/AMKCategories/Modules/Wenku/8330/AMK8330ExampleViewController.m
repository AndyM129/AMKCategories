//
//  AMK8330ExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/12/27.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMK8330ExampleViewController.h"
#import <WebKit/WebKit.h>

@interface AMK8330ExampleViewController ()
@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
@end

@implementation AMK8330ExampleViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://readme.so/editor"]]];
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
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _webView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
