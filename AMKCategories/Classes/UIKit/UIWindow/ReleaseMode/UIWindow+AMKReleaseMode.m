//
//  UIWindow+AMKReleaseMode.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/9.
//

#import "UIWindow+AMKReleaseMode.h"
#import <AMKCategories/UILabel+AMKLabelDrawing.h>
#import <objc/runtime.h>

const AMKViewLevel AMKViewLevelReleaseModeCornerMarkLabel = 99999.f;

/// 包释放模式
@interface UIWindow (_AMKReleaseMode)

/// 包释放模式 角标
@property(nonatomic, strong, nullable, readonly) UILabel *amk_releaseModeCornerMarkLabel;

@end

@implementation UIWindow (AMKReleaseMode)

#pragma mark - Init Methods

#pragma mark - Properties

- (UILabel *)amk_releaseModeCornerMarkLabel {
    UILabel *releaseModeCornerMarkLabel = objc_getAssociatedObject(self, @selector(amk_releaseModeCornerMarkLabel));
    if (!releaseModeCornerMarkLabel) {
        releaseModeCornerMarkLabel = [UILabel.alloc init];
        releaseModeCornerMarkLabel.hidden = YES;
        releaseModeCornerMarkLabel.alpha = 0.65;
        releaseModeCornerMarkLabel.layer.shadowOffset = CGSizeMake(0, 0);
        releaseModeCornerMarkLabel.layer.shadowOpacity = 0.5;
        releaseModeCornerMarkLabel.layer.shadowColor = UIColor.blackColor.CGColor;
        releaseModeCornerMarkLabel.layer.shadowRadius = 10;
        releaseModeCornerMarkLabel.transform = CGAffineTransformMakeRotation(45 * M_PI / 180.0);
        releaseModeCornerMarkLabel.layer.anchorPoint = CGPointMake(0.5, -1.5);
        releaseModeCornerMarkLabel.textColor = [UIColor whiteColor];
        releaseModeCornerMarkLabel.textAlignment = NSTextAlignmentCenter;
        releaseModeCornerMarkLabel.backgroundColor = [UIColor colorWithRed:0.86 green:0.22 blue:0.19 alpha:1.00];
        releaseModeCornerMarkLabel.adjustsFontSizeToFitWidth = YES;
        releaseModeCornerMarkLabel.amk_contentInset = UIEdgeInsetsMake(2, 15, 3, 15);
        releaseModeCornerMarkLabel.amk_viewLevel = AMKViewLevelReleaseModeCornerMarkLabel;
        releaseModeCornerMarkLabel.font = [UIFont boldSystemFontOfSize:12];
        releaseModeCornerMarkLabel.text = UIApplication.sharedApplication.amk_localizedReleaseModeString;
        [self addSubview:releaseModeCornerMarkLabel];
        
        // 添加约束
        // releaseModeCornerMarkLabel.frame = CGRectMake(0, 0, 70, 12);
        // releaseModeCornerMarkLabel.center = CGPointMake(CGRectGetMaxX(self.bounds), 0);
        releaseModeCornerMarkLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:releaseModeCornerMarkLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:releaseModeCornerMarkLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:12]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:releaseModeCornerMarkLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:releaseModeCornerMarkLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        objc_setAssociatedObject(self, @selector(amk_releaseModeCornerMarkLabel), releaseModeCornerMarkLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return releaseModeCornerMarkLabel;
}

#pragma mark - Layout Subviews

- (BOOL)amk_releaseModeCornerMarkEnable {
    return !self.amk_releaseModeCornerMarkLabel.hidden;
}

- (void)setAmk_releaseModeCornerMarkEnable:(BOOL)amk_releaseModeCornerMarkEnable {
    
//    application.delegate.window.amk_releaseModeCornerMarkLabel.hidden = application.amk_releaseMode==AMKUIApplicationReleaseModeAppStore ? YES : NO;
    
    
    self.amk_releaseModeCornerMarkLabel.hidden = !amk_releaseModeCornerMarkEnable;
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end

@implementation UIApplication (AMKReleaseMode)

- (BOOL)amk_releaseModeCornerMarkEnable {
    return !self.delegate.window.amk_releaseModeCornerMarkLabel.hidden;
}

- (void)setAmk_releaseModeCornerMarkEnable:(BOOL)amk_releaseModeCornerMarkEnable {
    self.delegate.window.amk_releaseModeCornerMarkLabel.hidden = !amk_releaseModeCornerMarkEnable;
}

@end

//#if defined(DEBUG)
//
//@implementation UIWindow (AMKReleaseModeTests)
//
//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self test_amk_releaseModeCornerMarkLabel];
//    });
//}
//
//+ (void)test_amk_releaseModeCornerMarkLabel {
//    UIApplication.sharedApplication.delegate.window.amk_releaseModeCornerMarkLabel.hidden = NO;
//}
//
//@end
//
//#endif
