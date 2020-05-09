//
//  AMKWKWebViewScreenshotViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2020/4/27.
//  Copyright © 2020 AndyM129. All rights reserved.
//

#import "AMKWKWebViewScreenshotViewController.h"
#import <AMKCategories/WKWebView+AMKScreenshot.h>
#import "AMKScreenshotPreviewViewController.h"
#import <Photos/Photos.h>

@interface AMKWKWebViewScreenshotViewController ()
@property(nonatomic, strong, nullable, readwrite) WKWebView *webView;
@property(nonatomic, strong, nullable, readwrite) NSMutableArray<NSString *> *urls;
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
        self.title = @"WKWebView Screenshot";
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor?:[UIColor whiteColor];
    [self layoutNavigationBar];
    [self didClickChangeUrlBarButtonItem:nil];
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

- (NSMutableArray<NSString *> *)urls {
    if (!_urls) {
        _urls = [NSMutableArray array];
        [_urls addObject:@"https://w.url.cn/s/AWnokXn"];
        [_urls addObject:@"https://w.url.cn/s/A9PtMVt"];
        [_urls addObject:@"https://w.url.cn/s/AGaON7q"];
        [_urls addObject:@"https://w.url.cn/s/AU2gxb6"];
        [_urls addObject:@"https://w.url.cn/s/ADKxSMq"];
        [_urls addObject:@"https://w.url.cn/s/AgAyrkt"];
        [_urls addObject:@"https://w.url.cn/s/A2thM0K"];
        [_urls addObject:@"https://w.url.cn/s/AAmQgmH"];
        [_urls addObject:@"http://www.cppcns.com/ruanjian/ios/240217.html"];
    }
    return _urls;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)layoutNavigationBar {
    self.navigationItem.rightBarButtonItems = @[
        [UIBarButtonItem.alloc initWithTitle:@"存为图片" style:UIBarButtonItemStylePlain target:self action:@selector(didClickTakeSnapshotBarButtonItem:)],
        [UIBarButtonItem.alloc initWithTitle:@"切换网页" style:UIBarButtonItemStylePlain target:self action:@selector(didClickChangeUrlBarButtonItem:)],
    ];
}

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)didClickChangeUrlBarButtonItem:(id)sender {
    static NSInteger urlIndex = -1;
    
    urlIndex = (urlIndex + 1 + self.urls.count) % self.urls.count;
    NSString *url = [self.urls objectAtIndex:urlIndex];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest.alloc initWithURL:URL];
    [self.webView loadRequest:request];
}

