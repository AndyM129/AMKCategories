//
//  AMK10310ExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2026/3/26.
//  Copyright © 2026 AndyM129. All rights reserved.
//

#import "AMK10310ExampleViewController.h"
#import "BDERectSelectionView.h"
#import <AMKCategories/UIImageView+AMKUIImageViewExtensionMethods.h>

@interface AMK10310ExampleViewController ()
@property (nonatomic, strong, readwrite, nullable) UIImageView *imageView;
@property (nonatomic, strong, readwrite, nullable) BDERectSelectionView *rectSelectionView;
@property (nonatomic, strong, readwrite, nullable) UIImageView *previewImageView;
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
    
    __weak __typeof__(self)weakSelf = self;
    [self.exampleStackView addArrangedTitleLabelWithTitle:@"BDERectSelectionView" customBlock:nil];
    [self.exampleStackView addArrangedSubtitleLabelWithTitle:@"自由选区" customBlock:nil];
    [self.exampleStackView addArrangedContainerViewWithCustomBlock:^(UIView * _Nullable containerView) {
        containerView.height = 500;
        containerView.backgroundColor = UIColor.blackColor;
        
        // 图片视图
        weakSelf.imageView = [UIImageView.alloc init];
        weakSelf.imageView.userInteractionEnabled = YES;
        weakSelf.imageView.contentMode = UIViewContentModeScaleAspectFit;
        weakSelf.imageView.image = [UIImage imageNamed:@"amk_10310_example_img_01"];
        [containerView addSubview:weakSelf.imageView];
        [weakSelf.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        // 矩形选区视图
        CGFloat kSelectionHandleImageViewTransformOffset = 3;
        weakSelf.rectSelectionView = [BDERectSelectionView.alloc init];
        weakSelf.rectSelectionView.contentInsets = UIEdgeInsetsMake(0, 25, 0, 25);
        weakSelf.rectSelectionView.selectionView.frame = CGRectMake(25, 25, 200, 150);
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeTopLeft layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.image = [UIImage imageNamed:@"amk_10310_example_img_handle_tl"];
            selectionHandleImageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -kSelectionHandleImageViewTransformOffset, -kSelectionHandleImageViewTransformOffset);
        }];
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeTopRight layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.image = [[UIImage imageNamed:@"amk_10310_example_img_handle_tl"] imageByRotate:DegreesToRadians(-90) fitSize:YES];
            selectionHandleImageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, kSelectionHandleImageViewTransformOffset, -kSelectionHandleImageViewTransformOffset);
        }];
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeBottomRight layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.image = [[UIImage imageNamed:@"amk_10310_example_img_handle_tl"] imageByRotate:DegreesToRadians(-180) fitSize:YES];
            selectionHandleImageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, kSelectionHandleImageViewTransformOffset, kSelectionHandleImageViewTransformOffset);
        }];
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeBottomLeft layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.image = [[UIImage imageNamed:@"amk_10310_example_img_handle_tl"] imageByRotate:DegreesToRadians(-270) fitSize:YES];
            selectionHandleImageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -kSelectionHandleImageViewTransformOffset, kSelectionHandleImageViewTransformOffset);
        }];
        [weakSelf.rectSelectionView.panGestureRecognizer addActionBlock:^(UIPanGestureRecognizer *panGestureRecognizer) {
            CGRect imageRect = [weakSelf.imageView amk_convertRectToImage:weakSelf.rectSelectionView.selectionView.frame];
            weakSelf.previewImageView.image = [weakSelf.imageView.image imageByCropToRect:imageRect];
        }];
        [weakSelf.imageView addSubview:weakSelf.rectSelectionView];
        [weakSelf.rectSelectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }];
    
    [self.exampleStackView addArrangedSubtitleLabelWithTitle:@"选区结果" customBlock:nil];
    [self.exampleStackView addArrangedContainerViewWithCustomBlock:^(UIView * _Nullable containerView) {
        containerView.height = 100;
        
        // 结果预览
        weakSelf.previewImageView = [UIImageView.alloc init];
        weakSelf.previewImageView.contentMode = UIViewContentModeScaleAspectFit;
        [containerView addSubview:weakSelf.previewImageView];
        [weakSelf.previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
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
