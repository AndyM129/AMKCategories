//
//  UIResponder+AMKUIResponderStandardEditActions.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2023/7/24.
//

#import <UIKit/UIKit.h>

@interface UIResponder (AMKUIResponderStandardEditActions)

/// 返回响应者链中 指定类型的响应对象
- (UIResponder *_Nullable)amk_nextResponderWithClass:(Class _Nullable)Class;

@end
