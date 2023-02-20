//
//  AMKBundleResourceRequestExampleViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2023/1/18.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMKBundleResourceRequestExampleViewController.h"
#import <AMKCategories/MBProgressHUD+AMKCategories.h>

#define AMKBundleResourceRequestLog(FORMAT, ...) [AMKBundleResourceRequestExampleViewController logWithFunction:__FUNCTION__ line:__LINE__ string:FORMAT, ##__VA_ARGS__]

@interface AMKBundleResourceRequestExampleViewController ()
@property (nonatomic, strong, readwrite, nullable) AMKStackView *stackView;
@property (nonatomic, strong) NSBundleResourceRequest *resourceRequest;
@end

@implementation AMKBundleResourceRequestExampleViewController

//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIViewController amk_pushViewController:self.new animated:YES];
//    });
//}

#pragma mark - Dealloc

- (void)dealloc {
    [_resourceRequest removeObserverBlocks];
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"On-Demand Resources";
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor?:[UIColor whiteColor];
    
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedButton:@"检查资源" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [weakSelf conditionallyBeginAccessingResourcesWithCompletionHandler:nil];
    }];
    [self.stackView addArrangedButton:@"检查并按需请求资源" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [weakSelf beginAccessingResourcesIfNeededWithCompletionHandler:nil];
    }];
    [self.stackView addArrangedButton:@"强制请求资源" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [weakSelf beginAccessingResourcesWithCompletionHandler:nil];
    }];
    [self.stackView addArrangedButton:@"删除资源" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [weakSelf removeResources];
    }];
    [self.stackView addArrangedButton:@"访问资源" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [weakSelf useResources];
    }];
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

