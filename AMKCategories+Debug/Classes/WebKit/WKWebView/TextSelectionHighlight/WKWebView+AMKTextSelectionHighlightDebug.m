//
//  WKWebView+AMKTextSelectionHighlightDebug.m
//  AMKCategories+Debug
//
//  Created by Meng Xinxin on 2024/7/24.
//

#import "WKWebView+AMKTextSelectionHighlightDebug.h"
#import <AMKCategories/WKWebView+AMKTextSelectionHighlight.h>
#import <Aspects/Aspects.h>
#import <objc/runtime.h>

static NSNotificationName AMKTextSelectionHighlightDebugDidChageNotification = @"AMKTextSelectionHighlightDebugDidChageNotification";
static BOOL _textSelectionHighlightDebugEnable = NO;

@interface WKWebView ()
@property (nonatomic, strong, readwrite, nullable) UILabel *amk_textSelectionHighlightViewLayerMaskSchematicView;
@end

@implementation WKWebView (AMKTextSelectionHighlightDebug)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

+ (BOOL)amk_textSelectionHighlightDebugEnable {
    return _textSelectionHighlightDebugEnable;
}

+ (void)setAmk_textSelectionHighlightDebugEnable:(BOOL)textSelectionHighlightDebugEnable {
    // 值不变，则不再重复处理
    if (_textSelectionHighlightDebugEnable == textSelectionHighlightDebugEnable) {
        return;
    }
    
    // 保存新值
    _textSelectionHighlightDebugEnable = textSelectionHighlightDebugEnable;
    [NSNotificationCenter.defaultCenter postNotificationName:AMKTextSelectionHighlightDebugDidChageNotification object:nil userInfo:nil];
    
    // 按需添加 Hook
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.class aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
            WKWebView *webView = aspectInfo.instance;
            UILabel *_textSelectionHighlightViewLayerMaskSchematicView = webView.amk_textSelectionHighlightViewLayerMaskSchematicView;
            _textSelectionHighlightViewLayerMaskSchematicView.hidden = _textSelectionHighlightDebugEnable ? NO : YES;
            _textSelectionHighlightViewLayerMaskSchematicView.frame = webView.amk_textSelectionHighlightViewLayerMaskFrame;
            [webView.scrollView bringSubviewToFront:_textSelectionHighlightViewLayerMaskSchematicView];
        } error:nil];
    });
}

- (UILabel *)amk_textSelectionHighlightViewLayerMaskSchematicView {
    UILabel *_textSelectionHighlightViewLayerMaskSchematicView = objc_getAssociatedObject(self, @selector(amk_textSelectionHighlightViewLayerMaskSchematicView));
    if (!_textSelectionHighlightViewLayerMaskSchematicView) {
        _textSelectionHighlightViewLayerMaskSchematicView = [UILabel.alloc init];
        _textSelectionHighlightViewLayerMaskSchematicView.hidden = YES;
        _textSelectionHighlightViewLayerMaskSchematicView.userInteractionEnabled = NO;
        _textSelectionHighlightViewLayerMaskSchematicView.tintColor = self.tintColor;
        _textSelectionHighlightViewLayerMaskSchematicView.numberOfLines = 0;
        _textSelectionHighlightViewLayerMaskSchematicView.textAlignment = NSTextAlignmentCenter;
        _textSelectionHighlightViewLayerMaskSchematicView.font = [UIFont boldSystemFontOfSize:30];
        _textSelectionHighlightViewLayerMaskSchematicView.text = @"当前指定的\n文本选中时\n支持高亮的区域";
        _textSelectionHighlightViewLayerMaskSchematicView.textColor = [_textSelectionHighlightViewLayerMaskSchematicView.tintColor colorWithAlphaComponent:0.4];
        _textSelectionHighlightViewLayerMaskSchematicView.layer.borderWidth = 2;
        _textSelectionHighlightViewLayerMaskSchematicView.layer.borderColor = [_textSelectionHighlightViewLayerMaskSchematicView.tintColor colorWithAlphaComponent:0.4].CGColor;
        _textSelectionHighlightViewLayerMaskSchematicView.layer.backgroundColor = [_textSelectionHighlightViewLayerMaskSchematicView.tintColor colorWithAlphaComponent:0.1].CGColor;
        objc_setAssociatedObject(self, @selector(amk_textSelectionHighlightViewLayerMaskSchematicView), _textSelectionHighlightViewLayerMaskSchematicView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.scrollView addSubview:_textSelectionHighlightViewLayerMaskSchematicView];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(amk_handleTextSelectionHighlightDebugDidChageNotification:) name:AMKTextSelectionHighlightDebugDidChageNotification object:nil];
    }
    return _textSelectionHighlightViewLayerMaskSchematicView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

- (void)amk_handleTextSelectionHighlightDebugDidChageNotification:(NSNotification *)noti {
    self.amk_textSelectionHighlightViewLayerMaskSchematicView.hidden = self.class.amk_textSelectionHighlightDebugEnable ? NO : YES;
}

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
