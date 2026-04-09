//
//  BDERectSelectionView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2026/3/26.
//  Copyright © 2026 AndyM129. All rights reserved.
//

#import "BDERectSelectionView.h"
#import <AMKCategories/UIGeometry+AMKUIGeometryExtensionMethods.h>
#import <AMKCategories/UIGestureRecognizer+AMKUIGestureRecognizerExtensionMethods.h>
#import <AMKCategories/UIView+AMKInteractions.h>

NSString *NSStringFromBDERectSelectionViewHandleType(BDERectSelectionViewHandleType handleType) {
#   pragma push_macro("case_NSStringFromBDERectSelectionViewHandleType")
#   define case_NSStringFromBDERectSelectionViewHandleType(CASE) BDERectSelectionViewHandleType##CASE: return [NSString stringWithFormat:@#CASE @"(%ld)", BDERectSelectionViewHandleType##CASE];
    switch (handleType) {
        case case_NSStringFromBDERectSelectionViewHandleType(Unknown);
            
        case case_NSStringFromBDERectSelectionViewHandleType(Center);
            
        case case_NSStringFromBDERectSelectionViewHandleType(TopLeft);
        case case_NSStringFromBDERectSelectionViewHandleType(TopRight);
        case case_NSStringFromBDERectSelectionViewHandleType(BottomRight);
        case case_NSStringFromBDERectSelectionViewHandleType(BottomLeft);
            
        case case_NSStringFromBDERectSelectionViewHandleType(Top);
        case case_NSStringFromBDERectSelectionViewHandleType(Right);
        case case_NSStringFromBDERectSelectionViewHandleType(Bottom);
        case case_NSStringFromBDERectSelectionViewHandleType(Left);
            
        default: return [NSString stringWithFormat:@"Undefined(%ld)", handleType];
    }
#   pragma pop_macro("case_NSStringFromBDERectSelectionViewHandleType")
}

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
        self.contentInsets = UIEdgeInsetsZero;
        self.minSelectionSize = CGSizeZero;
        self.cornerHandleSize = CGSizeMake(40, 40);
        self.sideHandleSize = 40;
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

- (void)setMinSelectionSize:(CGSize)minSelectionSize {
    _minSelectionSize = CGSizeMake(MAX(0, minSelectionSize.width), MAX(0, minSelectionSize.height));
}

- (NSMutableDictionary<NSNumber *, UIImageView *> *)selectionHandleImageViews {
    if (!_selectionHandleImageViews) {
        _selectionHandleImageViews = @{}.mutableCopy;
    }
    return _selectionHandleImageViews;
}

