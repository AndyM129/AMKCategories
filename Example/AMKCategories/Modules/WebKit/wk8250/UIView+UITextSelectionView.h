//
//  UIView+UITextSelectionView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/24.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UITextSelectionView)

@end


@interface UIResponder (WKCategories)

/// 返回响应者链中 指定类型的响应对象
- (UIResponder *_Nullable)amk_nextResponderWithClass:(Class _Nullable)Class;

@end
