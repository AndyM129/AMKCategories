//
//  AMKLottieExampleViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/12/26.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKLottieExampleViewController.h"
#import "WKNVipBenefitsAnimationView.h"
#import <AMKCategories/CAAnimation+AMKAnimationDelegate.h>
#import <Lottie/Lottie.h>

static NSInteger kAnimationBackgroundViewTag = 1000;

@interface AMKLottieExampleViewController ()
@property (nonatomic, strong, readwrite, nullable) AMKStackView *stackView;
@end

@implementation AMKLottieExampleViewController

//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIViewController amk_pushViewController:self.new animated:YES];
//    });
//}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Lottie 动画示例";
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor?:[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"移除动画" style:UIBarButtonItemStylePlain target:self action:nil];
    
    //[self test_0];
    [self test_1];
    [self test_2];
    [self test_3];
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

- (AMKStackView *)stackView {
    if (!_stackView) {
        _stackView = [AMKStackView.alloc initWithAxis:UILayoutConstraintAxisVertical spacing:10];
        [self.view addSubview:_stackView];
        [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
    }
    return _stackView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Tests

- (void)test_0 {
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedButton:@"基础动画" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        UIView *animationView = [UIView.alloc initWithFrame:CGRectMake(0, 0, 150, 150)];
        animationView.center = weakSelf.view.center;
        animationView.backgroundColor = UIColor.orangeColor;
        [weakSelf.view addSubview:animationView];
        __weak UIView *weakAnimationView = animationView;
        
//        // 位移动画
//        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//        positionAnimation.fromValue = [NSValue valueWithCGPoint:animationView.layer.position];
//        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointZero];
//        positionAnimation.duration = 1;
//        positionAnimation.fillMode = kCAFillModeForwards;
//        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        positionAnimation.repeatCount = 1; //CGFLOAT_MAX;
//        positionAnimation.removedOnCompletion = NO;
//        [positionAnimation setAmk_animationDidStopBlock:^(CAAnimation * _Nullable animation, BOOL finished) {
//            [weakAnimationView removeFromSuperview];
//        }];
//        [animationView.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        
//        // 旋转动画：抖动
//        CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
//        shakeAnimation.values = @[@(0/360.0*M_PI), @(-20/180.0*M_PI), @(20/180.0*M_PI), @(-20/180.0*M_PI), @(20/180.0*M_PI), @(0/360.0*M_PI)];
//        shakeAnimation.keyTimes = @[@(0), @(0.1), @(0.2), @(0.3), @(0.4), @(0.5), @(1)];
//        shakeAnimation.fillMode = kCAFillModeForwards;
//        shakeAnimation.duration = 1.0;
//        shakeAnimation.fillMode = kCAFillModeForwards;
//        shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//        shakeAnimation.repeatCount = CGFLOAT_MAX;
//        shakeAnimation.removedOnCompletion = YES;
//        [shakeAnimation setAmk_animationDidStopBlock:^(CAAnimation * _Nullable animation, BOOL finished) {
//            [weakAnimationView removeFromSuperview];
//        }];
//        [animationView.layer addAnimation:shakeAnimation forKey:@"shakeAnimation"];
        
        // 移除按钮
        [weakSelf.navigationItem.rightBarButtonItem setActionBlock:^(UIBarButtonItem *barButtonItem) {
            [weakAnimationView removeFromSuperview];
        }];
    }];
}

- (void)test_1 {
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedButton:@"示例: Christmas" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        UIView *animationBackgroundView = [UIView.alloc init];
        animationBackgroundView.tag = kAnimationBackgroundViewTag;
        animationBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [weakSelf.view addSubview:animationBackgroundView];
        [animationBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        LOTAnimationView *animationView = [LOTAnimationView animationNamed:@"christmas"];
        [animationBackgroundView addSubview:animationView];
        [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.view);
            make.centerY.mas_equalTo(weakSelf.view).multipliedBy(0.7);
            make.width.height.mas_equalTo(weakSelf.view.frame.size.width);
        }];
        
        __weak LOTAnimationView *weakAnimationView = animationView;
        [animationView playWithCompletion:^(BOOL animationFinished) {
            [weakAnimationView.superview removeFromSuperview];
        }];
        
        // 移除按钮
        [weakSelf.navigationItem.rightBarButtonItem setActionBlock:^(UIBarButtonItem *barButtonItem) {
            [weakAnimationView.superview removeFromSuperview];
        }];
    }];
}

