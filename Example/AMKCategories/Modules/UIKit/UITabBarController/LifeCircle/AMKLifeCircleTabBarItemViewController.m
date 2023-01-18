//
//  AMKLifeCircleTabBarItemViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/12/29.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKLifeCircleTabBarItemViewController.h"
#import "AMKLifeCircleTabBarSubViewController.h"

@interface AMKLifeCircleTabBarItemViewController ()

@end

@implementation AMKLifeCircleTabBarItemViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", self.title);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%@", self.title);
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

- (BOOL)amk_goBackAnimated:(BOOL)animated {
    BOOL didGoBack = [super amk_goBackAnimated:animated];
    
    if (!didGoBack) {
        didGoBack = [self.tabBarController amk_goBackAnimated:animated];
    }
    
    return didGoBack;
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
