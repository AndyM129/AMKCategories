//
//  UILabel+AMKLabelDrawing.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/2/19.
//

#import "UILabel+AMKLabelDrawing.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

@implementation UILabel (AMKLabelDrawing)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UILabel amk_swizzleInstanceMethod:@selector(textRectForBounds:limitedToNumberOfLines:)
                                withMethod:@selector(AMKLabelDrawing_UILabel_textRectForBounds:limitedToNumberOfLines:)];
        [UILabel amk_swizzleInstanceMethod:@selector(drawTextInRect:)
                                withMethod:@selector(AMKLabelDrawing_UILabel_drawTextInRect:)];
    });
}

#pragma mark - Init Methods

#pragma mark - Properties

- (UIEdgeInsets)amk_contentInset {
    return [objc_getAssociatedObject(self, @selector(amk_contentInset)) UIEdgeInsetsValue];
}

- (void)setAmk_contentInset:(UIEdgeInsets)amk_contentInset {
    objc_setAssociatedObject(self, @selector(amk_contentInset), [NSValue valueWithUIEdgeInsets:amk_contentInset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

- (CGRect)AMKLabelDrawing_UILabel_textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect rect = [self AMKLabelDrawing_UILabel_textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.amk_contentInset) limitedToNumberOfLines:numberOfLines];
    rect.origin.x -= self.amk_contentInset.left;
    rect.origin.y -= self.amk_contentInset.top;
    rect.size.width += self.amk_contentInset.left + self.amk_contentInset.right;
    rect.size.height += self.amk_contentInset.top + self.amk_contentInset.bottom;
    return rect;
}

- (void)AMKLabelDrawing_UILabel_drawTextInRect:(CGRect)rect {
    [self AMKLabelDrawing_UILabel_drawTextInRect:UIEdgeInsetsInsetRect(rect, self.amk_contentInset)];
}

#pragma mark - Helper Methods

@end