- (UIImageView *_Nullable)selectionHandleImageViewWithType:(BDERectSelectionViewHandleType)handleType {
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
                    make.centerX.mas_equalTo(self.selectionView);
                    make.centerY.mas_equalTo(self.selectionView);
                    make.width.mas_equalTo(self.selectionView);
                    make.height.mas_equalTo(self.selectionView);
                    break;
                }
                    
                case BDERectSelectionViewHandleTypeTopLeft: {
                    make.centerX.mas_equalTo(self.selectionView.mas_left);
                    make.centerY.mas_equalTo(self.selectionView.mas_top);
                    make.size.mas_equalTo(self.cornerHandleSize);
                    break;
                }
                case BDERectSelectionViewHandleTypeTopRight: {
                    make.centerX.mas_equalTo(self.selectionView.mas_right);
                    make.centerY.mas_equalTo(self.selectionView.mas_top);
                    make.size.mas_equalTo(self.cornerHandleSize);
                    break;
                }
                case BDERectSelectionViewHandleTypeBottomRight: {
                    make.centerX.mas_equalTo(self.selectionView.mas_right);
                    make.centerY.mas_equalTo(self.selectionView.mas_bottom);
                    make.size.mas_equalTo(self.cornerHandleSize);
                    break;
                }
                case BDERectSelectionViewHandleTypeBottomLeft: {
                    make.centerX.mas_equalTo(self.selectionView.mas_left);
                    make.centerY.mas_equalTo(self.selectionView.mas_bottom);
                    make.size.mas_equalTo(self.cornerHandleSize);
                    break;
                }
                    
                case BDERectSelectionViewHandleTypeTop: {
                    make.left.right.mas_equalTo(self.selectionView).inset(self.cornerHandleSize.width / 2);
                    make.centerY.mas_equalTo(self.selectionView.mas_top);
                    make.height.mas_equalTo(self.sideHandleSize);
                    break;
                }
                case BDERectSelectionViewHandleTypeRight: {
                    make.top.bottom.mas_equalTo(self.selectionView).inset(self.cornerHandleSize.height / 2);
                    make.centerX.mas_equalTo(self.selectionView.mas_right);
                    make.width.mas_equalTo(self.sideHandleSize);
                    break;
                }
                case BDERectSelectionViewHandleTypeBottom: {
                    make.left.right.mas_equalTo(self.selectionView).inset(self.cornerHandleSize.width / 2);
                    make.centerY.mas_equalTo(self.selectionView.mas_bottom);
                    make.height.mas_equalTo(self.sideHandleSize);
                    break;
                }
                case BDERectSelectionViewHandleTypeLeft: {
                    make.top.bottom.mas_equalTo(self.selectionView).inset(self.cornerHandleSize.height / 2);
                    make.centerX.mas_equalTo(self.selectionView.mas_left);
                    make.width.mas_equalTo(self.sideHandleSize);
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
            CGPoint point = [self.panGestureRecognizer locationInView:self];
            BDERectSelectionViewHandleType handleType = [self handleTypeWithPoint:point];
            BDERectSelectionViewLog(@"possible handle %@ at %@ in %@ ⤢ %@", NSStringFromBDERectSelectionViewHandleType(handleType), @(point), @(self.selectionView.frame), @(UIEdgeInsetsInsetRect(self.selectionView.frame, self.selectionView.amk_interactionEdgeInsets)));
            break;
        }
        case UIGestureRecognizerStateBegan: {
            CGPoint beganLocation = [self.panGestureRecognizer locationInView:self];
            BDERectSelectionViewHandleType movingHandleType = [self handleTypeWithPoint:beganLocation];
            if (movingHandleType == BDERectSelectionViewHandleTypeUnknown) {
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
            CGPoint locationOffset = CGPointMake(currentLocation.x - beganLocation.x, currentLocation.y - beganLocation.y);
            CGRect selectionViewBeganFrame = [[self getAssociatedValueForKey:kBeganFrameKey] CGRectValue];
            CGRect contentRect = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
            CGRect selectionViewEndFrame = selectionViewBeganFrame;
            CGSize minSelectionSize = self.minSelectionSize;
            
            // 根据本次及开始时 移动距离差 计算新的位置
            BDERectSelectionViewHandleType movingHandleType = [[self getAssociatedValueForKey:kMovingHandleTypeKey] integerValue];
            switch (movingHandleType) {
                case BDERectSelectionViewHandleTypeTopLeft: {
                    selectionViewEndFrame.origin.x = MAX(CGRectGetMinX(contentRect), MIN(CGRectGetMinX(selectionViewBeganFrame) + locationOffset.x, CGRectGetMaxX(selectionViewBeganFrame) - minSelectionSize.width));
                    selectionViewEndFrame.origin.y = MAX(CGRectGetMinY(contentRect), MIN(CGRectGetMinY(selectionViewBeganFrame) + locationOffset.y, CGRectGetMaxY(selectionViewBeganFrame) - minSelectionSize.height));
                    selectionViewEndFrame.size.width = CGRectGetWidth(selectionViewBeganFrame) - (CGRectGetMinX(selectionViewEndFrame) - CGRectGetMinX(selectionViewBeganFrame));
                    selectionViewEndFrame.size.height = CGRectGetHeight(selectionViewBeganFrame) - (CGRectGetMinY(selectionViewEndFrame) - CGRectGetMinY(selectionViewBeganFrame));
                    break;
                }
                case BDERectSelectionViewHandleTypeTopRight: {
                    selectionViewEndFrame.origin.y = MAX(CGRectGetMinY(contentRect), MIN(CGRectGetMinY(selectionViewBeganFrame) + locationOffset.y, CGRectGetMaxY(selectionViewBeganFrame) - minSelectionSize.height));
                    selectionViewEndFrame.size.width = MAX(CGRectGetMinX(selectionViewBeganFrame) + minSelectionSize.width, MIN(CGRectGetMaxX(selectionViewBeganFrame) + locationOffset.x, CGRectGetMaxX(contentRect))) - CGRectGetMinX(selectionViewBeganFrame);
                    selectionViewEndFrame.size.height = CGRectGetHeight(selectionViewBeganFrame) - (CGRectGetMinY(selectionViewEndFrame) - CGRectGetMinY(selectionViewBeganFrame));
                    break;
                }
                case BDERectSelectionViewHandleTypeBottomRight: {
                    selectionViewEndFrame.size.width = MAX(minSelectionSize.width, MIN(CGRectGetWidth(selectionViewBeganFrame) + currentLocation.x - beganLocation.x, CGRectGetMaxX(contentRect) - CGRectGetMinX(selectionViewBeganFrame)));
                    selectionViewEndFrame.size.height = MAX(minSelectionSize.height, MIN(CGRectGetHeight(selectionViewBeganFrame) + currentLocation.y - beganLocation.y, CGRectGetMaxY(contentRect) - CGRectGetMinY(selectionViewBeganFrame)));
                    break;
                }
                case BDERectSelectionViewHandleTypeBottomLeft: {
                    selectionViewEndFrame.origin.x = MAX(CGRectGetMinX(contentRect), MIN(CGRectGetMinX(selectionViewBeganFrame) + locationOffset.x, CGRectGetMaxX(selectionViewBeganFrame) - minSelectionSize.width));
                    selectionViewEndFrame.size.width = CGRectGetWidth(selectionViewBeganFrame) - (CGRectGetMinX(selectionViewEndFrame) - CGRectGetMinX(selectionViewBeganFrame));
                    selectionViewEndFrame.size.height = MAX(minSelectionSize.height, MIN(CGRectGetHeight(selectionViewBeganFrame) + currentLocation.y - beganLocation.y, CGRectGetMaxY(contentRect) - CGRectGetMinY(selectionViewBeganFrame)));
                    break;
                }
                    
                case BDERectSelectionViewHandleTypeTop: {
                    selectionViewEndFrame.origin.y = MAX(CGRectGetMinY(contentRect), MIN(CGRectGetMinY(selectionViewBeganFrame) + locationOffset.y, CGRectGetMaxY(selectionViewBeganFrame) - minSelectionSize.height));
                    selectionViewEndFrame.size.height = CGRectGetHeight(selectionViewBeganFrame) - (CGRectGetMinY(selectionViewEndFrame) - CGRectGetMinY(selectionViewBeganFrame));
                    break;
                }
                case BDERectSelectionViewHandleTypeRight: {
                    selectionViewEndFrame.size.width = MAX(CGRectGetMinX(selectionViewBeganFrame) + minSelectionSize.width, MIN(CGRectGetMaxX(selectionViewBeganFrame) + locationOffset.x, CGRectGetMaxX(contentRect))) - CGRectGetMinX(selectionViewBeganFrame);
                    break;
                }
                case BDERectSelectionViewHandleTypeBottom: {
                    selectionViewEndFrame.size.height = MAX(minSelectionSize.height, MIN(CGRectGetHeight(selectionViewBeganFrame) + currentLocation.y - beganLocation.y, CGRectGetMaxY(contentRect) - CGRectGetMinY(selectionViewBeganFrame)));
                    break;
                }
                case BDERectSelectionViewHandleTypeLeft: {
                    selectionViewEndFrame.origin.x = MAX(CGRectGetMinX(contentRect), MIN(CGRectGetMinX(selectionViewBeganFrame) + locationOffset.x, CGRectGetMaxX(selectionViewBeganFrame) - minSelectionSize.width));
                    selectionViewEndFrame.size.width = CGRectGetWidth(selectionViewBeganFrame) - (CGRectGetMinX(selectionViewEndFrame) - CGRectGetMinX(selectionViewBeganFrame));
                    break;
                }
                    
                default: {
                    selectionViewEndFrame.origin.x = MAX(CGRectGetMinX(contentRect), MIN(CGRectGetMinX(selectionViewBeganFrame) + locationOffset.x, CGRectGetMaxX(contentRect) - CGRectGetWidth(selectionViewBeganFrame)));
                    selectionViewEndFrame.origin.y = MAX(CGRectGetMinY(contentRect), MIN(CGRectGetMinY(selectionViewBeganFrame) + locationOffset.y, CGRectGetMaxY(contentRect) - CGRectGetHeight(selectionViewBeganFrame)));
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
    __block BDERectSelectionViewHandleType handleType = BDERectSelectionViewHandleTypeUnknown;
    [self.selectionHandleImageViews enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull handleTypeNumber, UIImageView * _Nonnull selectionHandleImageView, BOOL * _Nonnull stop) {
        CGRect selectionHandleImageViewFrame = selectionHandleImageView.frame;
        CGRect selectionHandleImageViewRectInSelf = [self.selectionView convertRect:selectionHandleImageViewFrame toView:self];
        CGRect selectionHandleImageViewInteractionRectInSelf = UIEdgeInsetsInsetRect(selectionHandleImageViewRectInSelf, selectionHandleImageView.amk_interactionEdgeInsets);
        if (CGRectContainsPoint(selectionHandleImageViewInteractionRectInSelf, point)) {
            handleType = handleTypeNumber.integerValue;
            *stop = YES;
        }
    }];
    
    if (handleType == BDERectSelectionViewHandleTypeUnknown) {
        CGRect selectionViewFrame = self.selectionView.frame;
        CGRect selectionViewInteractionRectInSelf = UIEdgeInsetsInsetRect(selectionViewFrame, self.selectionView.amk_interactionEdgeInsets);
        if (CGRectContainsPoint(selectionViewInteractionRectInSelf, point)) {
            handleType = BDERectSelectionViewHandleTypeCenter;
        }
    }
    
    BDERectSelectionViewLog(@"handle %@ at %@ in %@ ⤢ %@", NSStringFromBDERectSelectionViewHandleType(handleType), @(point), @(self.selectionView.frame), @(UIEdgeInsetsInsetRect(self.selectionView.frame, self.selectionView.amk_interactionEdgeInsets)));
    return handleType;
}

@end
