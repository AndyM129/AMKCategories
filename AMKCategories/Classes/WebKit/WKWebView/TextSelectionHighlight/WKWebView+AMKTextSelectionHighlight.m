//
//  WKWebView+AMKTextSelectionHighlight.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2024/7/24.
//

#import "WKWebView+AMKTextSelectionHighlight.h"
#import <AMKCategories/UIResponder+AMKUIResponderExtensionMethods.h>
#import <Aspects/Aspects.h>
#import <objc/runtime.h>

#ifdef DEBUG
#define AMKTextSelectionHighlightLog(fmt, ...) NSLog((@"【AMKTextSelectionHighlight】" fmt), ##__VA_ARGS__)
#else
#define AMKTextSelectionHighlightLog(...)
#endif

static Class UITSV, UISGD, UISG, _UITSRV, _UITSRACV, _UITCV, UISTCV;

#pragma mark -

@interface AMKTextSelectionHighlightViewLayerMaskShapeLayer : CAShapeLayer @end

@implementation AMKTextSelectionHighlightViewLayerMaskShapeLayer @end

#pragma mark -

@interface WKWebView (_AMKTextSelectionHighlight)
@property (nonatomic, strong, readwrite, nullable) NSHashTable<UIView *> *amk_weakTextSelectionView;
@property (nonatomic, copy, readwrite, nullable) AMKWKWebViewTextSelectionViewLayoutSubviewsBlock amk_textSelectionViewLayoutSubviewsBlock;
@end

@implementation WKWebView (AMKTextSelectionHighlight)

