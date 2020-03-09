//
//  UIImage+AMKImageResizing.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/3/9.
//

#import "UIImage+AMKImageResizing.h"

@implementation UIImage (AMKImageResizing)

#pragma mark - Init Methods

#pragma mark - Properties

#pragma mark - Public Methods

- (UIEdgeInsets)amk_capInsetsCenter {
    return UIEdgeInsetsMake(self.size.height/2, self.size.width/2, self.size.height/2, self.size.width/2);
}

- (UIImage *)amk_resizableImageWithCapInsetsCenter {
    return [self resizableImageWithCapInsets:self.amk_capInsetsCenter];
}

+ (UIImage *)amk_resizableImageWithCapInsetsCenterNamed:(NSString *)name {
    return [[UIImage imageNamed:name] amk_resizableImageWithCapInsetsCenter];
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end
