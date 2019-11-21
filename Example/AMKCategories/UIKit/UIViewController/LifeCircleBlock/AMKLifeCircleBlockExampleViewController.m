//
//  AMKLifeCircleBlockExampleViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2019/11/2.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import "AMKLifeCircleBlockExampleViewController.h"
#import <Masonry/Masonry.h>

@interface AMKLifeCircleBlockExampleViewController ()
@property(nonatomic, strong, nullable) UITextField *textField;
@property(nonatomic, strong, nullable) UITextView *textView;
@end

@implementation AMKLifeCircleBlockExampleViewController

//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UINavigationController *rootViewController = (UINavigationController *)UIApplication.sharedApplication.delegate.window.rootViewController;
//        [rootViewController pushViewController:AMKLifeCircleBlockExampleViewController.new animated:YES];
//    });
//}

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视图控制器生命周期相关Hook扩展";
    self.view.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"输入以测试系统输入法候选词展开显示异常的问题";
    self.textView.text = @"输入以测试系统输入法候选词展开显示异常的问题";
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
            make.top.mas_equalTo(10);
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(self.view).offset(-40);
            make.height.mas_equalTo(30);
        }];
    }
    return _textField;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView.alloc init];
        _textView.layer.borderColor = [UIColor colorWithWhite:.3 alpha:1].CGColor;
        _textView.layer.cornerRadius = 5;
        _textView.layer.borderWidth = 1 / UIScreen.mainScreen.scale;
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_textField.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(self.view).offset(-40);
            make.height.mas_equalTo(100);
        }];
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
