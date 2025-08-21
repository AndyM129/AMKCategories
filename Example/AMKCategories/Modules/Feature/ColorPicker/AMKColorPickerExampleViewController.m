//
//  AMKColorPickerExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKColorPickerExampleViewController.h"
#import "AMKColorSaturationBrightnessPickerView.h"
#import "AMKColorHuePickerView.h"
#import <AMKCategories/UIView+AMKCornerRadii.h>
#import <AMKCategories/MBProgressHUD+AMKCategories.h>

@interface AMKColorPickerExampleViewController ()
@property (nonatomic, strong, readwrite, nullable) AMKColorSaturationBrightnessView *colorSaturationBrightnessView;
@property (nonatomic, strong, readwrite, nullable) AMKColorSaturationBrightnessPickerView *colorSaturationBrightnessPickerView;
//@property (nonatomic, strong, readwrite, nullable) AMKColorHueView *colorHueView;
//@property (nonatomic, strong, readwrite, nullable) AMKColorHuePickerView *colorHuePickerView;
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
        self.fd_interactivePopDisabled = YES;
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof__(self)weakSelf = self;
//    [self.stackView addArrangedSeparatorWithTitle:@"UIColorPickerViewController 系统取色页" color:nil size:12];
//    [self.stackView addArrangedButton:@"显示" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        if (@available(iOS 14.0, *)) {
//            UIColorPickerViewController *viewController = [UIColorPickerViewController.alloc init];
//            [UIViewController amk_presentViewController:viewController animated:YES];
//        } else {
//            [MBProgressHUD amk_showTextHUDWithTitle:weakSelf.title message:@"Only iOS 14.0+" inView:nil responder:nil duration:2 animated:YES];
//        }
//    }];
    
    [self.stackView addArrangedSeparatorWithTitle:@"AMKColorSaturationBrightnessView 指定色相的 色相&亮度 视图" color:nil size:12];
    [self.stackView addArrangedSubview:self.colorSaturationBrightnessView];
    [self.stackView addArrangedButton:@"换个色相" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorSaturationBrightnessView.hue = arc4random() % 100 / 100.0;
    }];
    
    [self.stackView addArrangedSeparatorWithTitle:@"AMKColorSaturationBrightnessPickerView 指定色相的 色相&亮度 选择器（可交互）" color:nil size:12];
    [self.stackView addArrangedSubview:self.colorSaturationBrightnessPickerView];
//    [self.stackView addArrangedButton:@"换个色相" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        weakSelf.colorSaturationBrightnessPickerView.hue = arc4random() % 100 / 100.0;
//    }];
    
//    [self.stackView addArrangedSeparatorWithTitle:@"AMKColorHueView 色相视图（纯展示）" color:nil size:12];
//    [self.stackView addArrangedSubview:self.colorHueView];
    
//    [self.stackView addArrangedSeparatorWithTitle:@"AMKColorHuePickerView 色相选择滑块（可交互）" color:nil size:12];
//    [self.stackView addArrangedSubview:self.colorHuePickerView];
//    [self.stackView addArrangedButton:@"换个色相" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        weakSelf.colorHuePickerView.hue = arc4random() % 100 / 100.0;
//    }];
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

- (AMKColorSaturationBrightnessView *)colorSaturationBrightnessView {
    if (!_colorSaturationBrightnessView) {
        _colorSaturationBrightnessView = [AMKColorSaturationBrightnessView.alloc init];
        _colorSaturationBrightnessView.height = 150;
    }
    return _colorSaturationBrightnessView;
}

- (AMKColorSaturationBrightnessPickerView *)colorSaturationBrightnessPickerView {
    if (!_colorSaturationBrightnessPickerView) {
        _colorSaturationBrightnessPickerView = [AMKColorSaturationBrightnessPickerView.alloc init];
        _colorSaturationBrightnessPickerView.height = 150;
        _colorSaturationBrightnessPickerView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    }
    return _colorSaturationBrightnessPickerView;
}

//- (AMKColorHueView *)colorHueView {
//    if (!_colorHueView) {
//        _colorHueView = [AMKColorHueView.alloc init];
//        _colorHueView.height = 5;
//        _colorHueView.amk_cornerRadii = AMKCornerRadiiMakeAll(_colorHueView.height / 2);
//    }
//    return _colorHueView;
//}

//- (AMKColorHuePickerView *)colorHuePickerView {
//    if (!_colorHuePickerView) {
//        __weak __typeof__(self)weakSelf = self;
//        _colorHuePickerView = [AMKColorHuePickerView.alloc init];
//        _colorHuePickerView.height = 30;
//        _colorHuePickerView.hueView.amk_cornerRadii = AMKCornerRadiiMakeAll(AMKColorHuePickerView.hueViewDefaultHeight / 2);
//        _colorHuePickerView.hue = 0.2;
//        _colorHuePickerView.hueChangedBlock = ^(AMKColorHuePickerView * _Nonnull colorHuePickerView) {
//            weakSelf.colorSaturationBrightnessPickerView.hue = colorHuePickerView.hue;
//        };
//    }
//    return _colorHuePickerView;
//}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