- (AMKStackView *)stackView {
    if (!_stackView) {
        _stackView = [AMKStackView.alloc initWithAxis:UILayoutConstraintAxisVertical spacing:20];
        [self.view addSubview:_stackView];
        [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
    }
    return _stackView;
}

/// 准备请求的资源标签
/// - 初始安装tag（Initial install tags）。只有在初始安装tag下载到设备后，app才能启动。这些资源会在下载app时一起下载。这部分资源的大小会包括在App Store中app的安装包大小。如果这些资源从来没有被NSBundleResourceRequest对象获取过，就有可能被清理掉。
/// - 按顺序预获取tag（Prefetch tag order）。在app安装后会开始下载tag。tag会按照此处指定的顺序来下载。
/// - 按需下载（Dowloaded only on demand）。当app请求一个tag，且tag没有缓存时，才会下载该tag。
- (NSBundleResourceRequest *)resourceRequest {
    if (!_resourceRequest) {
        NSSet *tags = [NSSet.alloc initWithObjects:@"MyInitialInstallResources", @"MyPrefetchResources", @"MyOnDemandResources", nil];
        _resourceRequest = [NSBundleResourceRequest.alloc initWithTags:tags];
        _resourceRequest.loadingPriority = 1.0;
        [_resourceRequest addObserverBlockForKeyPath:@"progress.fractionCompleted" block:^(NSBundleResourceRequest *resourceRequest, NSNumber *oldVal, NSNumber *newVal) {
            AMKBundleResourceRequestLog(@"%@ 请求标签资源：%@ => %.2f%%", @"🌐", resourceRequest.tags.allObjects.jsonStringEncoded, newVal.doubleValue * 100);
        }];
    }
    return _resourceRequest;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

/// 检查资源
- (void)conditionallyBeginAccessingResourcesWithCompletionHandler:(void (^)(BOOL resourcesAvailable))completionHandler {
    __weak __typeof__(self)weakSelf = self;
    [self.resourceRequest conditionallyBeginAccessingResourcesWithCompletionHandler:^(BOOL resourcesAvailable) {
        AMKBundleResourceRequestLog(@"%@ 检查请求的标签资源是否全部都已经在设备中保存了：%@ => %@", (resourcesAvailable ? @"✅" : @"❌"), weakSelf.resourceRequest.tags.allObjects.jsonStringEncoded, @(resourcesAvailable));
        !completionHandler ?: completionHandler(resourcesAvailable);
    }];
}

/// 检查并按需请求资源
- (void)beginAccessingResourcesIfNeededWithCompletionHandler:(void (^)(NSError * _Nullable error))completionHandler {
    __weak __typeof__(self)weakSelf = self;
    
    // 检查请求的标签资源是否全部都已经在设备中保存了
    [self.resourceRequest conditionallyBeginAccessingResourcesWithCompletionHandler:^(BOOL resourcesAvailable) {
        AMKBundleResourceRequestLog(@"%@ 检查请求的标签资源是否全部都已经在设备中保存了：%@ => %@", (resourcesAvailable ? @"✅" : @"❌"), weakSelf.resourceRequest.tags.allObjects.jsonStringEncoded, @(resourcesAvailable));
                
        // 请求不在本地的标签资源
        if (!resourcesAvailable) {
            [weakSelf.resourceRequest beginAccessingResourcesWithCompletionHandler:^(NSError * _Nullable error) {
                AMKBundleResourceRequestLog(@"%@ 请求不在本地的标签资源：%@ => error=%@", (!error ? @"✅" : @"❌"), weakSelf.resourceRequest.tags.allObjects.jsonStringEncoded, error);
                !completionHandler ?: completionHandler(error);
            }];
        }
        // 否则均已存在，则直接回调
        else {
            !completionHandler ?: completionHandler(nil);
        }
    }];
}

- (void)beginAccessingResourcesWithCompletionHandler:(void (^)(NSError * _Nullable error))completionHandler {
    __weak __typeof__(self)weakSelf = self;
    [self.resourceRequest beginAccessingResourcesWithCompletionHandler:^(NSError * _Nullable error) {
        AMKBundleResourceRequestLog(@"%@ 请求的标签资源：%@ => error=%@", (!error ? @"✅" : @"❌"), weakSelf.resourceRequest.tags.allObjects.jsonStringEncoded, error);
        !completionHandler ?: completionHandler(error);
    }];
}

/// 清除资源
- (void)removeResources {
    [self.resourceRequest endAccessingResources];
    self.resourceRequest = nil;
    AMKBundleResourceRequestLog(@"⚠️ 标签资源已移除");
}

/// 使用资源
- (void)useResources {
    NSMutableArray<NSString *> *logs = @[].mutableCopy;
    
    {   // MyInitialInstallResources
        NSString *imageName = @"MyInitialInstallResources_1";
        UIImage *image = [UIImage imageNamed:imageName];
        [logs addObject:[NSString stringWithFormat:@"%@ 加载资源：%@ => size=%.0f*%.0f", (image ? @"✅" : @"❌"), imageName, image.size.width, image.size.height]];
    }
    {   // MyPrefetchResources
        NSString *imageName = @"MyPrefetchResources_1";
        UIImage *image = [UIImage imageNamed:imageName];
        [logs addObject:[NSString stringWithFormat:@"%@ 加载资源：%@ => size=%.0f*%.0f", (image ? @"✅" : @"❌"), imageName, image.size.width, image.size.height]];
    }
    {   // MyOnDemandResources
        NSString *imageName = @"MyOnDemandResources_1";
        NSString *filePath = [NSBundle.mainBundle pathForResource:imageName ofType:@"jpeg"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        [logs addObject:[NSString stringWithFormat:@"%@ 加载资源：%@ => size=%.0f*%.0f", (image ? @"✅" : @"❌"), imageName, image.size.width, image.size.height]];
    }
    
    AMKBundleResourceRequestLog(@"%@", [logs componentsJoinedByString:@"\n"]);
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

+ (void)logWithFunction:(const char *)function line:(NSInteger)line string:(NSString *)format, ... {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter.alloc init];
        [dateFormatter setDateStyle:NSDateFormatterFullStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    });
    
    va_list arguments;
    va_start(arguments, format);
    NSString *string = [NSString.alloc initWithFormat:format arguments:arguments];
    va_end(arguments);
    
    fprintf(stderr,"%s %s Line %ld: %s%s\n", [dateFormatter stringFromDate:NSDate.date].UTF8String, function, line, "【ODR】", string.UTF8String);
    
    [MBProgressHUD amk_showTextHUDWithTitle:@"NSBundleResourceRequest" message:string inView:nil responder:nil duration:3 animated:YES];
}

@end
