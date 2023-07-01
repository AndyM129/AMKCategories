//
//  WKNEditReaderNewTransitioning.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/1.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKNEditReaderNewTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readwrite) UINavigationControllerOperation operation;

- (instancetype _Nullable)initWithOperation:(UINavigationControllerOperation)operation;

@end
