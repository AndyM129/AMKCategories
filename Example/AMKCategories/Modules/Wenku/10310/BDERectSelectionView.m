//
//  BDERectSelectionView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2026/3/26.
//  Copyright © 2026 AndyM129. All rights reserved.
//

#import "BDERectSelectionView.h"
#import <AMKCategories/CGGeometry+AMKCGGeometryExtensionMethods.h>
#import <AMKCategories/UIGestureRecognizer+AMKUIGestureRecognizerExtensionMethods.h>

@interface BDERectSelectionView ()
@property (nonatomic, strong, readwrite, nullable) CAShapeLayer *overlayLayer;
@property (nonatomic, strong, readwrite, nullable) UIView *selectionView;
@property (nonatomic, strong, readwrite, nullable) NSMutableDictionary<NSNumber *, UIImageView *> *selectionHandleImageViews;
@property (nonatomic, strong, readwrite, nullable) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign, readwrite) BDERectSelectionViewHandleType movingHandleType;
@end

@implementation BDERectSelectionView


#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.panGestureRecognizer.enabled = YES;
    }
    return self;
}

#pragma mark - Getters & Setters

- (CAShapeLayer *)overlayLayer {
    if (!_overlayLayer) {
        _overlayLayer = [CAShapeLayer layer];
        _overlayLayer.fillRule = kCAFillRuleEvenOdd;
        _overlayLayer.fillColor = [UIColor.blackColor colorWithAlphaComponent:0.5].CGColor;
        [self.layer insertSublayer:_overlayLayer atIndex:0];
    }
    return _overlayLayer;
}

- (UIView *)selectionView {
    if (!_selectionView) {
        __weak __typeof__(self)weakSelf = self;
        _selectionView = [UIView.alloc init];
        [_selectionView addObserverBlockForKeyPath:@"frame" block:^(UIView *_Nonnull selectionView, NSValue *oldVal, NSValue *newVal) {
            if (![newVal isEqualToValue:oldVal]) {
                [weakSelf updateOverlayLayer];
            }
        }];
        [self addSubview:_selectionView];
    }
    return _selectionView;
}

- (NSMutableDictionary<NSNumber *,UIImageView *> *)selectionHandleImageViews {
    if (!_selectionHandleImageViews) {
        _selectionHandleImageViews = @{}.mutableCopy;
    }
    return _selectionHandleImageViews;
}

- (UIImageView *)selectionHandleImageViewWithType:(BDERectSelectionViewHandleType)handleType {
    return [self selectionHandleImageViewWithType:handleType layoutBlcok:nil];
}

- (UIImageView *)selectionHandleImageViewWithType:(BDERectSelectionViewHandleType)handleType layoutBlcok:(BDERectSelectionViewHandleImageViewLayoutBlcok)layoutBlcok {
    if (handleType < 0 || handleType >= BDERectSelectionViewHandleTypeCount) {
        return nil;
    }
    
    UIImageView *selectionHandleImageView = self.selectionHandleImageViews[@(handleType)];
    if (!selectionHandleImageView) {
        selectionHandleImageView = [UIImageView.alloc init];
        [self.selectionView addSubview:selectionHandleImageView];
        [selectionHandleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            switch (handleType) {
                case BDERectSelectionViewHandleTypeCenter: {
                    make.centerX.mas_equalTo(self.selectionView.mas_centerX);
                    make.centerY.mas_equalTo(self.selectionView.mas_centerY);
                    break;
                }
                case BDERectSelectionViewHandleTypeTopLeft: {
                    make.left.mas_equalTo(self.selectionView.mas_left);
                    make.top.mas_equalTo(self.selectionView.mas_top);
                    break;
                }
                case BDERectSelectionViewHandleTypeTopRight: {
                    make.right.mas_equalTo(self.selectionView.mas_right);
                    make.top.mas_equalTo(self.selectionView.mas_top);
                    break;
                }
                case BDERectSelectionViewHandleTypeBottomRight: {
                    make.right.mas_equalTo(self.selectionView.mas_right);
                    make.bottom.mas_equalTo(self.selectionView.mas_bottom);
                    break;
                }
                case BDERectSelectionViewHandleTypeBottomLeft: {
                    make.left.mas_equalTo(self.selectionView.mas_left);
                    make.bottom.mas_equalTo(self.selectionView.mas_bottom);
                    break;
                }
                default: break;
            }
        }];
        self.selectionHandleImageViews[@(handleType)] = selectionHandleImageView;
    }
    
    if (layoutBlcok) {
        layoutBlcok(self, selectionHandleImageView);
    }
    
    return selectionHandleImageView;
}

- (UIPanGestureRecognizer *)panGestureRecognizer {
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [UIPanGestureRecognizer.alloc initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
        _panGestureRecognizer.minimumNumberOfTouches = 1;
        _panGestureRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:_panGestureRecognizer];
    }
    return _panGestureRecognizer;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateOverlayLayer];
}

- (void)updateOverlayLayer {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath *clearPath = [UIBezierPath bezierPathWithRect:self.selectionView.frame];
    [path appendPath:clearPath];
    [path setUsesEvenOddFillRule:YES];
    self.overlayLayer.path = path.CGPath;
}

