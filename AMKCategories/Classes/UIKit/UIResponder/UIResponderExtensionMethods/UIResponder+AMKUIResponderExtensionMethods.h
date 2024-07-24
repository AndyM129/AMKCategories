//
//  UIResponder+AMKUIResponderExtensionMethods.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2024/7/24.
//

#import <UIKit/UIKit.h>

/// 相关扩展
@interface UIResponder (AMKUIResponderExtensionMethods)

/// 返回响应者链中 指定类型的响应对象
- (UIResponder *_Nullable)amk_nextResponderWithClass:(Class _Nullable)Class;

@end
