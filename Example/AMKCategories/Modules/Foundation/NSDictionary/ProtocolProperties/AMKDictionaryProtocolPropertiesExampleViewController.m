//
//  AMKDictionaryProtocolPropertiesExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/9/5.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKDictionaryProtocolPropertiesExampleViewController.h"
#import "NSDictionary+AMKProtocolPropertiesExample.h"

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
    [self addExample_1];
    //[self addExample_2];
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

- (void)addExample_1 {
    @weakify(self)
    [self.exampleStackView addArrangedTitleLabelWithTitle:@"【示例1】通过协议属性 获取key值 - id类型" customBlock:nil];
    [self.exampleStackView addArrangedButton:@"执行单测" customBlock:nil touchUpInsideBlock:^(UIButton * _Nullable button) {
        @strongify(self)
        if (!self) return;
        
        void (^block)(void) = ^{ NSLog(@"Block executed"); };
        NSObject *customObj = [NSObject new];

        NSDictionary<AMKExampleDictionaryPropertiesProtocol_1> *dict = (NSDictionary<AMKExampleDictionaryPropertiesProtocol_1> *)@{
            @"aStringObject": @"hello",
            @"aIntegerObject": @123,
            @"aBoolObject": @YES,
            @"aDoubleObject": @3.14,
            @"aNumberObject": @42,
            @"anArrayObject": @[@1, @2, @3],
            @"aDictObject": @{@"k": @"v"},
            @"aNullObject": NSNull.null,
            @"aBlockObject": block,
            @"aCustomObject": customObj,
            @"aCustomObjectWithCustomImplementation": customObj,
        };
        
        NSLog(@"dict.amkpp_aStringObject = %@", dict.amkpp_aStringObject);
        NSLog(@"dict.amkpp_aIntegerObject = %@", dict.amkpp_aIntegerObject);
        NSLog(@"dict.amkpp_aBoolObject = %@", dict.amkpp_aBoolObject);
        NSLog(@"dict.amkpp_aDoubleObject = %@", dict.amkpp_aDoubleObject);
        NSLog(@"dict.amkpp_aNumberObject = %@", dict.amkpp_aNumberObject);
        NSLog(@"dict.amkpp_anArrayObject = %@", dict.amkpp_anArrayObject);
        NSLog(@"dict.amkpp_aDictObject = %@", dict.amkpp_aDictObject);
        NSLog(@"dict.amkpp_aNullObject = %@", dict.amkpp_aNullObject);
        NSLog(@"dict.amkpp_aBlockObject = %@", dict.amkpp_aBlockObject);
        NSLog(@"dict.amkpp_aCustomObject = %@", dict.amkpp_aCustomObject);
        NSLog(@"dict.amkpp_aCustomObjectWithCustomImplementation = %@", dict.amkpp_aCustomObjectWithCustomImplementation);

        NSAssert([dict.amkpp_aStringObject isEqualToString:@"hello"], @"string object error");
        NSAssert([dict.amkpp_aIntegerObject isEqualToNumber:@123], @"integer object error");
        NSAssert([dict.amkpp_aBoolObject isEqualToNumber:@YES], @"bool object error");
        NSAssert([dict.amkpp_aDoubleObject isEqualToNumber:@3.14], @"double object error");
        NSAssert([dict.amkpp_aNumberObject isEqualToNumber:@42], @"number object error");
        NSAssert([dict.amkpp_anArrayObject isKindOfClass:NSArray.class], @"array object error");
        NSAssert([dict.amkpp_aDictObject isKindOfClass:NSDictionary.class], @"dict object error");
        NSAssert(dict.amkpp_aNullObject == nil, @"null object error");
        NSAssert([dict.amkpp_aBlockObject isKindOfClass:NSClassFromString(@"NSBlock")], @"block object error");
        NSAssert(dict.amkpp_aCustomObject == customObj, @"custom object object error");
        
        NSLog(@"✅ All tests passed for type safety");
    }];
}

