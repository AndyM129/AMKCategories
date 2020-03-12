//
//  UIViewController+AMKLifeCircleBlock.h
//  Pods
//
//  Created by https://github.com/andym129 on 2017/7/19.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AMKLifeCircleBlock)

/** 为外部提供的viewDidLoad的回调 (请勿通过self修改) */
@property(nonatomic, copy) void(^amk_viewDidLoadBlock)(__kindof UIViewController *viewController);

/** 为外部提供的viewWillAppear的回调，用于如 外部控制当前VC打点等操作 (请勿通过self修改) */
@property(nonatomic, copy) void(^amk_viewWillAppearBlock)(__kindof UIViewController *viewController, BOOL animated);

/** 为外部提供的viewDidAppearBlock的回调，用于如 外部控制当前VC打点等操作 (请勿通过self修改) */
@property(nonatomic, copy) void(^amk_viewDidAppearBlock)(__kindof UIViewController *viewController, BOOL animated);

/** 为外部提供的viewWillDisappearBlock的回调，用于如 外部控制当前VC打点等操作 (请勿通过self修改) */
@property(nonatomic, copy) void(^amk_viewWillDisappearBlock)(__kindof UIViewController *viewController, BOOL animated);

/** 为外部提供的viewDidDisappearBlock的回调，用于如 外部控制当前VC打点等操作 (请勿通过self修改) */
@property(nonatomic, copy) void(^amk_viewDidDisappearBlock)(__kindof UIViewController *viewController, BOOL animated);

/** 当前VC是否显示过（即执行过-viewDidAppear:方法） */
- (BOOL)amk_isViewAppeared;

@end

NS_ASSUME_NONNULL_END
