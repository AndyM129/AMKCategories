//
//  AMKExampleViewModel.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleViewModel.h"
#import <YYModel/YYModel.h>

@implementation AMKExampleViewModel

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"subExamples" : AMKExampleViewModel.class
    };
}

#pragma mark - Helper Methods

@end
