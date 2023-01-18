//
//  AMKOfflineLoadingWebViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/10/28.
//  Copyright © 2022 AndyM129. All rights reserved.
//

// 参考文档：
// - [WKWebView详解 - 简书](https://www.jianshu.com/p/76c6bc2d6137)
//

#import "AMKOfflineLoadingWebViewController.h"
#import "WKWebView+AMKOfflineLoading.h"

static NSString *kDefaultTitle = @"WebView 离线加载";

@interface AMKOfflineLoadingWebViewController () <WKNavigationDelegate, WKUIDelegate, WKURLSchemeHandler>
@property (nonatomic, strong, readwrite, nullable) WKPreferences *webViewPreferences;
@property (nonatomic, strong, readwrite, nullable) WKWebViewConfiguration *webViewConfiguration;
@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
@property (nonatomic, strong, readwrite, nullable) UIProgressView *webProgressView;
@property (nonatomic, strong, readwrite, nullable) NSHashTable *urlSchemeTasks;
@end

@implementation AMKOfflineLoadingWebViewController

#pragma mark - Dealloc

- (void)dealloc {
    [_webView removeObserverBlocks];
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = kDefaultTitle;
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadWebView)];
    self.view.backgroundColor = self.view.backgroundColor ?: [UIColor whiteColor];
    [self requestOfflineLoadingResources];
    [self reloadWebView];
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

- (WKPreferences *)webViewPreferences {
    if (!_webViewPreferences) {
        _webViewPreferences = [WKPreferences new];
        _webViewPreferences.javaScriptEnabled = YES; //是否支持JavaScript
        _webViewPreferences.javaScriptCanOpenWindowsAutomatically = YES; //不通过用户交互，是否可以打开窗口
    }
    return _webViewPreferences;
}

- (WKWebViewConfiguration *)webViewConfiguration {
    if (!_webViewConfiguration) {
        _webViewConfiguration = [WKWebViewConfiguration.alloc init];
        _webViewConfiguration.selectionGranularity = WKSelectionGranularityDynamic;
        _webViewConfiguration.allowsInlineMediaPlayback = YES;
        _webViewConfiguration.preferences = self.webViewPreferences;
        [_webViewConfiguration setURLSchemeHandler:self forURLScheme:@"https"];
        [_webViewConfiguration setURLSchemeHandler:self forURLScheme:@"http"];
    }
    return _webViewConfiguration;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView.alloc initWithFrame:self.view.bounds configuration:self.webViewConfiguration];
        _webView.UIDelegate = self; // UIDelegate负责界面弹窗
        _webView.navigationDelegate = self; //navigationDelegate负责加载、跳转等
        [self addObserverForTitle];
        [self addObserverForLoadingProgress];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (UIProgressView *)webProgressView {
    if (!_webProgressView) {
        _webProgressView = [UIProgressView.alloc init];
        _webProgressView.alpha = 0;
        [self.view addSubview:_webProgressView];
    }
    return _webProgressView;
}

- (NSHashTable *)urlSchemeTasks {
    if (!_urlSchemeTasks) {
        _urlSchemeTasks = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
    }
    return _urlSchemeTasks;
}

#pragma mark - Data & Networking

/// 加载离线包资源
- (void)requestOfflineLoadingResources {
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", NSURLRequest.amk_directoryPathOfOfflineLoading, @"image.png"];
    if (![NSFileManager.defaultManager fileExistsAtPath:filePath]) {
        UIImage *image = [UIImage imageNamed:@"amk_offline_loading_image"];
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:filePath atomically:YES];
    }
}

- (void)reloadWebView {
    NSString *urlString = @"http://www.baidu.com";
    NSURL *URL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest.alloc initWithURL:URL];
    [self.webView loadRequest:request];
}

#pragma mark - Layout Subviews

- (void)updateViewConstraints {
    [self.view insertSubview:self.webProgressView aboveSubview:self.webView];
    [self.webProgressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(2);
    }];
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [super updateViewConstraints];
}

#pragma mark - Action Methods

- (void)alert:(NSString *)title message:(NSString *)message {
    [self alert:title message:message buttonTitles:@[@"确定"] handler:nil];
}

- (void)alert:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles handler:(void(^)(int, NSString *))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < buttonTitles.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                handler(i, action.title);
            }
        }]];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Notifications

#pragma mark - KVO

/// KVO 以更新「页面标题」
- (void)addObserverForTitle {
    __weak __typeof__(self)weakSelf = self;
    [self.webView addObserverBlockForKeyPath:@"title" block:^(id  _Nonnull obj, NSString *_Nonnull oldVal, NSString *_Nonnull newVal) {
        weakSelf.title = newVal.length ? [NSString stringWithFormat:@"%@：%@", kDefaultTitle, newVal] : kDefaultTitle;
    }];
}

