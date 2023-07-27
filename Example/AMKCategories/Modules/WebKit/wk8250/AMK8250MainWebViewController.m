//
//  AMK8250MainWebViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/21.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMK8250MainWebViewController.h"
#import "AMK8250PresentedWebViewController.h"
#import <WebKit/WebKit.h>

@interface AMK8250MainWebViewController ()
@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
@end

@implementation AMK8250MainWebViewController

//+ (void)load {
//    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
//        [NSNotificationCenter.defaultCenter removeObserver:token];
//        [UIViewController amk_pushViewController:self.new animated:YES];
//    }];
//}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = nil;
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(presentingWebViewController:)];
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
    }
    return _webView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

#pragma mark - Action Methods

- (void)presentingWebViewController:(id)sender {
    [AMK8250PresentedWebViewController.new presentFromViewController:self animated:YES completion:nil];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
