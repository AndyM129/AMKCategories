//
//  AMK10310ExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2026/3/26.
//  Copyright © 2026 AndyM129. All rights reserved.
//

#import "AMK10310ExampleViewController.h"
#import "BDERectSelectionView.h"

@interface AMK10310ExampleViewController ()

@end

@implementation AMK10310ExampleViewController

+ (void)load {
    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [NSNotificationCenter.defaultCenter removeObserver:token];
        [UIViewController amk_pushViewController:[self.alloc init] animated:YES];
    }];
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

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.exampleStackView addArrangedTitleLabelWithTitle:@"BDERectSelectionView" customBlock:nil];
    [self.exampleStackView addArrangedContainerViewWithCustomBlock:^(UIView * _Nullable containerCiew) {
        containerCiew.height = 400;
        
        BDERectSelectionView *rectSelectionView = [BDERectSelectionView.alloc init];
        rectSelectionView.selectionRect = CGRectMake(10, 10, 250, 150);
        rectSelectionView.backgroundColor = [UIColor colorWithRed:167/255.0 green:185/255.0 blue:223/255.0 alpha:1.0];;
        [containerCiew addSubview:rectSelectionView];
        [rectSelectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(containerCiew);
        }];
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

//- (void)rightBarButtonItemClicked:(id)sender {
//    NSString *title = @"相关调试功能";
//    NSString *message = nil;
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"模板库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIViewController *viewController = [UIViewController.alloc init];
//        viewController.
//
//
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    [self presentViewController:alertController animated:YES completion:nil];
//}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
