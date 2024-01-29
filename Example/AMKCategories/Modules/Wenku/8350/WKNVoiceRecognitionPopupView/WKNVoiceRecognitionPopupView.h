//
//  WKNVoiceRecognitionPopupView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "BDEPopupView.h"
#import "WKNVoiceRecognitionPopupViewConstants.h"
#import "WKNVoiceRecognitionPopupContentMainView.h"

/// 语音识别浮层面板
@interface WKNVoiceRecognitionPopupView : BDEPopupView
@property (nonatomic, strong, readonly, nullable, class) WKNVoiceRecognitionPopupView *sharedInstance; //!< 单例
@property (nonatomic, strong, readonly, nullable) CAGradientLayer *contentViewLayerMaskRadientLayer; //!< 内容的渐变遮罩
@property (nonatomic, strong, readonly, nullable) WKNVoiceRecognitionPopupContentMainView *contentMainView; //!< 内容主体
@end

#pragma mark -

@interface WKNVoiceRecognitionPopupView (WKNAppearance)
@property (nonatomic, assign, readonly) CGFloat preferredContentViewHeight; //!< 当前视图 基于当前状态的 内容显示高度
@end
