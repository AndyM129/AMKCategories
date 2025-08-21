//
//  UIColor+AMKUIColorExtensionMethods.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/8/21.
//

#import "UIColor+AMKUIColorExtensionMethods.h"

@implementation UIColor (AMKUIColorExtensionMethods)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

- (BOOL)amk_isLightColor {
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    double brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000;
    BOOL isLightContent = brightness < 0.55 ? NO : YES;
    //NSLog(@"%.2f => %@", brightness, isLightContent?@"⬜️":@"⬛️");
    return isLightContent;
}

#pragma mark - Data & Networking

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
