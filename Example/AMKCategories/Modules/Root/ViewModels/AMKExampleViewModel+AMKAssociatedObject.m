//
//  AMKExampleViewModel+AMKAssociatedObject.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleViewModel+AMKAssociatedObject.h"

@implementation AMKExampleViewModel (AMKAssociatedObject)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

- (NSString *)examplePath {
    return [self getAssociatedValueForKey:@selector(examplePath)];
}

- (void)setExamplePath:(NSString *)examplePath {
    [self setAssociateValue:examplePath withKey:@selector(examplePath)];
}

- (BOOL)isExpanded {
    return [[self getAssociatedValueForKey:@selector(isExpanded)] boolValue];
}

- (void)setIsExpanded:(BOOL)isExpanded {
    [self setAssociateValue:@(isExpanded) withKey:@selector(isExpanded)];
}

#pragma mark - Data & Networking

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
