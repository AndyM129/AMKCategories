//
//  UIGestureRecognizer+AMKUIGestureRecognizerExtensionMethods.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2026/3/27.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (AMKUIGestureRecognizerExtensionMethods)

/// 取消当前的手势识别
- (void)amk_cancelsTouches;

@end
