//
//  UIViewController+AMKNavigationControllerWithCallback.h
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/8/3.
//

#import <UIKit/UIKit.h>
#import <AMKCategories/UIViewController+AMKNavigationController.h>
#import <AMKCategories/UIViewController+AMKLifeCircleBlock.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AMKNavigationControllerWithCallback)

/** viewDidDisappear 时将从父视图控制器中移除，默认NO */
@property(nonatomic, assign) BOOL amk_removeFromParentViewControllerWhenDisappeared;

/** 以PUSH的方式前往ViewController */
+ (BOOL)amk_pushViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated completion:(void (^_Nullable)(UIViewController *_Nullable viewController))completion;

/** 以PUSH的方式前往ViewController */
- (BOOL)amk_pushViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated completion:(void (^_Nullable)(UIViewController *_Nullable viewController))completion;

/** 以present的方式前往ViewController */
+ (BOOL)amk_presentViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated completion:(void (^_Nullable)(UIViewController *_Nullable viewController))completion;

/** 以present的方式前往ViewController */
- (BOOL)amk_presentViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated completion:(void (^_Nullable)(UIViewController *_Nullable viewController))completion;

/** 以指定的方式前往ViewController */
+ (BOOL)amk_gotoViewController:(UIViewController *_Nullable)viewController transitionStyle:(AMKViewControllerTransitionStyle)transitionStyle  animated:(BOOL)animated completion:(void (^_Nullable)(UIViewController *_Nullable viewController))completion;

/** 以指定的方式前往ViewController */
- (BOOL)amk_gotoViewController:(UIViewController *_Nullable)viewController transitionStyle:(AMKViewControllerTransitionStyle)transitionStyle  animated:(BOOL)animated completion:(void (^_Nullable)(UIViewController *_Nullable viewController))completion;

@end

NS_ASSUME_NONNULL_END