//- (void)addExample_2 {
//    @weakify(self)
//    [self.exampleStackView addArrangedTitleLabelWithTitle:@"【示例2】通过协议属性 获取key值 - 指定类型" customBlock:nil];
//    [self.exampleStackView addArrangedButton:@"执行单测" customBlock:nil touchUpInsideBlock:^(UIButton * _Nullable button) {
//        @strongify(self)
//        if (!self) return;
//        
//        void (^block)(void) = ^{ NSLog(@"Block executed"); };
//        NSObject *customObj = [NSObject new];
//        
//        // 正确类型
//        NSDictionary<AMKExampleDictionaryPropertiesProtocol_9> *dict = (NSDictionary<AMKExampleDictionaryPropertiesProtocol_9> *)@{
//            @"aStringObject": @"hello",
//            @"aIntegerObject": @123,
//            @"aBoolObject": @YES,
//            @"aDoubleObject": @3.14,
//            @"aNumberObject": @42,
//            @"anArrayObject": @[@1, @2, @3],
//            @"aDictObject": @{@"k": @"v"},
//            @"aNullObject": NSNull.null,
//            @"aBlockObject": block,
//            @"aCustomObject": customObj,
//            @"aCustomObjectWithCustomImplementation": customObj,
//        };
//        
//        // 调试
//        NSLog(@"dict.amkpp_aStringObject__stringValue = %@", dict.amkpp_aStringObject__stringValue);
//        NSLog(@"dict.amkpp_aIntegerObject__integerValue = %zd", dict.amkpp_aIntegerObject__integerValue);
//        NSLog(@"dict.amkpp_aBoolObject__boolValue = %@", dict.amkpp_aBoolObject__boolValue ? @"YES" : @"NO");
//        NSLog(@"dict.amkpp_aDoubleObject__doubleValue = %f", dict.amkpp_aDoubleObject__doubleValue);
//        NSLog(@"dict.amkpp_aDoubleObject__floatValue = %f", dict.amkpp_aDoubleObject__floatValue);
////        NSLog(@"dict.amkpp_aNumberObject = %@", dict.amkpp_aNumberObject);
////        NSLog(@"dict.amkpp_anArrayObject = %@", dict.amkpp_anArrayObject);
////        NSLog(@"dict.amkpp_aDictObject = %@", dict.amkpp_aDictObject);
////        NSLog(@"dict.amkpp_aNullObject = %@", dict.amkpp_aNullObject);
////        NSLog(@"dict.amkpp_aBlockObject = %@", dict.amkpp_aBlockObject);
////        NSLog(@"dict.amkpp_aCustomObject = %@", dict.amkpp_aCustomObject);
////        NSLog(@"dict.amkpp_aCustomObjectWithCustomImplementation = %@", dict.amkpp_aCustomObjectWithCustomImplementation);
//
//        // 测试
//        NSAssert([dict.amkpp_aStringObject__stringValue isEqualToString:@"hello"], @"StringObject__stringValue error");
//        NSAssert(dict.amkpp_aIntegerObject__integerValue == 123, @"IntegerObject__integerValue error");
//        NSAssert(dict.amkpp_aBoolObject__boolValue == YES, @"BoolObject__boolValue error");
//        NSAssert(dict.amkpp_aDoubleObject__doubleValue - 3.14 < FLT_EPSILON, @"DoubleObject__doubleValue error");
//        NSAssert(dict.amkpp_aDoubleObject__floatValue - 3.14 < FLT_EPSILON, @"DoubleObject__floatValue error");
////        NSAssert([dict.amkpp_aDoubleObject isEqualToNumber:@3.14], @"double object error");
////        NSAssert([dict.amkpp_aNumberObject isEqualToNumber:@42], @"number object error");
////        NSAssert([dict.amkpp_anArrayObject isKindOfClass:NSArray.class], @"array object error");
////        NSAssert([dict.amkpp_aDictObject isKindOfClass:NSDictionary.class], @"dict object error");
////        NSAssert(dict.amkpp_aNullObject == nil, @"null object error");
////        NSAssert([dict.amkpp_aBlockObject isKindOfClass:NSClassFromString(@"NSBlock")], @"block object error");
////        NSAssert(dict.amkpp_aCustomObject == customObj, @"custom object object error");
//        
////        NSLog(@"✅ All tests passed for type safety");
//    }];
//}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
