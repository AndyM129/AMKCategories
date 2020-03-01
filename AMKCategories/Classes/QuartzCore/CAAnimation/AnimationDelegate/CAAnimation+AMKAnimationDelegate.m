//
//  CAAnimation+AMKAnimationDelegate.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/3/1.
//

#import "CAAnimation+AMKAnimationDelegate.h"
#import <objc/runtime.h>

@implementation CAAnimation (AMKCAAnimationDelegate)

#pragma mark - Init Methods

#pragma mark - Properties

- (BOOL)amk_isAnimating {
    return [objc_getAssociatedObject(self, @selector(amk_isAnimating)) boolValue];
}

- (void)setAmk_animating:(BOOL)amk_animating {
    objc_setAssociatedObject(self, @selector(amk_animating), [NSNumber numberWithBool:amk_animating], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(CAAnimation * _Nullable))amk_animationDidStartBlock {
    return objc_getAssociatedObject(self, @selector(amk_animationDidStartBlock));
}

- (void)setAmk_animationDidStartBlock:(void (^)(CAAnimation * _Nullable))amk_animationDidStartBlock {
    if (self.delegate != self) self.delegate = self;
    objc_setAssociatedObject(self, @selector(amk_animationDidStartBlock), [amk_animationDidStartBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(CAAnimation * _Nullable, BOOL))amk_animationDidStopBlock {
    return objc_getAssociatedObject(self, @selector(amk_animationDidStopBlock));
}

- (void)setAmk_animationDidStopBlock:(void (^)(CAAnimation * _Nullable, BOOL))amk_animationDidStopBlock {
    if (self.delegate != self) self.delegate = self;
    objc_setAssociatedObject(self, @selector(amk_animationDidStopBlock), [amk_animationDidStopBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    self.amk_animating = YES;
    self.amk_animationDidStartBlock==nil ?: self.amk_animationDidStartBlock(anim);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.amk_animating = NO;
    self.amk_animationDidStopBlock==nil ?: self.amk_animationDidStopBlock(anim, flag);
}

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end
