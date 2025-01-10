//
//  AMK9130PresentedViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/10/23.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "AMK9130PresentedViewController.h"

@interface AMK9130PresentedViewController ()

@end

@implementation AMK9130PresentedViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
        self.fd_prefersNavigationBarHidden = YES;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak __typeof__(self)weakSelf = self;
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
    
    [self.stackView addArrangedButton:@"返回上一页：带动画" controlEvents:UIControlEventTouchUpInside block:^(UIButton* sender) {
        [weakSelf amk_goBackAnimated:YES];
    }];
    [self.stackView addArrangedButton:@"返回上一页：无动画" controlEvents:UIControlEventTouchUpInside block:^(UIButton* sender) {
        [weakSelf amk_goBackAnimated:NO];
    }];
    
    [self.stackView addArrangedSeparatorWithTitle:nil color:UIColor.clearColor size:60];
    [self.stackView addArrangedButton:@"XX模板" controlEvents:UIControlEventTouchUpInside block:^(UIButton* sender) {
        NSLog(@"待实现...");
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

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