- (void)test_2 {
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedButton:@"示例: 自定义" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        UIView *animationBackgroundView = [UIView.alloc init];
        animationBackgroundView.tag = kAnimationBackgroundViewTag;
        animationBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [weakSelf.view addSubview:animationBackgroundView];
        [animationBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        LOTAnimationView *animationView = [LOTAnimationView animationNamed:@"christmas"];
        [animationBackgroundView addSubview:animationView];
        [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.view);
            make.centerY.mas_equalTo(weakSelf.view).multipliedBy(0.7);
            make.width.height.mas_equalTo(weakSelf.view.frame.size.width);
        }];
        
        __weak LOTAnimationView *weakAnimationView = animationView;
        [animationView playWithCompletion:^(BOOL animationFinished) {
            NSMutableArray<CAAnimation *> *animations = @[].mutableCopy;
            [animations addObject:({
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                animation.fromValue = [NSNumber numberWithFloat:1.0];
                animation.toValue = [NSNumber numberWithFloat:0.01];
                animation;
            })];
            [animations addObject:({
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
                animation.fromValue = [NSNumber numberWithFloat:1.0];
                animation.toValue = [NSNumber numberWithFloat:0.0];
                animation;
            })];
            
            // 主体动画
            CAAnimationGroup *animationGroup = [CAAnimationGroup.alloc init];
            animationGroup.animations = animations;
            animationGroup.duration = 0.5;
            animationGroup.fillMode = kCAFillModeForwards;
            animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            animationGroup.removedOnCompletion = NO;
            [weakAnimationView.layer addAnimation:animationGroup forKey:@"animationGroup"];
            
            // 背景动画
            CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
            opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
            opacityAnimation.duration = animationGroup.duration;
            opacityAnimation.fillMode = animationGroup.fillMode;
            opacityAnimation.timingFunction = animationGroup.timingFunction;
            opacityAnimation.removedOnCompletion = NO;
            [weakAnimationView.superview.layer addAnimation:opacityAnimation forKey:@"opacityAnimation"];
        }];
        
        // 移除按钮
        [weakSelf.navigationItem.rightBarButtonItem setActionBlock:^(UIBarButtonItem *barButtonItem) {
            [weakAnimationView.superview removeFromSuperview];
        }];
    }];
}

- (void)test_3 {
    __weak __typeof__(self)weakSelf = self;
    
    [self.stackView addArrangedButton:@"示例: VIP Tab 福利角标动画" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        __weak UIView *weakDestinationView = weakSelf.destinationView;
        weakDestinationView.alpha = 1;
        [weakDestinationView.layer addAnimation:weakSelf.vipTabBenefitsBadgeAnimation forKey:@"vipTabBenefitsBadgeAnimation"];
        
        // 移除按钮
        [weakSelf.navigationItem.rightBarButtonItem setActionBlock:^(UIBarButtonItem *barButtonItem) {
            [weakDestinationView removeFromSuperview];
        }];
    }];
    
    [self.stackView addArrangedButton:@"示例: 会员福利 首页动画" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        __weak UIView *weakDestinationView = weakSelf.destinationView;
        weakDestinationView.alpha = 0;

        WKNVipBenefitsAnimationView *animationView = [WKNVipBenefitsAnimationView.alloc init];
        animationView.destinationView = weakDestinationView;
        [animationView setCompletionBlock:^(WKNVipBenefitsAnimationView * _Nullable animationView, BOOL animationFinished) {
            [weakDestinationView.layer addAnimation:weakSelf.vipTabBenefitsBadgeAnimation forKey:@"vipTabBenefitsBadgeAnimation"];
        }];
        [animationView playInView:weakSelf.navigationController.view];
        
        // 移除按钮
        __weak WKNVipBenefitsAnimationView *weakAnimationView = animationView;
        [weakSelf.navigationItem.rightBarButtonItem setActionBlock:^(UIBarButtonItem *barButtonItem) {
            [weakAnimationView removeFromSuperview];
            [weakDestinationView removeFromSuperview];
        }];
    }];
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

- (UIView *)destinationView {
    NSInteger tag = @"destinationView".hash;
    UIImageView *destinationView = [self.view viewWithTag:tag];
    if (!destinationView) {
        destinationView = [UIImageView.alloc init];
        destinationView.image = [UIImage imageNamed:@"wkn_vip_tab_benefits_badge"];
        destinationView.tag = tag;
        [self.view addSubview:destinationView];
        [destinationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(15);
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(100);
            make.bottom.mas_equalTo(-100);
        }];
    }
    return destinationView;
}

/// 会员Tab 福利角标动画
- (CAAnimation *)vipTabBenefitsBadgeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animation.values = @[@(0/360.0*M_PI), @(-20/180.0*M_PI), @(20/180.0*M_PI), @(-20/180.0*M_PI), @(20/180.0*M_PI), @(0/360.0*M_PI)];
    animation.keyTimes = @[@(0), @(0.1), @(0.2), @(0.3), @(0.4), @(0.5), @(1)];
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 1.0;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.repeatCount = CGFLOAT_MAX;
    animation.removedOnCompletion = YES;
    return animation;
}

@end
