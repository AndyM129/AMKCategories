//
//  AMKContentHuggingPriorityViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/6/7.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKContentHuggingPriorityViewController.h"
#import "AMKContentHuggingPriorityControl.h"

@interface AMKContentHuggingPriorityViewController ()
@property (nonatomic, strong, readwrite, nullable) UIView *contentView;
@property (nonatomic, strong, readwrite, nullable) AMKContentHuggingPriorityControl *leftLabelControl;
@property (nonatomic, strong, readwrite, nullable) AMKContentHuggingPriorityControl *rightLabelControl;
@end

@implementation AMKContentHuggingPriorityViewController

//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIViewController amk_pushViewController:self.new animated:YES];
//    });
//}

#pragma mark - Dealloc

- (void)dealloc {
    [_leftLabelControl removeObserverBlocks];
    [_rightLabelControl removeObserverBlocks];
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"抗拉伸 / 抗压缩";
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor?:[UIColor whiteColor];
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

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView.alloc init];
        _contentView.layer.borderWidth = 1;
        _contentView.layer.borderColor = UIColor.lightGrayColor.CGColor;
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

- (AMKContentHuggingPriorityControl *)leftLabelControl {
    if (!_leftLabelControl) {
        _leftLabelControl = [AMKContentHuggingPriorityControl.alloc init];
        [self.view addSubview:_leftLabelControl];

        _leftLabelControl.label.textColor = UIColor.redColor;
        _leftLabelControl.label.backgroundColor = [_leftLabelControl.label.textColor colorWithAlphaComponent:.3];
        [self.contentView addSubview:_leftLabelControl.label];
    }
    return _leftLabelControl;
}

- (AMKContentHuggingPriorityControl *)rightLabelControl {
    if (!_rightLabelControl) {
        _rightLabelControl = [AMKContentHuggingPriorityControl.alloc init];
        [self.view addSubview:_rightLabelControl];
        
        _rightLabelControl.label.textColor = UIColor.blueColor;
        _rightLabelControl.label.backgroundColor = [_rightLabelControl.label.textColor colorWithAlphaComponent:.3];
        [self.contentView addSubview:_rightLabelControl.label];
    }
    return _rightLabelControl;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)updateViewConstraints {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).offset(-30);
        make.height.mas_equalTo(80);
        make.top.mas_equalTo(self.view.mas_top).offset(15);
    }];
    [self.leftLabelControl.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).inset(5);
        //make.right.mas_lessThanOrEqualTo(self.rightLabelControl.label.mas_left).inset(5);
        make.top.mas_equalTo(self.contentView).inset(5);
        make.bottom.mas_equalTo(self.contentView).inset(5);
    }];
    [self.rightLabelControl.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_greaterThanOrEqualTo(self.leftLabelControl.label.mas_right).offset(5);
        make.right.mas_equalTo(self.contentView).inset(5);
        make.top.mas_equalTo(self.contentView).inset(5);
        make.bottom.mas_equalTo(self.contentView).inset(5);
    }];
    
    [self.leftLabelControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).offset(-30);
        make.height.mas_equalTo(150);
        make.top.mas_equalTo(self.contentView.mas_bottom).offset(50);
    }];
    [self.rightLabelControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).offset(-30);
        make.height.mas_equalTo(150);
        make.top.mas_equalTo(self.leftLabelControl.mas_bottom).offset(50);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Overrides

#pragma mark - Helper Methods

@end