/// KVO 以更新「加载状态&进度」
- (void)addObserverForLoadingProgress {
    __weak __typeof__(self)weakSelf = self;
    [self.webView addObserverBlockForKeyPath:@"estimatedProgress" block:^(id  _Nonnull obj, NSNumber *_Nonnull oldVal, NSNumber *_Nonnull newVal) {
        [weakSelf.webProgressView setProgress:newVal.floatValue animated:YES];
    }];
    [self.webView addObserverBlockForKeyPath:@"loading" block:^(id  _Nonnull obj, NSNumber *_Nonnull oldVal, NSNumber *_Nonnull newVal) {
        [UIView animateWithDuration:0.3 delay:newVal.boolValue ? 0 : 0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.webProgressView.alpha = newVal.boolValue ? 1 : 0;
        } completion:^(BOOL finished) {
            if (!newVal.boolValue) {
                weakSelf.webProgressView.progress = 0;
            }
        }];
    }];
}

#pragma mark - Protocol

#pragma mark WKNavigationDelegate

/// 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%@, %@", webView, navigation);
}

/// 开始返回内容
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%@, %@", webView, navigation);
}

/// 页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"%@, %@", webView, navigation);
}

/// 页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%@, %@", webView, navigation);
}

/// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%@", navigationAction.request.URL.absoluteString);
    
    decisionHandler(WKNavigationActionPolicyAllow); //允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel); //不允许跳转
}

/// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"%@", navigationResponse.response.URL.absoluteString);
    
    decisionHandler(WKNavigationResponsePolicyAllow); //允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel); //不允许跳转
}

#pragma mark WKUIDelegate

/// 处理alert弹窗事件
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    [self alert:@"温馨提示" message:message?:@"" buttonTitles:@[@"确认"] handler:^(int index, NSString *title) {
       completionHandler();
    }];
}

/// 处理Confirm弹窗事件
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    NSLog(@"%@", message);
    
    [self alert:@"温馨提示" message:message?:@"" buttonTitles:@[@"取消", @"确认"] handler:^(int index, NSString *title) {
       completionHandler(index != 0);
    }];
}

/// 处理TextInput弹窗事件
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    NSLog(@"%@", prompt);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = [alert.textFields firstObject].text;
        NSLog(@"字符串：%@", text);
        completionHandler(text);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark WKURLSchemeHandler

- (void)webView:(WKWebView *)webView startURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask {
    [self.urlSchemeTasks addObject:urlSchemeTask];
    
    // 检查离线资源
    NSString *filePath = urlSchemeTask.request.amk_filePathOfOfflineLoading;
    BOOL fileExist = filePath.length && [NSFileManager.defaultManager fileExistsAtPath:filePath];
    AMKWebViewOfflineLoadLog(@"%@▶️ %@", (fileExist ? @"📂" : @"🌐"), urlSchemeTask.request.URL);

    // 优先尝试加载离线资源
    if (fileExist) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSHTTPURLResponse *response = [NSHTTPURLResponse.alloc initWithURL:urlSchemeTask.request.URL statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:@{@"Access-Control-Allow-Origin":@"*", @"Access-Control-Allow-Headers":@"Content-Type"}];
        @try {
            [urlSchemeTask didReceiveResponse:response];
            [urlSchemeTask didReceiveData:data];
            [urlSchemeTask didFinish];
        } @catch (NSException *exception) {
            AMKWebViewOfflineLoadLog(@"📂❌ %@ => %@", urlSchemeTask.request.URL, exception);
        }
    }
    // 否则加载网络资源
    else {
        [[NSURLSession.sharedSession dataTaskWithRequest:urlSchemeTask.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!urlSchemeTask) {
                    return;
                }
                if ([self.urlSchemeTasks containsObject:urlSchemeTask]) {
                    if (error){
                        AMKWebViewOfflineLoadLog(@"🌐❌ %@ => %@", urlSchemeTask.request.URL, error);
                        [urlSchemeTask didFailWithError:error];
                    } else {
                        @try {
                            AMKWebViewOfflineLoadLog(@"🌐⏹ %@", urlSchemeTask.request.URL);
                            [urlSchemeTask didReceiveResponse:response];
                            [urlSchemeTask didReceiveData:data];
                            [urlSchemeTask didFinish];
                        } @catch (NSException *exception) {
                            AMKWebViewOfflineLoadLog(@"🌐❌ %@ => %@", urlSchemeTask.request.URL, exception);
                        }
                    }
                    [self.urlSchemeTasks removeObject:urlSchemeTask];
                }
            });
        }] resume];
    }
}

- (void)webView:(WKWebView *)webView stopURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask {
    AMKWebViewOfflineLoadLog(@"🌐⏹ %@", urlSchemeTask.request.URL);
    if ([self.urlSchemeTasks containsObject:urlSchemeTask]) {
        [self.urlSchemeTasks removeObject:urlSchemeTask];
    }
}

#pragma mark - 弹窗

#pragma mark - Helper Methods

@end
