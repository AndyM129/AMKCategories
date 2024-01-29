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
@property (nonatomic, strong, readonly, nullable) UIView *textViewContainer; //!< 文本框 容器视图
@property (nonatomic, strong, readonly, nullable) UITextView *textView; //!< 文本框
@property (nonatomic, strong, readonly, nullable) UIButton *voiceRecognitionButton;
- (void)customLayoutSubviews;
@end

#pragma mark -

@interface WKNVoiceRecognitionPopupContentMainView (WKNAppearance)
@property (nonatomic, assign, readonly, class) UIEdgeInsets margin; //!< 当前视图的 外边距
@property (nonatomic, assign, readonly, class) UIEdgeInsets textViewContainerMargin; //!< 输入框 容器视图 外边距
@property (nonatomic, assign, readonly, class) UIEdgeInsets textViewMargin; //!< 输入框 外边距
@property (nonatomic, assign, readonly, class) CGFloat textViewMinHeight; //!< 输入框 最小高度
@property (nonatomic, assign, readonly, class) CGFloat textViewMaxHeight; //!< 输入框 最小高度
@property (nonatomic, assign, readonly) CGFloat preferredHeightWithoutText; //!< 当前视图 无输入内容时的 显示高度
@property (nonatomic, assign, readonly) CGFloat preferredHeight; //!< 当前视图 基于已输入内容的 显示高度
@end
