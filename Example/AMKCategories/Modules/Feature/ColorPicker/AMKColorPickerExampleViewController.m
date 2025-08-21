//
//  AMKColorPickerExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKColorPickerExampleViewController.h"
#import "AMKColorHueSaturationView.h"
#import "AMKColorPickerView.h"
#import <AMKCategories/MBProgressHUD+AMKCategories.h>

@interface AMKColorPickerExampleViewController ()
@property (nonatomic, strong, readwrite, nullable) AMKColorHueSaturationView *colorHueSaturationView;
@property (nonatomic, strong, readwrite, nullable) AMKColorPickerView *colorPickerView;
@end

@implementation AMKColorPickerExampleViewController

+ (void)load {
    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull notification) {
        [NSNotificationCenter.defaultCenter removeObserver:token];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIViewController amk_pushViewController:self.new animated:YES completion:nil];
        });
    }];
}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedSeparatorWithTitle:@"UIColorPickerViewController 系统取色页" color:nil size:12];
    [self.stackView addArrangedButton:@"显示" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        if (@available(iOS 14.0, *)) {
            UIColorPickerViewController *viewController = [UIColorPickerViewController.alloc init];
            [UIViewController amk_presentViewController:viewController animated:YES];
        } else {
            [MBProgressHUD amk_showTextHUDWithTitle:weakSelf.title message:@"Only iOS 14.0+" inView:nil responder:nil duration:2 animated:YES];
        }
    }];
    
    [self.stackView addArrangedSeparatorWithTitle:@"AMKColorHueSaturationView 色盘视图" color:nil size:12];
    [self.stackView addArrangedSubview:self.colorHueSaturationView];
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

- (AMKColorHueSaturationView *)colorHueSaturationView {
    if (!_colorHueSaturationView) {
        _colorHueSaturationView = [AMKColorHueSaturationView.alloc init];
        _colorHueSaturationView.height = 150;
    }
    return _colorHueSaturationView;
}

- (AMKColorPickerView *)colorPickerView {
    if (!_colorPickerView) {
        _colorPickerView = [AMKColorPickerView.alloc init];
        _colorPickerView.height = 150;
    }
    return _colorPickerView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