- (void)didClickTakeSnapshotBarButtonItem:(id)sender {
    [self.webView amk_takeSnapshotInRect:CGRectZero completionHandler:^(UIImage * _Nullable snapshotImage, NSError * _Nullable error) {
        NSLog(@"长截图 %@ 生成%@：%@", NSStringFromCGSize(self.webView.scrollView.contentSize), error?@"失败":@"成功", error?:snapshotImage);
        AMKScreenshotPreviewViewController *viewController = [AMKScreenshotPreviewViewController.alloc init];
        viewController.image = snapshotImage;
        [UIViewController amk_pushViewController:viewController animated:YES];
    }];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end




//- (void)didClickTakeSnapshotBarButtonItem:(id)sender {
//    //    [self.webView snaplongWebViewWithMaxHeight:0 finsih:^(UIImage *image){
//    //        AMKScreenshotPreviewViewController *viewController = [AMKScreenshotPreviewViewController.alloc init];
//    //        viewController.image = image;
//    //        [UIViewController amk_pushViewController:viewController animated:YES];
//    //    }];
//
//    //    WKSnapshotConfiguration *configuration = [WKSnapshotConfiguration.alloc init];
//    //    configuration.rect = CGRectMake(0, 0, self.webView.scrollView.contentSize.width, self.webView.scrollView.contentSize.height);
//    //    [self.webView takeSnapshotWithConfiguration:configuration completionHandler:^(UIImage * _Nullable snapshotImage, NSError * _Nullable error) {
//    //        AMKScreenshotPreviewViewController *viewController = [AMKScreenshotPreviewViewController.alloc init];
//    //        viewController.image = snapshotImage;
//    //        [UIViewController amk_pushViewController:viewController animated:YES];
//    //    }];
//
//    //    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
//    //        make.left.top.mas_equalTo(self.view);
//    //        make.size.mas_equalTo(self.webView.scrollView.contentSize);
//    //    }];
//
//    //    [self.webView takeSnapshotInRect:CGRectZero completionHandler:^(UIImage * _Nullable snapshotImage, NSError * _Nullable error) {
//    //        AMKScreenshotPreviewViewController *viewController = [AMKScreenshotPreviewViewController.alloc init];
//    //        viewController.image = snapshotImage;
//    //        [UIViewController amk_pushViewController:viewController animated:YES];
//    //    }];
//
//
//    //    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
//    //        make.left.top.mas_equalTo(self.view);
//    //        make.size.mas_equalTo(self.webView.scrollView.contentSize);
//    //    }];
//    ////    UIGraphicsBeginImageContextWithOptions(self.webView.scrollView.contentSize, YES, UIScreen.mainScreen.scale);
//    ////    [self.webView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    //    UIImage *snapshotImage = self.webView.snapshotImage; //UIGraphicsGetImageFromCurrentImageContext();
//    ////    UIGraphicsEndImageContext();
//    //    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
//    //        make.left.top.mas_equalTo(self.view);
//    //        make.size.mas_equalTo(self.view);
//    //    }];
//    //
//    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    //        AMKScreenshotPreviewViewController *viewController = [AMKScreenshotPreviewViewController.alloc init];
//    //        viewController.image = snapshotImage;
//    //        [UIViewController amk_pushViewController:viewController animated:YES];
//    //    });
//
//
//    ////    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
//    ////        make.left.top.mas_equalTo(self.view);
//    ////        make.size.mas_equalTo(self.webView.scrollView.contentSize);
//    ////    }];
//    //    self.webView.bounds = CGRectMake(0, 0, self.webView.scrollView.contentSize.width, self.webView.scrollView.contentSize.height);
//    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    //        UIImageWriteToSavedPhotosAlbum(self.webView.snapshotImage, self, @selector(image:didFinshSavingWithError:contextInfo:), nil);
//    //    });
//
//
//    [self.webView takeSnapshotInRect:CGRectZero completionHandler:^(UIImage * _Nullable snapshotImage, NSError * _Nullable error) {
//        NSLog(@"长截图生成%@：%@", error?@"失败":@"成功", error?:snapshotImage);
//        AMKScreenshotPreviewViewController *viewController = [AMKScreenshotPreviewViewController.alloc init];
//        viewController.image = snapshotImage;
//        [UIViewController amk_pushViewController:viewController animated:YES];
//    }];
//}
//
////- (void)image:(UIImage *)image didFinshSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
////    NSLog(@"保存%@：%@", error?@"失败":@"成功", error?:image);
////    AMKScreenshotPreviewViewController *viewController = [AMKScreenshotPreviewViewController.alloc init];
////    viewController.image = image;
////    [UIViewController amk_pushViewController:viewController animated:YES];
////}
//
////+ (void)saveImage:(UIImage *)image
////{
////    //(1) 获取当前的授权状态
////    PHAuthorizationStatus lastStatus = [PHPhotoLibrary authorizationStatus];
////
////    //(2) 请求授权
////    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
////        //回到主线程
////        dispatch_async(dispatch_get_main_queue(), ^{
////
////            if(status == PHAuthorizationStatusDenied) //用户拒绝（可能是之前拒绝的，有可能是刚才在系统弹框中选择的拒绝）
////            {
////                if (lastStatus == PHAuthorizationStatusNotDetermined) {
////                    //说明，用户之前没有做决定，在弹出授权框中，选择了拒绝
////                    [MBProgressHUD showError:@"保存失败"];
////                    return;
////                }
////                // 说明，之前用户选择拒绝过，现在又点击保存按钮，说明想要使用该功能，需要提示用户打开授权
////                [MBProgressHUD showMessage:@"失败！请在系统设置中开启访问相册权限"];
////
////            }
////            else if(status == PHAuthorizationStatusAuthorized) //用户允许
////            {
////                //保存图片---调用上面封装的方法
////                [self saveImageToCustomAblumWithImage:image];
////            }
////            else if (status == PHAuthorizationStatusRestricted)
////            {
////                [MBProgressHUD showError:@"系统原因，无法访问相册"];
////            }
////        });
////    }];
////}
//
//@implementation WKWebView (YYAdd)
//
//- (UIImage *)snapshotImage {
//    UIGraphicsBeginImageContextWithOptions(self.scrollView.contentSize, self.opaque, 0);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return snap;
//}
//
//@end
