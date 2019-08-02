//
//  UIViewController+AMKLifeCircleBlock.m
//  Pods
//
//  Created by https://github.com/andym129 on 2017/7/19.
//
//

#import "UIViewController+AMKLifeCircleBlock.h"
#import <objc/runtime.h>


@implementation UIViewController (AMKLifeCircleBlock)

#pragma mark - Init

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        void (^__method_swizzling)(SEL, SEL) = ^(SEL sel, SEL _sel) {
            Method  method = class_getInstanceMethod(self, sel);
            Method _method = class_getInstanceMethod(self, _sel);
            method_exchangeImplementations(method, _method);
        };
        __method_swizzling(@selector(viewDidLoad), @selector(amk_viewDidLoad));
        __method_swizzling(@selector(viewWillAppear:), @selector(amk_viewWillAppear:));
        __method_swizzling(@selector(viewDidAppear:), @selector(amk_viewDidAppear:));
        __method_swizzling(@selector(viewWillDisappear:), @selector(amk_viewWillDisappear:));
        __method_swizzling(@selector(viewDidDisappear:), @selector(amk_viewDidDisappear:));
    });
}

#pragma mark - Propertys

- (void (^)(UIViewController *))amk_viewDidLoadBlock {
    return objc_getAssociatedObject(self, @selector(amk_viewDidLoadBlock));
}

- (void)setAmk_viewDidLoadBlock:(void (^)(UIViewController *))amk_viewDidLoadBlock {
    objc_setAssociatedObject(self, @selector(amk_viewDidLoadBlock), amk_viewDidLoadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIViewController *, BOOL))amk_viewWillAppearBlock {
    return objc_getAssociatedObject(self, @selector(amk_viewWillAppearBlock));
}

- (void)setAmk_viewWillAppearBlock:(void (^)(UIViewController *, BOOL))amk_viewWillAppearBlock {
    objc_setAssociatedObject(self, @selector(amk_viewWillAppearBlock), amk_viewWillAppearBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIViewController *, BOOL))amk_viewDidAppearBlock {
    return objc_getAssociatedObject(self, @selector(amk_viewDidAppearBlock));
}

- (void)setAmk_viewDidAppearBlock:(void (^)(UIViewController *, BOOL))amk_viewDidAppearBlock {
    objc_setAssociatedObject(self, @selector(amk_viewDidAppearBlock), amk_viewDidAppearBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIViewController *, BOOL))amk_viewWillDisappearBlock {
    return objc_getAssociatedObject(self, @selector(amk_viewWillDisappearBlock));
}

- (void)setAmk_viewWillDisappearBlock:(void (^)(UIViewController *, BOOL))amk_viewWillDisappearBlock {
    objc_setAssociatedObject(self, @selector(amk_viewWillDisappearBlock), amk_viewWillDisappearBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIViewController *, BOOL))amk_viewDidDisappearBlock {
    return objc_getAssociatedObject(self, @selector(amk_viewDidDisappearBlock));
}

- (void)setAmk_viewDidDisappearBlock:(void (^)(UIViewController *, BOOL))amk_viewDidDisappearBlock {
    objc_setAssociatedObject(self, @selector(amk_viewDidDisappearBlock), amk_viewDidDisappearBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (BOOL)amk_isViewAppeared {
    return [objc_getAssociatedObject(self, @selector(amk_isViewAppeared)) boolValue];
}

- (void)setAmk_isViewAppeared:(BOOL)amk_isViewAppeared {
    objc_setAssociatedObject(self, @selector(amk_isViewAppeared), @(amk_isViewAppeared), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Life Circle

- (void)amk_viewDidLoad {
    [self amk_viewDidLoad];
    self.view.clipsToBounds = YES;
    if (self.amk_viewDidLoadBlock) self.amk_viewDidLoadBlock(self);
}

- (void)amk_viewWillAppear:(BOOL)animated {
    [self amk_viewWillAppear:animated];
    if (self.amk_viewWillAppearBlock) self.amk_viewWillAppearBlock(self, animated);
}

- (void)amk_viewDidAppear:(BOOL)animated {
    [self amk_viewDidAppear:animated];
    self.amk_isViewAppeared = YES;
    if (self.amk_viewDidAppearBlock) self.amk_viewDidAppearBlock(self, animated);
}

- (void)amk_viewWillDisappear:(BOOL)animated {
    [self amk_viewWillDisappear:animated];
    if (self.amk_viewWillDisappearBlock) self.amk_viewWillDisappearBlock(self, animated);
}

- (void)amk_viewDidDisappear:(BOOL)animated {
    [self amk_viewDidDisappear:animated];
    if (self.amk_viewDidDisappearBlock) self.amk_viewDidDisappearBlock(self, animated);
}

@end
