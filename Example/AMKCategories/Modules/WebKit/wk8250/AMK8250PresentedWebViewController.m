//
//  AMK8250PresentedWebViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/21.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMK8250PresentedWebViewController.h"
#import <WebKit/WebKit.h>

@interface AMK8250PresentedWebViewController ()
@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
@end

@implementation AMK8250PresentedWebViewController

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
    self.view.backgroundColor = UIColor.clearColor;
#   pragma clang diagnostic push
#   pragma clang diagnostic ignored "-Wunguarded-availability"
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemClose target:self action:@selector(clickCloseBarButtonItem:)];
#   pragma clang diagnostic pop
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://tanbi.baidu.com/h5apptopic/browse/wkeditorhelper"]]];
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
        _webView.backgroundColor = UIColor.clearColor;
        _webView.opaque = false;
        _webView.scrollView.bounces = NO;
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

- (BOOL)presentFromViewController:(UIViewController *_Nullable)fromViewController animated:(BOOL)animated completion:(void (^_Nullable)(UIViewController *_Nullable viewController))completion {
    UINavigationController *navigationController = [UINavigationController.alloc initWithRootViewController:self];
    navigationController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    fromViewController = fromViewController ?: UIViewController.amk_topViewController;
    return [fromViewController amk_presentViewController:navigationController animated:NO completion:completion];
}

- (void)clickCloseBarButtonItem:(id)sender {
    [self amk_goBackAnimated:NO];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
