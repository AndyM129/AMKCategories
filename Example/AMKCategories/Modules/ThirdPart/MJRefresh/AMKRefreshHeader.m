//
//  AMKRefreshHeader.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/11/7.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKRefreshHeader.h"

@interface AMKRefreshHeader ()
@property (nonatomic, assign, readwrite) AMKRefreshScene scene;
@property (nonatomic, strong, readwrite, nullable) AMKRefreshHeaderToastView *toastView;
@end

@implementation AMKRefreshHeader

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - Getters & Setters

- (AMKRefreshHeaderToastView *)toastView {
    if (!_toastView) {
        _toastView = [AMKRefreshHeaderToastView.alloc initWithFrame:self.bounds];
        _toastView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _toastView.alpha = 0;
        _toastView.backgroundColor = self.backgroundColor;
        [self addSubview:_toastView];
    }
    return _toastView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    // Coding ...
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

#pragma mark - Action Methods

- (void)beginRefreshingWithScene:(AMKRefreshScene)scene completionBlock:(MJRefreshComponentAction)completionBlock {
    self.scene = scene;
    [super beginRefreshingWithCompletionBlock:completionBlock];
}

- (void)endRefreshing {
    NSTimeInterval toastDuration = self.willEndRefreshingBlock ? self.willEndRefreshingBlock(self) : 0;
    !toastDuration ?: [self.toastView show:YES animated:YES completion:nil];
    [self performSelector:@selector(didEndRefreshing) afterDelay:toastDuration];
}

- (void)didEndRefreshing {
    __weak __typeof__(self)weakSelf = self;
    [super endRefreshing];
    self.scene = AMKRefreshSceneDefault;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.slowAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.toastView show:NO animated:NO completion:nil];
    });
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods


@end
