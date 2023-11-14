//
//  MBProgressHUD+AMKCategories.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2022/6/22.
//

#import "MBProgressHUD+AMKCategories.h"
#import <objc/runtime.h>

#ifndef __OPTIMIZE__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
static NSString *_AMKLogTimeStringWithDate(NSDate *date) {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter.alloc init];
        [dateFormatter setDateStyle:NSDateFormatterFullStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    });
    return [dateFormatter stringFromDate:date];
}
#pragma clang diagnostic pop
#define NSLog(FORMAT, ...) fprintf(stderr,"%s %s Line %d: %s\n", _AMKLogTimeStringWithDate(NSDate.date).UTF8String, __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(...) {}
#endif

@implementation MBProgressHUD (AMKCategories)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

- (UIColor *)amk_contentBackgroundColor {
    return objc_getAssociatedObject(self, @selector(amk_contentBackgroundColor));
}

- (void)setAmk_contentBackgroundColor:(UIColor *)amk_contentBackgroundColor {
    objc_setAssociatedObject(self, @selector(amk_contentBackgroundColor), amk_contentBackgroundColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIFont *)amk_labelFont {
    return objc_getAssociatedObject(self, @selector(amk_labelFont));
}

- (void)setAmk_labelFont:(UIFont *)amk_labelFont {
    objc_setAssociatedObject(self, @selector(amk_labelFont), amk_labelFont, OBJC_ASSOCIATION_RETAIN);
}

- (UIFont *)amk_detailsLabelFont {
    return objc_getAssociatedObject(self, @selector(amk_detailsLabelFont));
}

- (void)setAmk_detailsLabelFont:(UIFont *)amk_detailsLabelFont {
    objc_setAssociatedObject(self, @selector(amk_detailsLabelFont), amk_detailsLabelFont, OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)amk_labelLineSpacing {
    return [(objc_getAssociatedObject(self, @selector(amk_labelLineSpacing)) ?: @(5)) floatValue];
}

- (void)setAmk_labelLineSpacing:(CGFloat)amk_labelLineSpacing {
    if (amk_labelLineSpacing == CGFLOAT_MIN) amk_labelLineSpacing = 5;
    objc_setAssociatedObject(self, @selector(amk_labelLineSpacing), @(amk_labelLineSpacing), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)amk_detailsLabelLineSpacing {
    return [(objc_getAssociatedObject(self, @selector(amk_detailsLabelLineSpacing)) ?: @(2)) floatValue];
}

- (void)setAmk_detailsLabelLineSpacing:(CGFloat)amk_detailsLabelLineSpacing {
    if (amk_detailsLabelLineSpacing == CGFLOAT_MIN) amk_detailsLabelLineSpacing = 2;
    objc_setAssociatedObject(self, @selector(amk_detailsLabelLineSpacing), @(amk_detailsLabelLineSpacing), OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

+ (UIView *)amk_defaultSuperview {
    return UIApplication.sharedApplication.delegate.window;
}

+ (instancetype)amk_showTextHUDWithTitle:(id)title inView:(UIView *)view responder:(UIResponder *)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated {
    MBProgressHUD *hud = [self amk_showHUDWithCustomView:nil title:title message:nil inView:view responder:responder duration:showDuration hideBeforeHUD:YES animated:animated userInteractionEnabled:NO];
    return hud;
}

+ (instancetype)amk_showTextHUDWithMessage:(id)message inView:(UIView *)view responder:(UIResponder *)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated {
    MBProgressHUD *hud = [self amk_showHUDWithCustomView:nil title:nil message:message inView:view responder:responder duration:showDuration hideBeforeHUD:YES animated:animated userInteractionEnabled:NO];
    return hud;
}

+ (instancetype)amk_showTextHUDWithTitle:(id)title message:(id)message inView:(UIView *)view responder:(UIResponder *)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated {
    MBProgressHUD *hud = [self amk_showHUDWithCustomView:nil title:title message:message inView:view responder:responder duration:showDuration hideBeforeHUD:YES animated:animated userInteractionEnabled:NO];
    return hud;
}

+ (instancetype)amk_showTextHUDWithTitle:(id)title message:(id)message inView:(UIView *)view responder:(UIResponder *)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled {
    MBProgressHUD *hud = [self amk_showHUDWithCustomView:nil title:title message:message inView:view responder:responder duration:showDuration hideBeforeHUD:YES animated:animated userInteractionEnabled:userInteractionEnabled];
    return hud;
}

+ (instancetype)amk_showLoadingHUDWithTitle:(id)title message:(id)message inView:(UIView *)view responder:(UIResponder *)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled {
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    MBProgressHUD *hud = [self amk_showHUDWithCustomView:activityIndicatorView title:title message:message inView:view responder:responder duration:showDuration hideBeforeHUD:YES animated:animated userInteractionEnabled:userInteractionEnabled];
    return hud;
}

+ (instancetype)amk_showHUDWithCustomView:(UIView *)customView title:(id)title message:(id)message inView:(UIView *)view responder:(UIResponder *)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated {
    MBProgressHUD *hud = [self amk_showHUDWithCustomView:customView title:title message:message inView:view responder:responder duration:showDuration hideBeforeHUD:YES animated:animated userInteractionEnabled:NO];
    return hud;
}

+ (instancetype)amk_showHUDWithCustomView:(UIView *)customView title:(id)title message:(id)message inView:(UIView *)view responder:(UIResponder *)responder duration:(NSTimeInterval)showDuration hideBeforeHUD:(BOOL)hideBeforeHUD animated:(BOOL)animated {
    return [self amk_showHUDWithCustomView:customView title:title message:message inView:view responder:responder duration:showDuration hideBeforeHUD:hideBeforeHUD animated:animated userInteractionEnabled:NO];
}

+ (instancetype)amk_showHUDWithCustomView:(UIView *)customView title:(id)title message:(id)message inView:(UIView *)view responder:(UIResponder *)responder duration:(NSTimeInterval)showDuration hideBeforeHUD:(BOOL)hideBeforeHUD animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled {
    
    __block MBProgressHUD *hud = nil;
    __block UIView *_customView = customView;
    __block id _title = title;
    __block id _message = message;
    __block UIView *_view = view;
    __block UIResponder *_responder = responder;
    __block NSTimeInterval _showDuration = showDuration;
    __block BOOL _hideBeforeHUD = hideBeforeHUD;
    __block BOOL _animated = animated;
    __block BOOL _userInteractionEnabled = userInteractionEnabled;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        BOOL shouldShow = !_customView && !_title && !_message ? NO : YES;
        if (_responder) {
            if ([_responder isKindOfClass:UIViewController.class]) shouldShow = shouldShow && [(UIViewController *)_responder view].window!=nil;
            else if ([_responder isKindOfClass:UIView.class]) shouldShow = shouldShow && [(UIView *)_responder window]!=nil;
        }
        if (!_view) _view = [self amk_defaultSuperview];
        BOOL showAnimated = _hideBeforeHUD ? ([MBProgressHUD hideHUDForView:_view animated:(shouldShow?NO:_animated)] ? NO : _animated) : _animated;
        if (!shouldShow) return;
        
        NSLog(@"%@ => %@", title, message);
        hud = [MBProgressHUD showHUDAddedTo:_view animated:showAnimated];
        hud.userInteractionEnabled = _userInteractionEnabled;
        hud.removeFromSuperViewOnHide = YES;
        hud.minSize = CGSizeEqualToSize(CGSizeZero, MBProgressHUD.appearance.minSize) ? CGSizeMake(335, 44) : MBProgressHUD.appearance.minSize;
        hud.offset = CGPointEqualToPoint(CGPointZero, MBProgressHUD.appearance.offset) ? CGPointMake(0.f, -100.0/375*UIScreen.mainScreen.bounds.size.width) : MBProgressHUD.appearance.offset;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = MBProgressHUD.appearance.amk_contentBackgroundColor ?: [UIColor colorWithWhite:0 alpha:0.8];
        hud.bezelView.layer.shadowColor = hud.bezelView.color.CGColor;
        hud.bezelView.layer.shadowOffset = CGSizeMake(0, 5);
        hud.bezelView.layer.shadowOpacity = 0.2;
        hud.bezelView.layer.shadowRadius = 10;
        hud.bezelView.layer.masksToBounds = NO;
        hud.bezelView.clipsToBounds = NO;
        hud.square = MBProgressHUD.appearance.isSquare;
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = _customView;
        if ([hud.customView isKindOfClass:UIActivityIndicatorView.class]) {
            [(UIActivityIndicatorView *)hud.customView setColor:UIActivityIndicatorView.appearance.color ?: [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[MBProgressHUD.class]].color ?: MBProgressHUD.appearance.contentColor?: UIColor.whiteColor];
            [(UIActivityIndicatorView *)hud.customView setHidesWhenStopped:NO];
            [(UIActivityIndicatorView *)hud.customView startAnimating];
        }
        hud.label.numberOfLines = 0;
        hud.label.font = MBProgressHUD.appearance.amk_labelFont ?: [UIFont systemFontOfSize:14];
        hud.label.textColor = MBProgressHUD.appearance.contentColor ?: [UIColor colorWithWhite:1 alpha:0.9];
        hud.detailsLabel.numberOfLines = 0;
        hud.detailsLabel.font = MBProgressHUD.appearance.amk_detailsLabelFont ?: [UIFont systemFontOfSize:12];
        hud.detailsLabel.textColor = MBProgressHUD.appearance.contentColor ?: [UIColor colorWithWhite:1 alpha:0.9];
        
        if (_title) {
            if (![_title isKindOfClass:NSString.class] && ![_title isKindOfClass:NSAttributedString.class]) {
                _title = [_title description];
            }
            if (![_title isKindOfClass:NSAttributedString.class]) {
                _title = [_title description];
                
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                paragraphStyle.lineSpacing = MBProgressHUD.appearance.amk_labelLineSpacing;
                paragraphStyle.alignment = NSTextAlignmentCenter;
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_title];
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_title length])];
                _title = attributedString;
            }
            hud.label.attributedText = _title;
        }
        
        if (_message) {
            if (![_message isKindOfClass:NSString.class] && ![_title isKindOfClass:NSAttributedString.class]) {
                _message = [_message description];
            }
            if (![_message isKindOfClass:NSAttributedString.class]) {
                _message = [_message description];
                
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                paragraphStyle.lineSpacing = MBProgressHUD.appearance.amk_detailsLabelLineSpacing;
                paragraphStyle.alignment = NSTextAlignmentCenter;
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_message];
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_message length])];
                _message = attributedString;
            }
            hud.detailsLabel.attributedText = _message;
        }
        
        if (_showDuration > 0) {
            [hud hideAnimated:_animated afterDelay:_showDuration];
        }
    }];
    return hud;
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Overrides

#pragma mark - Helper Methods

@end
