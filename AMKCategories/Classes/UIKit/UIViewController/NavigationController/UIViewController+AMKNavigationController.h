//
//  UIViewController+AMKNavigationController.h
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 视图控制器转场方式 */
typedef NS_ENUM(NSInteger, AMKViewControllerTransitionStyle) {
    AMKViewControllerTransitionStylePush = 0,    //!< push
    AMKViewControllerTransitionStylePresent      //!< Present
};

/** UIViewController切换相关扩展 */
@interface UIViewController (AMKNavigationController)

/** Top视图控制器 */
@property(nonatomic, readonly, class) UIViewController *amk_topViewController;

/** Top视图控制器 */
@property(nonatomic, readonly) UIViewController *amk_topViewController;

/** UIViewController.amk_topViewController的前一个视图控制器 */
@property(nonatomic, readonly, class) UIViewController *amk_previousViewController;

/** 当前视图控制器的前一个视图控制器 */
@property(nonatomic, readonly) UIViewController *amk_previousViewController;

/** present当前视图控制器时，如果self.navigationController不存在则先创建一个，默认NO */
@property(nonatomic, assign) BOOL amk_presentedWithNavigationController;

/** 返回上一个ViewController */
- (BOOL)amk_goBackAnimated:(BOOL)animated;

/** 返回 [UIViewController amk_topViewController] 的上一个ViewController */
+ (BOOL)amk_goBackAnimated:(BOOL)animated;

/** 以PUSH的方式前往ViewController */
+ (BOOL)amk_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;;

/** 以PUSH的方式前往ViewController */
- (BOOL)amk_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/** 以present的方式前往ViewController */
+ (BOOL)amk_presentViewController:(UIViewController *)viewController animated:(BOOL)animated;

/** 以present的方式前往ViewController */
- (BOOL)amk_presentViewController:(UIViewController *)viewController animated:(BOOL)animated;

/** 以指定的方式前往ViewController */
+ (BOOL)amk_gotoViewController:(UIViewController *)viewController transitionStyle:(AMKViewControllerTransitionStyle)transitionStyle animated:(BOOL)animated;

/** 以指定的方式前往ViewController */
- (BOOL)amk_gotoViewController:(UIViewController *)viewController transitionStyle:(AMKViewControllerTransitionStyle)transitionStyle animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
