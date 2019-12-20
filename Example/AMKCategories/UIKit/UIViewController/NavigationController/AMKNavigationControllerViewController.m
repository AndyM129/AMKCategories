//
//  AMKNavigationControllerViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2019/12/20.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import "AMKNavigationControllerViewController.h"

@interface AMKNavigationControllerViewController ()

@end

@implementation AMKNavigationControllerViewController

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIViewController amk_gotoViewController:[self new] transitionStyle:AMKViewControllerTransitionStylePush animated:YES];
    });
}

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
    [self addTestButtonWithTitle:@"AAA" target:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addTestButtonWithTitle:@"AAA" target:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addTestButtonWithTitle:@"AAA" target:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addTestButtonWithTitle:@"AAA" target:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)didClickButton:(id)sender {
    
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

static NSInteger kIndex = -1;
- (UIButton *)addTestButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;{
    kIndex++;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 10000 + kIndex;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:button.tintColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[button.tintColor colorByAddColor:UIColor.lightGrayColor blendMode:kCGBlendModeMultiply]] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:controlEvents];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.view).offset(kIndex * 60 + 15);
    }];
    return button;
}

@end
