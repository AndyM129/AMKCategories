//
//  WKNVoiceRecognitionPopupContentMainView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/29.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 语音识别浮层面板 - 内容主体视图
@interface WKNVoiceRecognitionPopupContentMainView : UIView

- (void)customLayoutSubviews;

@end

#pragma mark -

@interface WKNVoiceRecognitionPopupContentMainView (WKNAppear)
@property (nonatomic, assign, readonly, class) UIEdgeInsets margin; //!< 当前视图的 外边距
@property (nonatomic, assign, readonly) CGFloat preferredHeight; //!< 当前视图 基于已输入内容的 显示高度
@end
