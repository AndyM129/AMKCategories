//
//  AMKAppVersionInfoViewController.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/7/26.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import "AMKAppVersionInfoViewController.h"
#import <AMKCategories/NSBundle+AMKAppVersionInfo.h>

@interface AMKAppVersionInfoViewController ()
@property(nonatomic, strong) UITextView *textView;
@end

@implementation AMKAppVersionInfoViewController

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"APP版本信息扩展";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    
    NSMutableDictionary *bundleInfo = [NSMutableDictionary dictionary];
    bundleInfo[@"Bundle ID"] = NSBundle.mainBundle.amk_bundleIdentifier ?:@"";
    bundleInfo[@"Bundle Name"] = NSBundle.mainBundle.amk_bundleName ?:@"";
    bundleInfo[@"Display Name"] = NSBundle.mainBundle.amk_bundleDisplayName ?:@"";
    bundleInfo[@"当前构建版本号"] = NSBundle.mainBundle.amk_currentBundleBuildVersion ?:@"";
    bundleInfo[@"上一次启动时的构建版本号"] = NSBundle.mainBundle.amk_beforeBundleBuildVersion ?:@"";
    bundleInfo[@"当前版本号"] = NSBundle.mainBundle.amk_currentBundleShortVersion ?:@"";
    bundleInfo[@"上一次启动时的版本号"] = NSBundle.mainBundle.amk_beforeBundleShortVersion ?:@"";
    bundleInfo[@"上一次启动时间"] = NSBundle.mainBundle.amk_beforeLaunchingDate ?:@"";
    bundleInfo[@"上一次启动时间(系统时区)"] = [formatter stringFromDate:NSBundle.mainBundle.amk_beforeLaunchingDate];
    bundleInfo[@"截止本次启动的启动次数"] = @(NSBundle.mainBundle.amk_launchingTimes);
    bundleInfo[@"是否是安装后第一次启动"] = @(NSBundle.mainBundle.amk_isFirstLaunching);
    bundleInfo[@"是否是升级后第一次启动"] = @(NSBundle.mainBundle.amk_isUpgradedLaunching);
    bundleInfo[@"是否是降级后第一次启动"] = @(NSBundle.mainBundle.amk_isDowngradedLaunching);
    self.textView.text = [bundleInfo description];
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

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.frame = self.view.bounds;
        _textView.editable = NO;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_textView];
    }
    return _textView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
