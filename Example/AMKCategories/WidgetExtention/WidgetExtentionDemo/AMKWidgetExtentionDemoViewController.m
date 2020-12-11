//
//  AMKWidgetExtentionDemoViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2020/12/11.
//  Copyright © 2020 AndyM129. All rights reserved.
//

#import "AMKWidgetExtentionDemoViewController.h"

@interface AMKWidgetExtentionDemoViewController ()
@property(nonatomic, strong, nullable) UITextField *textField;
@property(nonatomic, strong, nullable) UIButton *button;
@property(nonatomic, strong, nullable) NSUserDefaults *userDefaults;
@end

@implementation AMKWidgetExtentionDemoViewController

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIViewController amk_pushViewController:self.new animated:YES];
    });
}

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WidgetExtentionDemo 测试";
    self.view.backgroundColor = [UIColor whiteColor];
    self.textField.text = [self.userDefaults stringForKey:@"widget"];
    self.button.hidden = NO;
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

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField.alloc init];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(UIApplication.sharedApplication.statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height + 10);
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(self.view).offset(-40);
            make.height.mas_equalTo(30);
        }];
    }
    return _textField;
}

- (UIButton *)button {
    if (!_button) {
        __weak __typeof__(self)weakSelf = self;
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.layer.borderColor = _button.tintColor.CGColor;
        _button.layer.cornerRadius = 5;
        _button.layer.borderWidth = 1 / UIScreen.mainScreen.scale;
        [_button setTitle:@"保存" forState:UIControlStateNormal];
        [_button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.userDefaults setObject:weakSelf.textField.text forKey:@"widget"];
            [weakSelf.userDefaults synchronize];
            NSLog(@"%@", weakSelf.userDefaults.dictionaryRepresentation);
        }];
        [self.view addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_textField.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(self.view).offset(-40);
            make.height.mas_equalTo(50);
        }];
    }
    return _button;
}

- (NSUserDefaults *)userDefaults {
    if (!_userDefaults) {
        _userDefaults = [NSUserDefaults.alloc initWithSuiteName:AMKAppGroup];
    }
    return _userDefaults;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Helper Methods

@end
