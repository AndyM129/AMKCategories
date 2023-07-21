//
//  AMK8250PresentedWebViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/21.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMK8250PresentedWebViewController.h"
#import "AMK8250MainWebViewController.h"
#import <WebKit/WebKit.h>
#import <Aspects/Aspects.h>

@interface AMK8250MainWebViewController (AMK8250PresentedWebViewController)
@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
@end

@interface AMK8250PresentedWebViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
@property (nonatomic, weak, readwrite, nullable) AMK8250MainWebViewController *presentingMainWebViewController;
@property (nonatomic, strong, readwrite, nullable) UILabel *mainContentSchematicView;
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
    BOOL isViewAppeared = self.amk_isViewAppeared;
    [super viewDidAppear:animated];
    
    if (!isViewAppeared) {
        AMK8250MainWebViewController *viewController = (id)self.amk_previousViewController;
        if ([viewController isKindOfClass:AMK8250MainWebViewController.class]) {
            self.presentingMainWebViewController = viewController;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (!self.presentingViewController) {
        self.presentingMainWebViewController = nil;
    }
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

- (UILabel *)mainContentSchematicView {
    if (!_mainContentSchematicView) {
        _mainContentSchematicView = [UILabel.alloc init];
        _mainContentSchematicView.userInteractionEnabled = NO;
        _mainContentSchematicView.numberOfLines = 0;
        _mainContentSchematicView.textAlignment = NSTextAlignmentCenter;
        _mainContentSchematicView.font = [UIFont boldSystemFontOfSize:30];
        _mainContentSchematicView.text = @"AI生成弹窗区域\n\n不可滑动编辑器";
        _mainContentSchematicView.textColor = [UIColor.redColor colorWithAlphaComponent:0.25];
        _mainContentSchematicView.layer.borderWidth = 2;
        _mainContentSchematicView.layer.borderColor = _mainContentSchematicView.textColor.CGColor;
        _mainContentSchematicView.layer.backgroundColor = [_mainContentSchematicView.textColor colorWithAlphaComponent:0.3].CGColor;
        _mainContentSchematicView.frame = ({
            CGRect frame = CGRectZero;
            frame.size.width = self.view.width;
            frame.size.height = self.view.height * 0.55;
            frame.origin.y = self.view.height - frame.size.height;
            frame;
        });
    }
    return _mainContentSchematicView;
}

- (void)setPresentingMainWebViewController:(AMK8250MainWebViewController *)presentingMainWebViewController {
    static void *kAspectTokenKey = &kAspectTokenKey;

    if (_presentingMainWebViewController != presentingMainWebViewController) {
        if (_presentingMainWebViewController && [self getAssociatedValueForKey:kAspectTokenKey]) {
            [[self getAssociatedValueForKey:kAspectTokenKey] remove];
            [self setAssociateValue:nil withKey:kAspectTokenKey];
            [_presentingMainWebViewController.webView.scrollView addGestureRecognizer:_presentingMainWebViewController.webView.scrollView.panGestureRecognizer];
        }
        _presentingMainWebViewController = presentingMainWebViewController;
        if (_presentingMainWebViewController) {
            NSError *error;
            __weak __typeof__(self)weakSelf = self;
            id<AspectToken> aspectToken = [(NSObject *)_presentingMainWebViewController.webView.scrollView.panGestureRecognizer.delegate aspect_hookSelector:@selector(gestureRecognizerShouldBegin:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo) {
                UIPanGestureRecognizer *panGestureRecognizer = aspectInfo.arguments.firstObject;
                BOOL returnValue = CGRectContainsPoint(weakSelf.mainContentSchematicView.frame, [panGestureRecognizer locationInView:panGestureRecognizer.view]) ? NO : YES;
                NSLog(@"returnValue = %@ ==> %@", @(returnValue), panGestureRecognizer);
                [aspectInfo.originalInvocation setReturnValue:&returnValue];
            } error:&error];
            
            if (error) {
                NSLog(@"❌ %@", error);
            } else {
                [self setAssociateValue:aspectToken withKey:kAspectTokenKey];
                [self.webView.scrollView addGestureRecognizer:_presentingMainWebViewController.webView.scrollView.panGestureRecognizer];
            }
        }
    }
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.view insertSubview:self.mainContentSchematicView aboveSubview:self.webView];
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

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"%@", gestureRecognizer);
    return YES;
}

#pragma mark - Helper Methods

@end
