//
//  BDEPopupView.h
//  AFNetworking
//
//  Created by Meng,Xinxin on 2018/7/30.
//

#import <UIKit/UIKit.h>
#import "BDEPopupViewProtocol.h"

/** 弹窗视图显示状态 */
typedef NS_ENUM(NSInteger, BDEPopupViewStatus) {
    BDEPopupViewStatusDismissed,       //!< 未显示
    BDEPopupViewStatusShowing,         //!< 显示动画中
    BDEPopupViewStatusShown,           //!< 显示
    BDEPopupViewStatusDismissing,      //!< 移除动画中
};

/* 回调定义 */
@class BDEPopupView;
typedef void(^BDEPopupViewContentAnimationBlock)(UIView *animationView, BOOL showAnimation, NSTimeInterval duration); //!< 视图的显隐动画
typedef void(^BDEPopupViewAnimationCallbackBlock)(BDEPopupView *popupView);                                           //!< 弹窗视图显隐动画的回调

/** 弹窗视图 */
@interface BDEPopupView : UIView <BDEPopupViewProtocol, UIGestureRecognizerDelegate> {
@protected
    UIView *_maskView;                                                             //!< 遮罩背景
    CGFloat _animationDuration;                                                         //!< 动画时长
    BOOL _animating;                                                                    //!< 是否正在动画
    BOOL _dismissWhenTapped;                                                            //!< 点击背景移除弹框（默认NO）
    BOOL _removeFromSuperviewWhenDismissed;                                             //!< 移除时并从父视图移除（默认Yes）
    UIView *_contentView;                                                               //!< 弹窗主体自定义视图
    BDEPopupViewContentAnimationBlock _contentViewAnimationBlock;                       //!< 内容视图的显隐动画
    BDEPopupViewContentAnimationBlock _maskViewAnimationBlock;                          //!< 遮罩视图的显隐动画
    BDEPopupViewAnimationCallbackBlock _willShowBlock;                                  //!< 弹窗视图的将要开始显示动画的回调
    BDEPopupViewAnimationCallbackBlock _didShowBlock;                                   //!< 弹窗视图的完成隐藏动画的回调
    BDEPopupViewAnimationCallbackBlock _willDismissBlock;                               //!< 弹窗视图的将要开始移除动画的回调
    BDEPopupViewAnimationCallbackBlock _didDismissBlock;                                //!< 弹窗视图的完成隐藏动画的回调
}
@property(nonatomic, strong) UIView *maskView;                                          //!< 遮罩背景
@property(nonatomic, assign) NSTimeInterval animationDuration;                          //!< 动画时长
@property(nonatomic, assign) NSTimeInterval duration;                                   //!< 显示时长，到时后将自动移除，默认0，即不自动移除
@property(nonatomic, assign) BDEPopupViewStatus status;                                 //!< 显示状态
@property(nonatomic, readonly) BOOL isAnimating;                                        //!< 是否正在动画
@property(nonatomic, assign) BOOL dismissWhenTapped;                                    //!< 点击背景移除弹框（默认NO）
@property(nonatomic, assign) BOOL removeFromSuperviewWhenDismissed;                     //!< 移除时并从父视图移除（默认Yes）
@property(nonatomic, strong) UIView *contentView;                                       //!< 弹窗主体自定义视图
@property(nonatomic, assign) UIOffset contentViewOffset;                                //!< 弹窗主体自定义视图居中偏移
@property(nonatomic, strong) UITapGestureRecognizer * tapGestureRecognizer;             //!< 点击手势
@property(nonatomic, copy) BDEPopupViewContentAnimationBlock contentViewAnimationBlock; //!< 内容视图的显隐动画
@property(nonatomic, copy) BDEPopupViewContentAnimationBlock maskViewAnimationBlock;    //!< 遮罩视图的显隐动画
@property(nonatomic, copy) BDEPopupViewAnimationCallbackBlock willShowBlock;            //!< 弹窗视图的将要开始显示动画的回调
@property(nonatomic, copy) BDEPopupViewAnimationCallbackBlock didShowBlock;             //!< 弹窗视图的完成隐藏动画的回调
@property(nonatomic, copy) BDEPopupViewAnimationCallbackBlock willDismissBlock;         //!< 弹窗视图的将要开始移除动画的回调
@property(nonatomic, copy) BDEPopupViewAnimationCallbackBlock didDismissBlock;          //!< 弹窗视图的完成隐藏动画的回调

- (BOOL)shouldHidesWhenTapped:(UITapGestureRecognizer *)sender;                         //!< 点击检测，可由子类重写
@end


