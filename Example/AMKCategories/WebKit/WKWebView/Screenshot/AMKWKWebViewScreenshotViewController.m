//
//  AMKWKWebViewScreenshotViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2020/4/27.
//  Copyright © 2020 AndyM129. All rights reserved.
//

#import "AMKWKWebViewScreenshotViewController.h"
#import <AMKCategories/WKWebView+AMKScreenshot.h>
#import <AMKCategories/UIImage+AMKImageRendering.h>

@interface AMKWKWebViewScreenshotViewController ()
@property(nonatomic, strong, nullable, readwrite) WKWebView *webView;
@end

@implementation AMKWKWebViewScreenshotViewController

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIViewController amk_gotoViewController:AMKWKWebViewScreenshotViewController.new transitionStyle:AMKViewControllerTransitionStylePush animated:YES];
    });
}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"WKWebView Screenshot";//NSStringFromClass(self.class);
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor?:[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"保存为图片" style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBarButtonItem:)];
    
    NSString *url = @"http://www.cppcns.com/ruanjian/ios/240217.html";//@"http://www.baidu.com";
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest.alloc initWithURL:URL];
    [self.webView loadRequest:request];
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

#pragma mark - Properties

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

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)didClickRightBarButtonItem:(id)sender {
    UIImage *image = [UIImage amk_imageWithColor:[UIColor grayColor] size:CGSizeMake(300, 1000) cornerRadius:0];

    UIViewController *viewController = [UIViewController.alloc init];
    viewController.title = @"预览";
    viewController.view.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
    UIImageView *imageView = [UIImageView.alloc init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    [viewController.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [UIViewController amk_pushViewController:viewController animated:YES];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
