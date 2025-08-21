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
@property (nonatomic, strong, readwrite, nullable) AMKColorHueView *colorHueView;
@property (nonatomic, strong, readwrite, nullable) AMKColorHuePickerView *colorHuePickerView;
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
    [self addExample_UIColorPickerViewController];
    //[self addExample_AMKColorSaturationBrightnessView];
    [self addExample_AMKColorSaturationBrightnessPickerView];
    //[self addExample_AMKColorHueView];
    [self addExample_AMKColorHuePickerView];
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
        _colorSaturationBrightnessView.height = 100;
    }
    return _colorSaturationBrightnessView;
}

- (AMKColorSaturationBrightnessPickerView *)colorSaturationBrightnessPickerView {
    if (!_colorSaturationBrightnessPickerView) {
        __weak __typeof__(self)weakSelf = self;
        _colorSaturationBrightnessPickerView = [AMKColorSaturationBrightnessPickerView.alloc init];
        _colorSaturationBrightnessPickerView.height = 100;
        _colorSaturationBrightnessPickerView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        
        // 自定义内边距
        [_colorSaturationBrightnessPickerView.saturationBrightnessView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 100));
        }];
        
        // 添加光标上的颜色预览
        UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithPointSize:30];
        UIImageView *previewView = [UIImageView.alloc initWithImage:[[[UIImage systemImageNamed:@"drop.fill" withConfiguration:configuration] imageByFlipVertical] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        previewView.tintColor = _colorSaturationBrightnessPickerView.saturationBrightnessView.selectedColor;
        [_colorSaturationBrightnessPickerView setAssociateValue:previewView withKey:@"previewView"];
        [_colorSaturationBrightnessPickerView.cursorView addSubview:previewView];
        [previewView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_colorSaturationBrightnessPickerView.cursorView.mas_centerX);
            make.bottom.mas_equalTo(_colorSaturationBrightnessPickerView.cursorView.mas_top);
        }];
        [_colorSaturationBrightnessPickerView.saturationBrightnessView addBlockForControlEvents:UIControlEventValueChanged block:^(id  _Nonnull sender) {
            UIImageView *previewView = [weakSelf.colorSaturationBrightnessPickerView getAssociatedValueForKey:@"previewView"];
            previewView.tintColor = weakSelf.colorSaturationBrightnessPickerView.saturationBrightnessView.selectedColor;
        }];
        
        // 添加光标上的颜色预览的描边
        UIImageView *previewOverlayView = [UIImageView.alloc initWithImage:[[[UIImage systemImageNamed:@"drop" withConfiguration:configuration] imageByFlipVertical] imageWithTintColor:UIColor.whiteColor]];
        [previewView addSubview:previewOverlayView];
        [previewOverlayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(previewView);
        }];
        
        // 监听值更新
        _colorSaturationBrightnessPickerView.backgroundColor = _colorSaturationBrightnessPickerView.saturationBrightnessView.selectedColor;
        [_colorSaturationBrightnessPickerView.saturationBrightnessView addBlockForControlEvents:UIControlEventValueChanged block:^(AMKColorSaturationBrightnessView *saturationBrightnessView) {
            weakSelf.colorSaturationBrightnessPickerView.backgroundColor = weakSelf.colorSaturationBrightnessPickerView.saturationBrightnessView.selectedColor;
        }];
    }
    return _colorSaturationBrightnessPickerView;
}

- (AMKColorHueView *)colorHueView {
    if (!_colorHueView) {
        _colorHueView = [AMKColorHueView.alloc init];
        _colorHueView.height = 5;
        _colorHueView.amk_cornerRadii = AMKCornerRadiiMakeAll(_colorHueView.height / 2);
    }
    return _colorHueView;
}

