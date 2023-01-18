//
//  AMKBundleResourceRequestExampleViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2023/1/18.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMKBundleResourceRequestExampleViewController.h"

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
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor?:[UIColor whiteColor];
    
    // 示例：
    // -[AMKBundleResourceRequestExampleViewController useResources] Line 132: ❌ 加载资源：amk_bundle_resource_request_example_1 => size=0*0
    // -[AMKBundleResourceRequestExampleViewController useResources] Line 137: ❌ 加载资源：amk_bundle_resource_request_example_2 => size=0*0
    // -[AMKBundleResourceRequestExampleViewController useResources] Line 143: ❌ 加载资源：amk_bundle_resource_request_example_3 => size=0*0
    // -[AMKBundleResourceRequestExampleViewController accessingResourcesIfNeeded]_block_invoke_2 Line 112: ✅ 检查请求的标签资源是否全部都已经在设备中保存了：["MyPrefetchResources","MyOnDemandResources","MyInitialInstallResources"] => 1
    // -[AMKBundleResourceRequestExampleViewController useResources] Line 132: ✅ 加载资源：amk_bundle_resource_request_example_1 => size=20000*20000
    // -[AMKBundleResourceRequestExampleViewController useResources] Line 137: ✅ 加载资源：amk_bundle_resource_request_example_2 => size=20000*20000
    // -[AMKBundleResourceRequestExampleViewController useResources] Line 143: ✅ 加载资源：amk_bundle_resource_request_example_3 => size=20000*11256

    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedButton:@"请求资源" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [weakSelf accessingResourcesIfNeeded];
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

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark 请求资源

- (void)addButtonForAccessingResources {
    
}

- (void)accessingResourcesIfNeeded {
    __weak __typeof__(self)weakSelf = self;
    
    // 完成回调
    void(^completionBlock)(NSError *) = ^(NSError *error) {
        
    };
    
    // 准备请求的资源标签
    NSSet *tags = [NSSet.alloc initWithObjects:@"MyInitialInstallResources", @"MyOnDemandResources", @"MyPrefetchResources", nil];
    self.resourceRequest = [NSBundleResourceRequest.alloc initWithTags:tags];
    
    // 检查请求的标签资源是否全部都已经在设备中保存了
    [self.resourceRequest conditionallyBeginAccessingResourcesWithCompletionHandler:^(BOOL resourcesAvailable) {
        NSLog(@"%@ 检查请求的标签资源是否全部都已经在设备中保存了：%@ => %@", (resourcesAvailable ? @"✅" : @"❌"), weakSelf.resourceRequest.tags.allObjects.jsonStringEncoded, @(resourcesAvailable));
        
        // 请求不在本地的标签资源
        if (!resourcesAvailable) {
            [weakSelf.resourceRequest beginAccessingResourcesWithCompletionHandler:^(NSError * _Nullable error) {
                NSLog(@"%@ 请求不在本地的标签资源：%@ => error=%@", (!error ? @"✅" : @"❌"), weakSelf.resourceRequest.tags.allObjects.jsonStringEncoded, error);
            }];
        }
    }];
}

- (void)removeResources {
    [self.resourceRequest endAccessingResources];
    NSLog(@"⚠️ 标签资源已移除");
}

- (void)useResources {
    {
        NSString *imageName = @"amk_bundle_resource_request_example_1";
        UIImage *image = [UIImage imageNamed:imageName];
        NSLog(@"%@ 加载资源：%@ => size=%.0f*%.0f", (image ? @"✅" : @"❌"), imageName, image.size.width, image.size.height);
    }
    {
        NSString *imageName = @"amk_bundle_resource_request_example_2";
        UIImage *image = [UIImage imageNamed:imageName];
        NSLog(@"%@ 加载资源：%@ => size=%.0f*%.0f", (image ? @"✅" : @"❌"), imageName, image.size.width, image.size.height);
    }
    {
        NSString *imageName = @"amk_bundle_resource_request_example_3";
        NSString *filePath = [NSBundle.mainBundle pathForResource:imageName ofType:@"jpeg"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        NSLog(@"%@ 加载资源：%@ => size=%.0f*%.0f", (image ? @"✅" : @"❌"), imageName, image.size.width, image.size.height);
    }
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
