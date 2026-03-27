//
//  BDERectSelectionView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2026/3/26.
//  Copyright © 2026 AndyM129. All rights reserved.
//

#import "BDERectSelectionView.h"
#import <AMKCategories/UIGestureRecognizer+AMKUIGestureRecognizerExtensionMethods.h>

@interface BDERectSelectionView ()
@property (nonatomic, strong, readwrite, nullable) CAShapeLayer *overlayLayer;
@property (nonatomic, strong, readwrite, nullable) UIView *selectionView;
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
        [self.layer addSublayer:_overlayLayer];
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

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CGPoint toucheBeganPoint = [touches.anyObject locationInView:self];
//    self.movingHandleType = [self handleTypeWithPoint:toucheBeganPoint];
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint touchLocation = [touch locationInView:self];
//    CGPoint touchPreviousLocation = [touch previousLocationInView:self];
//    
//    switch (self.movingHandleType) {
//        case BDERectSelectionViewHandleTypeCenter: {
//            CGRect selectionRect = self.selectionRect;
//            selectionRect.origin.x += touchLocation.x - touchPreviousLocation.x;
//            selectionRect.origin.y += touchLocation.y - touchPreviousLocation.y;
//            self.selectionRect = selectionRect;
//            break;
//        }
//        default: break;
//    }
//}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;

#pragma mark - Action Methods

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    static void *kPreviousLocationKey = &kPreviousLocationKey;
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStatePossible: {
            break;
        }
        case UIGestureRecognizerStateBegan: {
            CGPoint beganLocation = [self.panGestureRecognizer locationInView:self];
            if (!CGRectContainsPoint(self.selectionView.frame, beganLocation)) {
                [self.panGestureRecognizer amk_cancelsTouches];
            } else {
                [self setAssociateValue:@(beganLocation) withKey:kPreviousLocationKey];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint previousLocation = [[self getAssociatedValueForKey:kPreviousLocationKey] CGPointValue];
            CGPoint currentLocation = [self.panGestureRecognizer locationInView:self];
            [self setAssociateValue:@(currentLocation) withKey:kPreviousLocationKey];
            
            CGRect selectionViewFrame = self.selectionView.frame;
            selectionViewFrame.origin.x += currentLocation.x - previousLocation.x;
            selectionViewFrame.origin.y += currentLocation.y - previousLocation.y;
            self.selectionView.frame = selectionViewFrame;
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
    return BDERectSelectionViewHandleTypeCenter;
}

@end
