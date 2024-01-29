//
//  WKNVoiceRecognitionPopupView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "BDEPopupView.h"

/// 语音识别浮层面板
@interface WKNVoiceRecognitionPopupView : BDEPopupView

@end

#pragma mark -

@interface WKNVoiceRecognitionPopupView (WKNAppearance)
@property (nonatomic, assign, readonly) CGFloat preferredContentViewHeight; //!< 当前视图 基于当前状态的 内容显示高度
@end