#pragma mark - Action Methods

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    static void *kBeganLocationKey = &kBeganLocationKey;
    static void *kMovingHandleTypeKey = &kMovingHandleTypeKey;
    static void *kBeganFrameKey = &kBeganFrameKey;
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStatePossible: {
            break;
        }
        case UIGestureRecognizerStateBegan: {
            CGPoint beganLocation = [self.panGestureRecognizer locationInView:self];
            BDERectSelectionViewHandleType movingHandleType = [self handleTypeWithPoint:beganLocation];
            if (!CGRectContainsPoint(self.selectionView.frame, beganLocation)) {
                [self.panGestureRecognizer amk_cancelsTouches];
            } else {
                [self setAssociateValue:@(beganLocation) withKey:kBeganLocationKey];
                [self setAssociateValue:@(movingHandleType) withKey:kMovingHandleTypeKey];
                [self setAssociateValue:@(self.selectionView.frame) withKey:kBeganFrameKey];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint beganLocation = [[self getAssociatedValueForKey:kBeganLocationKey] CGPointValue];
            CGPoint currentLocation = [self.panGestureRecognizer locationInView:self];
            CGRect selectionViewBeganFrame = [[self getAssociatedValueForKey:kBeganFrameKey] CGRectValue];
            CGRect contentRect = AMKCGRectEdgeInsets(self.bounds, self.contentInsets);
            CGRect selectionViewEndFrame = selectionViewBeganFrame;
            
            // 根据本次及开始时 移动距离差 计算新的位置
            BDERectSelectionViewHandleType movingHandleType = [[self getAssociatedValueForKey:kMovingHandleTypeKey] integerValue];
            switch (movingHandleType) {
                case BDERectSelectionViewHandleTypeTopLeft: {
                    selectionViewEndFrame.origin.x = MAX(CGRectGetMinX(contentRect), MIN(currentLocation.x, CGRectGetMaxX(selectionViewBeganFrame)));
                    selectionViewEndFrame.origin.y = MAX(CGRectGetMinY(contentRect), MIN(currentLocation.y, CGRectGetMaxY(selectionViewBeganFrame)));
                    selectionViewEndFrame.size.width = CGRectGetWidth(selectionViewBeganFrame) - (CGRectGetMinX(selectionViewEndFrame) - CGRectGetMinX(selectionViewBeganFrame));
                    selectionViewEndFrame.size.height = CGRectGetHeight(selectionViewBeganFrame) - (CGRectGetMinY(selectionViewEndFrame) - CGRectGetMinY(selectionViewBeganFrame));
                    break;
                }
                case BDERectSelectionViewHandleTypeTopRight: {
//                    selectionViewEndFrame.origin.x = MAX(CGRectGetMinX(selectionViewBeganFrame), MIN(currentLocation.x, contentRect.origin.x + contentRect.size.width));
//                    selectionViewEndFrame.origin.y = MAX(contentRect.origin.y, MIN(currentLocation.y, CGRectGetMaxY(selectionViewBeganFrame)));
//                    selectionViewEndFrame.size.width = selectionViewBeganFrame.size.width - (selectionViewEndFrame.origin.x - selectionViewBeganFrame.origin.x);
//                    selectionViewEndFrame.size.height = selectionViewBeganFrame.size.height - (selectionViewEndFrame.origin.y - selectionViewBeganFrame.origin.y);
                    break;
                }
                case BDERectSelectionViewHandleTypeBottomRight: {
//                    selectionViewEndFrame.origin.x = MAX(contentRect.origin.x, MIN(currentLocation.x, CGRectGetMaxX(selectionViewBeganFrame)));
//                    selectionViewEndFrame.origin.y = MAX(contentRect.origin.y, MIN(currentLocation.y, CGRectGetMaxY(selectionViewBeganFrame)));
//                    selectionViewEndFrame.size.width = selectionViewBeganFrame.size.width - (selectionViewEndFrame.origin.x - selectionViewBeganFrame.origin.x);
//                    selectionViewEndFrame.size.height = selectionViewBeganFrame.size.height - (selectionViewEndFrame.origin.y - selectionViewBeganFrame.origin.y);
                    break;
                }
                case BDERectSelectionViewHandleTypeBottomLeft: {
                    selectionViewEndFrame.origin.x = MAX(CGRectGetMinX(contentRect), MIN(currentLocation.x, CGRectGetMaxX(selectionViewBeganFrame)));
//                    selectionViewEndFrame.origin.y = MAX(CGRectGetMinY(selectionViewBeganFrame), MIN(currentLocation.y, CGRectGetMaxY(contentRect)));
                    selectionViewEndFrame.size.width = CGRectGetWidth(selectionViewBeganFrame) - (CGRectGetMinX(selectionViewEndFrame) - CGRectGetMinX(selectionViewBeganFrame));
                    selectionViewEndFrame.size.height = CGRectGetHeight(selectionViewBeganFrame) + (MAX(currentLocation.y, CGRectGetMinY(selectionViewBeganFrame)) - beganLocation.y);
                    break;
                }
                default: {
                    selectionViewEndFrame.origin.x = MAX(CGRectGetMinX(contentRect), MIN(selectionViewEndFrame.origin.x + currentLocation.x - beganLocation.x, contentRect.origin.x + contentRect.size.width - selectionViewEndFrame.size.width));
                    selectionViewEndFrame.origin.y = MAX(CGRectGetMinY(contentRect), MIN(selectionViewEndFrame.origin.y + currentLocation.y - beganLocation.y, contentRect.origin.y + contentRect.size.height - selectionViewEndFrame.size.height));
                    break;
                }
            }
            self.selectionView.frame = selectionViewEndFrame;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        default: break;
    }
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

- (BDERectSelectionViewHandleType)handleTypeWithPoint:(CGPoint)point {
    CGPoint pointInSelectionView = [self convertPoint:point toView:self.selectionView];
    __block BDERectSelectionViewHandleType handleType = BDERectSelectionViewHandleTypeCenter;
    [self.selectionHandleImageViews enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull handleTypeNumber, UIImageView * _Nonnull selectionHandleImageView, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(selectionHandleImageView.frame, pointInSelectionView)) {
            handleType = handleTypeNumber.integerValue;
            *stop = YES;
        }
    }];
    return handleType;
}

@end
