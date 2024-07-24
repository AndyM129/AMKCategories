//
//  AMK8350ExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "AMK8350ExampleViewController.h"
#import "WKNVoiceRecognitionButton.h"

@interface AMK8350ExampleViewController ()
@property (nonatomic, strong, readwrite, nullable) WKNVoiceRecognitionButton *voiceRecognitionButton;
@end

@implementation AMK8350ExampleViewController

//+ (void)load {
//    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
//        [NSNotificationCenter.defaultCenter removeObserver:token];
//        [UIViewController amk_pushViewController:[self.alloc init] animated:YES];
//    }];
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

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self viewCustomLayoutSubviews];
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

- (WKNVoiceRecognitionButton *)voiceRecognitionButton {
    if (!_voiceRecognitionButton) {
        _voiceRecognitionButton = [WKNVoiceRecognitionButton.alloc init];
        [self.view addSubview:_voiceRecognitionButton];
    }
    return _voiceRecognitionButton;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)viewCustomLayoutSubviews {
    if (!self.isViewLoaded) {
        return;
    }
    [self.voiceRecognitionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).inset(63);
        make.right.mas_equalTo(self.view).inset(10);
        make.bottom.mas_equalTo(self.view).inset(UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom + 5);
        make.height.mas_equalTo(self.voiceRecognitionButton.height);
    }];
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
