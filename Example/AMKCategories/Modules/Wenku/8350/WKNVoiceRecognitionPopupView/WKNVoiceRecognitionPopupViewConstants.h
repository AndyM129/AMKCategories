//
//  WKNVoiceRecognitionPopupViewConstants.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/29.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 语音识别按钮 当前交互状态
typedef NS_ENUM(NSUInteger, WKNVoiceRecognitionPopupViewState) {
    WKNVoiceRecognitionPopupViewStateNormal = 0,       //!< 默认的「按住说话 按钮」状态
    WKNVoiceRecognitionPopupViewStateTouchDown,        //!< 按下
    WKNVoiceRecognitionPopupViewStateTouchDragInside,  //!< 手势在按钮范围内拖拽
    WKNVoiceRecognitionPopupViewStateTouchDragOutside, //!< 手势在按钮范围外拖拽
    WKNVoiceRecognitionPopupViewStateTouchCancel,      //!< 取消
    WKNVoiceRecognitionPopupViewStateTouchUp,          //!< 松手
};
