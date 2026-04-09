//
//  AMK10310ExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2026/3/26.
//  Copyright © 2026 AndyM129. All rights reserved.
//

#import "AMK10310ExampleViewController.h"
#import "BDERectSelectionView.h"
#import <AMKCategories/UIView+AMKInteractions.h>
#import <AMKCategories/UIImageView+AMKUIImageViewExtensionMethods.h>
#import <AMKCategories/MBProgressHUD+AMKCategories.h>

@interface AMK10310ExampleViewController ()
@property (nonatomic, strong, readwrite, nullable) UIImageView *imageView;
@property (nonatomic, strong, readwrite, nullable) BDERectSelectionView *rectSelectionView;
@property (nonatomic, strong, readwrite, nullable) UIImageView *resultImageView;
@property (nonatomic, assign, readwrite) NSInteger rotateDegrees; //!< 向左旋转：已旋转度数，默认 0
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
    [self.imageView removeObserverBlocks];
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
    [self.exampleStackView addArrangedSubtitleLabelWithTitle:@"自由选区" customBlock:^(UILabel * _Nullable subtitleLabel) {
        subtitleLabel.userInteractionEnabled = YES;
        
        UIButton *rotateButton = [UIButton.alloc init];
        rotateButton.tintColor = subtitleLabel.tintColor;
        [rotateButton setImage:[[UIImage imageNamed:@"amk_10310_example_rotate_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [rotateButton addTarget:weakSelf action:@selector(rotateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [subtitleLabel addSubview:rotateButton];
        [rotateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(36);
            make.centerY.right.mas_equalTo(subtitleLabel);
        }];
    }];
    [self.exampleStackView addArrangedContainerViewWithCustomBlock:^(UIView * _Nullable containerView) {
        containerView.height = 500;
        containerView.backgroundColor = UIColor.blackColor;
        
        // 图片视图
        weakSelf.imageView = [UIImageView.alloc init];
        weakSelf.imageView.userInteractionEnabled = YES;
        weakSelf.imageView.contentMode = UIViewContentModeScaleAspectFit;
        weakSelf.imageView.image = [UIImage imageNamed:@"amk_10310_example_img_01"];
        [weakSelf.imageView addObserverBlockForKeyPath:@"bounds" block:^(UIView *_Nonnull view, NSValue *oldVal, NSValue *newVal) {
            if (![newVal isEqualToValue:oldVal]) {
                CGRect imageRect = weakSelf.imageView.amk_imageRect;
                weakSelf.rectSelectionView.contentInsets = UIEdgeInsetsMake(imageRect.origin.y, imageRect.origin.x, imageRect.origin.y, imageRect.origin.x);
            }
        }];
        [containerView addSubview:weakSelf.imageView];
        [weakSelf.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        // 矩形选区视图
        UIImage *selectionHandleImage = [UIImage imageNamed:@"amk_10310_example_img_handle_tl_new"];
        CGSize selectionHandleViewSize = CGSizeMake(42, 42);
        weakSelf.rectSelectionView = [BDERectSelectionView.alloc init];
        weakSelf.rectSelectionView.selectionView.frame = CGRectMake(25, 25, 150, 200);
        weakSelf.rectSelectionView.selectionView.amk_interactionEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
        weakSelf.rectSelectionView.minSelectionSize = CGSizeMake(60, 80);
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeTopLeft layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.image = selectionHandleImage;
            selectionHandleImageView.amk_interactionEdgeInsets = UIEdgeInsetsMake(-1, -1, -1, -1);
            [selectionHandleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(selectionHandleViewSize);
                make.centerY.mas_equalTo(selectionHandleImageView.superview.mas_top);
                make.centerX.mas_equalTo(selectionHandleImageView.superview.mas_left);
            }];
        }];
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeTopRight layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.image = [selectionHandleImage imageByRotate:DegreesToRadians(-90) fitSize:YES];
            selectionHandleImageView.amk_interactionEdgeInsets = UIEdgeInsetsMake(-1, -1, -1, -1);
            [selectionHandleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(selectionHandleViewSize);
                make.centerY.mas_equalTo(selectionHandleImageView.superview.mas_top);
                make.centerX.mas_equalTo(selectionHandleImageView.superview.mas_right);
            }];
        }];
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeBottomRight layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.image = [selectionHandleImage imageByRotate:DegreesToRadians(-180) fitSize:YES];
            selectionHandleImageView.amk_interactionEdgeInsets = UIEdgeInsetsMake(-1, -1, -1, -1);
            [selectionHandleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(selectionHandleViewSize);
                make.centerY.mas_equalTo(selectionHandleImageView.superview.mas_bottom);
                make.centerX.mas_equalTo(selectionHandleImageView.superview.mas_right);
            }];
        }];
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeBottomLeft layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.image = [selectionHandleImage imageByRotate:DegreesToRadians(-270) fitSize:YES];
            selectionHandleImageView.amk_interactionEdgeInsets = UIEdgeInsetsMake(-1, -1, -1, -1);
            [selectionHandleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(selectionHandleViewSize);
                make.centerY.mas_equalTo(selectionHandleImageView.superview.mas_bottom);
                make.centerX.mas_equalTo(selectionHandleImageView.superview.mas_left);
            }];
        }];
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeTop layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
//            selectionHandleImageView.amk_interactionEdgeInsets = UIEdgeInsetsMake(-20, 0, -20, 0);
        }];
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeRight layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
//            selectionHandleImageView.amk_interactionEdgeInsets = UIEdgeInsetsMake(0, -20, 0, -20);
        }];
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeBottom layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
//            selectionHandleImageView.amk_interactionEdgeInsets = UIEdgeInsetsMake(-20, 0, -20, 0);
        }];
        [weakSelf.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeLeft layoutBlcok:^(BDERectSelectionView * _Nullable rectSelectionView, UIImageView * _Nullable selectionHandleImageView) {
            selectionHandleImageView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
//            selectionHandleImageView.amk_interactionEdgeInsets = UIEdgeInsetsMake(0, -20, 0, -20);
        }];
        [weakSelf.rectSelectionView.panGestureRecognizer addActionBlock:^(UIPanGestureRecognizer *panGestureRecognizer) {
            [weakSelf updateResultImageView:panGestureRecognizer];
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
        weakSelf.resultImageView = [UIImageView.alloc init];
        weakSelf.resultImageView.contentMode = UIViewContentModeScaleAspectFit;
        [containerView addSubview:weakSelf.resultImageView];
        [weakSelf.resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (void)rotateButtonClicked:(id)sender {
    //[MBProgressHUD amk_showTextHUDWithMessage:@"旋转" inView:weakSelf.view responder:nil duration:1 animated:YES];
    
    self.rotateDegrees = self.rotateDegrees - 90;
    CGFloat scaleFactor = (self.rotateDegrees / 90 % 2 == 0) ? 1 : (self.imageView.width / self.imageView.height);
    NSLog(@"scaleFactor = %.2f", scaleFactor);
    
    // 修正选区视图的方向、大小
    CGAffineTransform artImageTransform = CGAffineTransformIdentity;
    artImageTransform = CGAffineTransformRotate(artImageTransform, DegreesToRadians(self.rotateDegrees)); // 旋转
    artImageTransform = CGAffineTransformScale(artImageTransform, scaleFactor, scaleFactor); // 缩放
    self.imageView.transform = artImageTransform;
    
    // 将被缩放的 四个角的控制点视图，反向缩放，以保持视觉大小的不变
    CGAffineTransform selectionHandleImageViewTransform = CGAffineTransformScale(CGAffineTransformIdentity, 1 / scaleFactor, 1 / scaleFactor);
    [self.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeTopLeft].transform = selectionHandleImageViewTransform;
    [self.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeTopRight].transform = selectionHandleImageViewTransform;
    [self.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeBottomRight].transform = selectionHandleImageViewTransform;
    [self.rectSelectionView selectionHandleImageViewWithType:BDERectSelectionViewHandleTypeBottomLeft].transform = selectionHandleImageViewTransform;
    
    // 更新结果
    [self updateResultImageView:sender];
}

- (void)updateResultImageView:(id)sender {
    CGRect imageRect = [self.imageView amk_convertRectToImageCoordinate:self.rectSelectionView.selectionView.frame];
    self.resultImageView.image = [[self.imageView.image imageByCropToRect:imageRect] imageByRotate:DegreesToRadians(-self.rotateDegrees) fitSize:YES];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
