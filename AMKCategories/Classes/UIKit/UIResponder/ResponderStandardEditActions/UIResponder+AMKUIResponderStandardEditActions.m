//
//  UIResponder+AMKUIResponderStandardEditActions.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2023/7/24.
//

#import "UIResponder+AMKUIResponderStandardEditActions.h"

@implementation UIResponder (AMKUIResponderStandardEditActions)

#pragma mark - Init Methods

#pragma mark - Properties

#pragma mark - Public Methods

- (UIResponder *)amk_nextResponderWithClass:(Class)Class {
    UIResponder *nextResponder = self;
    while (nextResponder && ![nextResponder isKindOfClass:Class]) {
        nextResponder = nextResponder.nextResponder;
    }
    return nextResponder;
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods


@end