- (AMKColorHuePickerView *)colorHuePickerView {
    if (!_colorHuePickerView) {
        __weak __typeof__(self)weakSelf = self;
        _colorHuePickerView = [AMKColorHuePickerView.alloc init];
        _colorHuePickerView.height = 30;
        _colorHuePickerView.hueView.amk_cornerRadii = AMKCornerRadiiMakeAll(AMKColorHuePickerView.hueViewDefaultHeight / 2);
        _colorHuePickerView.selectedHue = 0.2;
        [_colorHuePickerView addBlockForControlEvents:UIControlEventValueChanged block:^(AMKColorHuePickerView *colorHuePickerView) {
            weakSelf.colorSaturationBrightnessView.hue = colorHuePickerView.selectedHue;
            weakSelf.colorSaturationBrightnessPickerView.saturationBrightnessView.hue = colorHuePickerView.selectedHue;
        }];
    }
    return _colorHuePickerView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

- (void)addExample_UIColorPickerViewController {
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
}

- (void)addExample_AMKColorSaturationBrightnessView {
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedSeparatorWithTitle:@"AMKColorSaturationBrightnessView 指定色相的 色相&亮度 视图" color:nil size:12];
    [self.stackView addArrangedSubview:({
        UIView *containerView = [UIView.alloc init];
        containerView.height = 100;
        [containerView addSubview:self.colorSaturationBrightnessView];
        containerView.backgroundColor = self.colorSaturationBrightnessView.selectedColor;
        [self.colorSaturationBrightnessView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 100));
        }];
        [self.colorSaturationBrightnessView addBlockForControlEvents:UIControlEventValueChanged block:^(AMKColorSaturationBrightnessView *colorSaturationBrightnessView) {
            colorSaturationBrightnessView.superview.backgroundColor = colorSaturationBrightnessView.selectedColor;
        }];
        containerView;
    })];
    [self.stackView addArrangedButton:@"换个色相" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorSaturationBrightnessView.hue = arc4random() % 100 / 100.0;
    }];
    [self.stackView addArrangedButton:@"换个饱和度" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorSaturationBrightnessView.saturation = arc4random() % 100 / 100.0;
    }];
    [self.stackView addArrangedButton:@"换个亮度" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorSaturationBrightnessView.brightness = arc4random() % 100 / 100.0;
    }];
    [self.stackView addArrangedButton:@"换个颜色" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorSaturationBrightnessView.selectedColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    }];
}

- (void)addExample_AMKColorSaturationBrightnessPickerView {
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedSeparatorWithTitle:@"AMKColorSaturationBrightnessPickerView 指定色相的 色相&亮度 选择器" color:nil size:12];
    [self.stackView addArrangedSubview:self.colorSaturationBrightnessPickerView];
    [self.stackView addArrangedButton:@"换个色相" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorSaturationBrightnessPickerView.saturationBrightnessView.hue = arc4random() % 100 / 100.0;
    }];
    [self.stackView addArrangedButton:@"换个饱和度" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorSaturationBrightnessPickerView.saturationBrightnessView.saturation = arc4random() % 100 / 100.0;
    }];
    [self.stackView addArrangedButton:@"换个亮度" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorSaturationBrightnessPickerView.saturationBrightnessView.brightness = arc4random() % 100 / 100.0;
    }];
    [self.stackView addArrangedButton:@"换个颜色" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorSaturationBrightnessPickerView.saturationBrightnessView.selectedColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    }];
}

- (void)addExample_AMKColorHueView {
    [self.stackView addArrangedSeparatorWithTitle:@"AMKColorHueView 色相视图（纯展示）" color:nil size:12];
    [self.stackView addArrangedSubview:self.colorHueView];
}

- (void)addExample_AMKColorHuePickerView {
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedSeparatorWithTitle:@"AMKColorHuePickerView 色相选择滑块（可交互）" color:nil size:12];
    [self.stackView addArrangedSubview:self.colorHuePickerView];
    [self.stackView addArrangedButton:@"换个色相" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorHuePickerView.selectedHue = arc4random() % 100 / 100.0;
    }];
    [self.stackView addArrangedButton:@"换个颜色" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        weakSelf.colorHuePickerView.selectedColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    }];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
