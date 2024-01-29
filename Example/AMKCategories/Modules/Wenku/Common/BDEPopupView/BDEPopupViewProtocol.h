//
//  BDEPopupViewProtocol.h
//  Yuedu-Pro
//
//  Created by Meng,Xinxin on 2018/8/16.
//

#import <Foundation/Foundation.h>

/** BDEPopupView 弹窗协议 */
@protocol BDEPopupViewProtocol
@required
- (UIView * _Nonnull)defaultSuperview;                                      //!< 默认父视图
- (void)showInView:(UIView *_Nullable)superview animated:(BOOL)animated;    //!< 显示方法
- (void)showAnimated;                                                       //!< 显示方法
- (void)dismissAnimated:(BOOL)animated;                                     //!< 移除方法
- (void)dismissAnimated;                                                    //!< 移除方法
@end

