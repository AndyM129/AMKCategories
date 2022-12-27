//
//  WKNVipBenefitsAnimationView.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/12/26.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "WKNVipBenefitsAnimationView.h"
#import <AMKCategories/CAAnimation+AMKAnimationDelegate.h>
#import <Lottie/Lottie.h>

@interface WKNVipBenefitsAnimationView ()
@property (nonatomic, strong, readwrite, nullable) UIView *backgroundView;
@property (nonatomic, strong, readwrite, nullable) LOTAnimationView *contentView;
@end

@implementation WKNVipBenefitsAnimationView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - Getters & Setters

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView.alloc init];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [self addSubview:_backgroundView];
    }
    return _backgroundView;
}

- (LOTAnimationView *)contentView {
    if (!_contentView) {
        _contentView = [LOTAnimationView animationNamed:@"christmas"];
        [self addSubview:_contentView];
    }
    return _contentView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).multipliedBy(0.7);
        make.width.height.mas_equalTo(self.mas_width);
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

#pragma mark - Action Methods

- (void)playInView:(UIView *_Nullable)superview {
    __weak __typeof__(self)weakSelf = self;
    
    [superview addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
        
    // 背景：渐现
    [self.backgroundView.layer addAnimation:({
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = [NSNumber numberWithFloat:0];
        animation.toValue = [NSNumber numberWithFloat:1];
        animation.duration = 0.2;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animation;
    }) forKey:@"backgroundViewAnimation"];
    
    // 主体：播放动画
    [self.contentView playWithCompletion:^(BOOL animationFinished) {
        // 主体 的目标位置
        CGRect destinationRect = [weakSelf.destinationView.superview convertRect:weakSelf.destinationView.frame toView:weakSelf];
        CGPoint destinationPoint = CGPointMake(destinationRect.origin.x + destinationRect.size.width/2, destinationRect.origin.y + destinationRect.size.height/2);
        
        // 主体：缩小、渐隐
        CAAnimationGroup *contentViewAnimation = [CAAnimationGroup.alloc init];
        contentViewAnimation.animations = ({
            NSMutableArray<CAAnimation *> *animations = @[].mutableCopy;
            [animations addObject:({
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                animation.fromValue = [NSNumber numberWithFloat:1.0];
                animation.toValue = [NSNumber numberWithFloat:destinationRect.size.width / weakSelf.contentView.size.width];
                animation;
            })];
            [animations addObject:({
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
                animation.fromValue = [NSNumber numberWithFloat:1.0];
                animation.toValue = [NSNumber numberWithFloat:0.3];
                animation;
            })];
            [animations addObject:({
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
                animation.fromValue = [NSValue valueWithCGPoint:weakSelf.contentView.layer.position];
                animation.toValue = [NSValue valueWithCGPoint:destinationPoint];
                animation;
            })];
            animations;
        });
        contentViewAnimation.duration = 0.4;
        contentViewAnimation.fillMode = kCAFillModeForwards;
        contentViewAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        contentViewAnimation.removedOnCompletion = NO;
        [weakSelf.contentView.layer addAnimation:contentViewAnimation forKey:@"contentViewAnimation"];
        
        // 背景：渐隐
        CABasicAnimation *backgroundViewAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        backgroundViewAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        backgroundViewAnimation.toValue = [NSNumber numberWithFloat:0.0];
        backgroundViewAnimation.duration = contentViewAnimation.duration;
        backgroundViewAnimation.fillMode = kCAFillModeForwards;
        backgroundViewAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        backgroundViewAnimation.removedOnCompletion = NO;
        [weakSelf.backgroundView.layer addAnimation:backgroundViewAnimation forKey:@"backgroundViewAnimation"];
        
        // 目标视图：渐现
        CABasicAnimation *destinationViewAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        destinationViewAnimation.fromValue = [NSNumber numberWithFloat:0];
        destinationViewAnimation.toValue = [NSNumber numberWithFloat:1];
        destinationViewAnimation.beginTime = CACurrentMediaTime() + contentViewAnimation.duration * 0.5;
        destinationViewAnimation.duration = contentViewAnimation.duration * 0.5;
        destinationViewAnimation.fillMode = kCAFillModeForwards;
        destinationViewAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        destinationViewAnimation.removedOnCompletion = YES;
        [destinationViewAnimation setAmk_animationDidStopBlock:^(CAAnimation * _Nullable animation, BOOL finished) {
            [weakSelf removeFromSuperview];
            weakSelf.destinationView.alpha = 1;
            !weakSelf.completionBlock ?: weakSelf.completionBlock(weakSelf, finished);
        }];
        [weakSelf.destinationView.layer addAnimation:destinationViewAnimation forKey:@"destinationViewAnimation"];
    }];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