- (NSHashTable<UIView *> *)amk_weakTextSelectionView {
    NSHashTable<UIView *> *_weakTextSelectionView = objc_getAssociatedObject(self, @selector(amk_weakTextSelectionView));
    if (!_weakTextSelectionView) {
        _weakTextSelectionView = [NSHashTable weakObjectsHashTable];
        objc_setAssociatedObject(self, @selector(amk_weakTextSelectionView), _weakTextSelectionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _weakTextSelectionView;
}

- (CGRect)amk_textSelectionHighlightViewLayerMaskFrame {
    return [objc_getAssociatedObject(self, @selector(amk_textSelectionHighlightViewLayerMaskFrame)) CGRectValue];
}

- (void)setAmk_textSelectionHighlightViewLayerMaskFrame:(CGRect)textSelectionHighlightViewLayerMaskFrame {
    // 参数校验
    if (textSelectionHighlightViewLayerMaskFrame.size.width <= 0 || textSelectionHighlightViewLayerMaskFrame.size.height <= 0) {
        textSelectionHighlightViewLayerMaskFrame = CGRectZero;
    }
    
    CGRect _textSelectionHighlightViewLayerMaskFrame = self.amk_textSelectionHighlightViewLayerMaskFrame;
    AMKTextSelectionHighlightLog(@"MaskFrame 更新: %@ -> %@", @(_textSelectionHighlightViewLayerMaskFrame), @(textSelectionHighlightViewLayerMaskFrame));
    
    // bugfix: 当 LayerMaskFrame 修改前后没有交集时，直接结束编辑，以优化体验
    CGRect rectIntersection = CGRectIntersection(_textSelectionHighlightViewLayerMaskFrame, textSelectionHighlightViewLayerMaskFrame);
    if (CGRectEqualToRect(CGRectZero, rectIntersection)) {
        [self endEditing:YES];
        AMKTextSelectionHighlightLog(@"MaskFrame 更新: 更新前后没有交集，直接结束编辑");
    }
    
    // 保存关联对象
    [self willChangeValueForKey:NSStringFromSelector(@selector(amk_textSelectionHighlightViewLayerMaskFrame))];
    objc_setAssociatedObject(self, @selector(amk_textSelectionHighlightViewLayerMaskFrame), [NSValue valueWithCGRect:textSelectionHighlightViewLayerMaskFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(amk_textSelectionHighlightViewLayerMaskFrame))];
    
    // 默认实现
    if (!self.amk_textSelectionViewLayoutSubviewsBlock) {
        [self setAmk_textSelectionViewLayoutSubviewsBlock:^(WKWebView * _Nullable webView, UIView * _Nullable textSelectionView) {
            [webView.amk_weakTextSelectionView addObject:textSelectionView];
            
            AMKTextSelectionHighlightViewLayerMaskShapeLayer *layerMask = textSelectionView.layer.mask;
            if (!layerMask || [layerMask isKindOfClass:AMKTextSelectionHighlightViewLayerMaskShapeLayer.class]) {
                if (CGRectEqualToRect(CGRectZero, webView.amk_textSelectionHighlightViewLayerMaskFrame)) {
                    layerMask = nil;
                    AMKTextSelectionHighlightLog(@"textSelectionView.layer.mask.path.rect: %@ => %@", textSelectionView, @"无");
                } else if ([textSelectionView isKindOfClass:_UITCV] || [textSelectionView isKindOfClass:UISTCV]) {
                    CGRect rectIntersection = CGRectIntersection(textSelectionView.frame, webView.amk_textSelectionHighlightViewLayerMaskFrame);
                    rectIntersection = [textSelectionView.superview convertRect:rectIntersection toView:textSelectionView];
                    layerMask = layerMask ?: [AMKTextSelectionHighlightViewLayerMaskShapeLayer layer];
                    layerMask.path = [UIBezierPath bezierPathWithRect:rectIntersection].CGPath;
                    AMKTextSelectionHighlightLog(@"textSelectionView.layer.mask.path.rect: %@ => %@", textSelectionView, @(rectIntersection));
                } else {
                    layerMask = layerMask ?: [AMKTextSelectionHighlightViewLayerMaskShapeLayer layer];
                    layerMask.path = [UIBezierPath bezierPathWithRect:webView.amk_textSelectionHighlightViewLayerMaskFrame].CGPath;
                    AMKTextSelectionHighlightLog(@"textSelectionView.layer.mask.path.rect: %@ => %@", textSelectionView, @(webView.amk_textSelectionHighlightViewLayerMaskFrame));
                }
                textSelectionView.layer.mask = layerMask;
            }
        }];
    }
    
    // 手动为子视图调用 LayoutSubviewsBlock，以便更新其处理
    NSArray<UIView *> *textSelectionViews = self.amk_weakTextSelectionView.allObjects;
    [textSelectionViews enumerateObjectsUsingBlock:^(UIView * _Nonnull textSelectionView, NSUInteger idx, BOOL * _Nonnull stop) {
        !self.amk_textSelectionViewLayoutSubviewsBlock ?: self.amk_textSelectionViewLayoutSubviewsBlock(self, textSelectionView);
    }];
}

- (AMKWKWebViewTextSelectionViewLayoutSubviewsBlock)amk_textSelectionViewLayoutSubviewsBlock {
    return objc_getAssociatedObject(self, @selector(amk_textSelectionViewLayoutSubviewsBlock));
}

- (void)setAmk_textSelectionViewLayoutSubviewsBlock:(AMKWKWebViewTextSelectionViewLayoutSubviewsBlock)amk_textSelectionViewLayoutSubviewsBlock {
    // 保存关联对象
    objc_setAssociatedObject(self, @selector(amk_textSelectionViewLayoutSubviewsBlock), amk_textSelectionViewLayoutSubviewsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);

    // 首次赋值时，运行时替换系统实现
    if (amk_textSelectionViewLayoutSubviewsBlock) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            void(^block)(id<AspectInfo>) = ^(id<AspectInfo> aspectInfo) {
                UIView *textSelectionView = aspectInfo.instance;
                WKWebView *webView = (id)[textSelectionView amk_nextResponderWithClass:WKWebView.class];
                !webView.amk_textSelectionViewLayoutSubviewsBlock ?: webView.amk_textSelectionViewLayoutSubviewsBlock(webView, textSelectionView);
            };
            
            // iOS 17-
            UITSV = NSClassFromString([NSString stringWithFormat:@"%@%@%@", @"UITex", @"tSelectio", @"nView"]);
            UISGD = NSClassFromString([NSString stringWithFormat:@"%@%@%@", @"UISel", @"ectionGra", @"bberDot"]);
            UISG = NSClassFromString([NSString stringWithFormat:@"%@%@%@", @"UISel", @"ectionGra", @"bber"]);
            [UITSV aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:block error:nil];
            [UISGD aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
                UIView *textSelectionView = aspectInfo.instance;
                BOOL shouldHidden = ![textSelectionView.superview isKindOfClass:UISG];
                textSelectionView.hidden = shouldHidden;
            } error:nil];
            
            // iOS 17+
            _UITSRV = NSClassFromString([NSString stringWithFormat:@"%@%@%@", @"_UITex", @"tSelectio", @"nRangeView"]);
            _UITSRACV = NSClassFromString([NSString stringWithFormat:@"%@%@%@%@%@", @"_UITex", @"tSelectio", @"nRangeAdju", @"stmentCont", @"ainerView"]);
            _UITCV = NSClassFromString([NSString stringWithFormat:@"%@%@%@", @"_UITex", @"tCurso", @"rView"]);
            [_UITSRV aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:block error:nil];
            [_UITSRACV aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:block error:nil];
            [_UITCV aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:block error:nil];
            
            // iOS 17.4+
            UISTCV = NSClassFromString([NSString stringWithFormat:@"%@%@%@%@", @"UIStand", @"ardTe", @"xtCur", @"sorView"]);
            [UISTCV aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:block error:nil];
            [UISTCV aspect_hookSelector:@selector(setFrame:) withOptions:AspectPositionAfter usingBlock:block error:nil];
            [UISTCV aspect_hookSelector:@selector(setBounds:) withOptions:AspectPositionAfter usingBlock:block error:nil];
//            [UISTCV aspect_hookSelector:@selector(setHidden:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//                UIView *standardTextCursorView = aspectInfo.instance;
//                standardTextCursorView.isHidden ?: block(aspectInfo);
//            } error:nil];
//            [UISTCV aspect_hookSelector:@selector(setBounds:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//                block(aspectInfo);
//            } error:nil];
        });
    }
}

@end

