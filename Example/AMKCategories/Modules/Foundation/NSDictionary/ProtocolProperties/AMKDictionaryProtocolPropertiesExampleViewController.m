//
//  AMKDictionaryProtocolPropertiesExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/9/5.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKDictionaryProtocolPropertiesExampleViewController.h"
#import <AMKCategories/NSDictionary+AMKProtocolProperties.h>

@protocol AMKProtocolPropertiesExampleDictionary <NSObject>
@property (nonatomic, copy, readonly, nullable) NSString *amkpp_aStringValue;
@property (nonatomic, assign, readonly) NSInteger amkpp_aIntegerValue;
@property (nonatomic, assign, readonly) BOOL amkpp_aBoolValue;
@property (nonatomic, assign, readonly) double amkpp_aDoubleValue;
@property (nonatomic, strong, readonly, nullable) NSNumber *amkpp_aNumberValue;
@property (nonatomic, strong, readonly, nullable) NSArray *amkpp_anArray;
@property (nonatomic, strong, readonly, nullable) NSDictionary *amkpp_aDict;
@property (nonatomic, copy, readonly, nullable) void (^amkpp_aBlock)(void);
@property (nonatomic, strong, readonly, nullable) id amkpp_aCustomObject;
@end

@interface AMKDictionaryProtocolPropertiesExampleViewController ()

@end

@implementation AMKDictionaryProtocolPropertiesExampleViewController

+ (void)load {
    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [NSNotificationCenter.defaultCenter removeObserver:token];
        [UIViewController amk_pushViewController:[self.alloc init] animated:YES];
    }];
}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    [self.exampleStackView addArrangedTitleLabelWithTitle:@"单测" customBlock:nil];
    [self.exampleStackView addArrangedButton:@"执行单测" customBlock:nil touchUpInsideBlock:^(UIButton * _Nullable button) {
        @strongify(self)
        if (!self) return;
        
        void (^block)(void) = ^{ NSLog(@"Block executed"); };
        NSObject *customObj = [NSObject new];

        NSDictionary<AMKProtocolPropertiesExampleDictionary> *dict = (NSDictionary<AMKProtocolPropertiesExampleDictionary> *)@{
            @"aStringValue": @"hello",
            @"aIntegerValue": @123,
            @"aBoolValue": @YES,
            @"aDoubleValue": @3.14,
            @"aNumberValue": @42,
            @"anArray": @[@1, @2, @3],
            @"aDict": @{@"k": @"v"},
            @"aBlock": block,
            @"aCustomObject": customObj
        };

        // ✅ 正确类型
        NSAssert([dict.amkpp_aStringValue isEqualToString:@"hello"], @"string error");
        NSAssert(dict.amkpp_aIntegerValue == 123, @"integer error");
        NSAssert(dict.amkpp_aBoolValue == YES, @"bool error");
        NSAssert(fabs(dict.amkpp_aDoubleValue - 3.14) < 0.0001, @"double error");
        NSAssert([dict.amkpp_aNumberValue isEqual:@42], @"number error");
        NSAssert([dict.amkpp_anArray isKindOfClass:[NSArray class]], @"array error");
        NSAssert([dict.amkpp_aDict isKindOfClass:[NSDictionary class]], @"dict error");
        NSAssert(dict.amkpp_aBlock != nil, @"block error");
        NSAssert(dict.amkpp_aCustomObject == customObj, @"custom object error");

        // ✅ 类型不匹配
        NSDictionary<AMKProtocolPropertiesExampleDictionary> *mismatch = (NSDictionary<AMKProtocolPropertiesExampleDictionary> *)@{
            @"aStringValue": @123,
            @"aIntegerValue": @"456",
            @"aBoolValue": @"YES",
            @"aDoubleValue": @"3.1415",
            @"aNumberValue": @"42",
            @"anArray": @{@"key": @"value"},
            @"aDict": @[@1, @2],
            @"aBlock": @"not a block",
            @"aCustomObject": @999
        };

        NSAssert(mismatch.amkpp_aStringValue == nil, @"string mismatch should return nil");
        NSAssert(mismatch.amkpp_anArray == nil, @"array mismatch should return nil");
        NSAssert(mismatch.amkpp_aDict == nil, @"dict mismatch should return nil");
        NSAssert(mismatch.amkpp_aBlock == nil, @"block mismatch should return nil");
        NSAssert(mismatch.amkpp_aCustomObject == nil, @"custom object mismatch should return nil");

        NSAssert(mismatch.amkpp_aIntegerValue == 0, @"integer mismatch returns 0");
        NSAssert(mismatch.amkpp_aBoolValue == NO, @"bool mismatch returns NO");
        NSAssert(fabs(mismatch.amkpp_aDoubleValue - 0.0) < 0.0001, @"double mismatch returns 0.0");
        NSAssert([mismatch.amkpp_aNumberValue isEqual:@"42"], @"number mismatch returns original object");

        NSLog(@"✅ All tests passed for type safety");
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
