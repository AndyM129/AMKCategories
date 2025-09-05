//
//  AMKDictionaryProtocolPropertiesExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/9/5.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKDictionaryProtocolPropertiesExampleViewController.h"
#import <AMKCategories/NSDictionary+AMKProtocolProperties.h>

/// 【示例1】在协议中声明 xxx 字典中 key 对应的属性，以便支持直接通过属性访问对应Key值
@protocol AMKExampleDictionaryPropertiesProtocol <NSObject>
@optional
@property (nonatomic, copy, readonly, nullable) id amkpp_aStringObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aIntegerObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aBoolObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aDoubleObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aNumberObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_anArrayObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aDictObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aNullObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aBlockObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aCustomObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aCustomObjectWithCustomImplementation;
@end

/// 【示例1】给 NSDictionary 指定该属性协议
@interface NSDictionary (AMKExampleDictionaryPropertiesProtocol) <AMKExampleDictionaryPropertiesProtocol>

@end

@implementation NSDictionary (AMKExampleDictionaryPropertiesProtocol)

/// 【示意1】支持自定义实现对应属性的 getter
- (id)amkpp_aCustomObjectWithCustomImplementation {
    return [NSString stringWithFormat:@"自定义实现：%@", [self objectForKey:@"aCustomObjectWithCustomImplementation"]];
}

@end

#pragma mark -
#pragma mark -

/// 【示例2】在协议中声明 xxx 字典中 key 对应的属性，以便支持直接通过属性访问对应Key值
@protocol AMKExampleDictionaryPropertiesProtocol_2 <NSObject>
@optional
@property (nonatomic, readonly, copy, nullable) NSString *amkpp_aStringObject__stringValue;
@property (nonatomic, readonly, assign) NSInteger amkpp_aIntegerObject__integerValue;
//@property (nonatomic, readonly, copy, nullable) id amkpp_aBoolObject__BoolObject;
//@property (nonatomic, readonly, copy, nullable) id amkpp_aDoubleObject__DoubleObject;
//@property (nonatomic, readonly, copy, nullable) id amkpp_aNumberObject__NumberObject;
//@property (nonatomic, readonly, copy, nullable) id amkpp_anArrayObject__nArrayObject;
//@property (nonatomic, readonly, copy, nullable) id amkpp_aDictObject__DictObject;
//@property (nonatomic, readonly, copy, nullable) id amkpp_aNullObject__NullObject;
//@property (nonatomic, readonly, copy, nullable) id amkpp_aBlockObject__BlockObject;
//@property (nonatomic, readonly, copy, nullable) id amkpp_aCustomObject__CustomObject;
//@property (nonatomic, readonly, copy, nullable) id amkpp_aCustomObjectWithCustomImplementation__CustomObjectWithCustomImplementation;
@end

/// 【示例2】给 NSDictionary 指定该属性协议
@interface NSDictionary (AMKExampleDictionaryPropertiesProtocol_2) <AMKExampleDictionaryPropertiesProtocol_2>

@end

#pragma mark -
#pragma mark -

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
    [self.exampleStackView addArrangedButton:@"【示例1】通过协议属性 获取key值" customBlock:nil touchUpInsideBlock:^(UIButton * _Nullable button) {
        @strongify(self)
        if (!self) return;
        
        void (^block)(void) = ^{ NSLog(@"Block executed"); };
        NSObject *customObj = [NSObject new];

        NSDictionary<AMKExampleDictionaryPropertiesProtocol> *dict = (NSDictionary<AMKExampleDictionaryPropertiesProtocol> *)@{
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
    
    [self.exampleStackView addArrangedButton:@"【示例2】通过协议属性 获取key值 - 指定类型" customBlock:nil touchUpInsideBlock:^(UIButton * _Nullable button) {
        @strongify(self)
        if (!self) return;
        
        void (^block)(void) = ^{ NSLog(@"Block executed"); };
        NSObject *customObj = [NSObject new];
        
        // 正确类型
        NSDictionary<AMKExampleDictionaryPropertiesProtocol_2> *dict = (NSDictionary<AMKExampleDictionaryPropertiesProtocol_2> *)@{
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
        
        // 类型不匹配
        NSDictionary<AMKExampleDictionaryPropertiesProtocol_2> *mismatch = (NSDictionary<AMKExampleDictionaryPropertiesProtocol_2> *)@{
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
        
        // 测试
        NSLog(@"dict.amkpp_aStringObject__stringValue = %@", dict.amkpp_aStringObject__stringValue);
        NSLog(@"mismatch.amkpp_aStringObject__stringValue = %@", mismatch.amkpp_aStringObject__stringValue);
        
//        NSAssert([dict.amkpp_aStringObject__stringValue isEqualToString:@"hello"], @"__stringValue error");
//        NSAssert([mismatch.amkpp_aStringObject__stringValue isEqualToString:@"123"], @"__stringValue error");

        
        
        
//        NSAssert(dict.amkpp_aIntegerValue == 123, @"integer error");
//        NSAssert(dict.amkpp_aBoolValue == YES, @"bool error");
//        NSAssert(fabs(dict.amkpp_aDoubleValue - 3.14) < 0.0001, @"double error");
//        NSAssert([dict.amkpp_aNumberValue isEqual:@42], @"number error");
//        NSAssert([dict.amkpp_anArray isKindOfClass:[NSArray class]], @"array error");
//        NSAssert([dict.amkpp_aDict isKindOfClass:[NSDictionary class]], @"dict error");
//        NSAssert(dict.amkpp_aBlock != nil, @"block error");
//        NSAssert(dict.amkpp_aCustomObject == customObj, @"custom object error");

        
        
//        NSLog(@"dict.amkpp_aStringObject = %@", dict.amkpp_aStringObject__stringValue);
//        NSLog(@"dict.amkpp_aIntegerObject = %@", dict.amkpp_aIntegerObject);
//        NSLog(@"dict.amkpp_aBoolObject = %@", dict.amkpp_aBoolObject);
//        NSLog(@"dict.amkpp_aDoubleObject = %@", dict.amkpp_aDoubleObject);
//        NSLog(@"dict.amkpp_aNumberObject = %@", dict.amkpp_aNumberObject);
//        NSLog(@"dict.amkpp_anArrayObject = %@", dict.amkpp_anArrayObject);
//        NSLog(@"dict.amkpp_aDictObject = %@", dict.amkpp_aDictObject);
//        NSLog(@"dict.amkpp_aNullObject = %@", dict.amkpp_aNullObject);
//        NSLog(@"dict.amkpp_aBlockObject = %@", dict.amkpp_aBlockObject);
//        NSLog(@"dict.amkpp_aCustomObject = %@", dict.amkpp_aCustomObject);
//        NSLog(@"dict.amkpp_aCustomObjectWithCustomImplementation = %@", dict.amkpp_aCustomObjectWithCustomImplementation);

//        NSAssert([dict.amkpp_aStringObject__stringValue isEqualToString:@"hello"], @"__stringValue error");

//        NSAssert([dict.amkpp_aStringObject isEqualToString:@"hello"], @"string object error");
//        NSAssert([dict.amkpp_aIntegerObject isEqualToNumber:@123], @"integer object error");
//        NSAssert([dict.amkpp_aBoolObject isEqualToNumber:@YES], @"bool object error");
//        NSAssert([dict.amkpp_aDoubleObject isEqualToNumber:@3.14], @"double object error");
//        NSAssert([dict.amkpp_aNumberObject isEqualToNumber:@42], @"number object error");
//        NSAssert([dict.amkpp_anArrayObject isKindOfClass:NSArray.class], @"array object error");
//        NSAssert([dict.amkpp_aDictObject isKindOfClass:NSDictionary.class], @"dict object error");
//        NSAssert(dict.amkpp_aNullObject == nil, @"null object error");
//        NSAssert([dict.amkpp_aBlockObject isKindOfClass:NSClassFromString(@"NSBlock")], @"block object error");
//        NSAssert(dict.amkpp_aCustomObject == customObj, @"custom object object error");
        
//        NSLog(@"✅ All tests passed for type safety");
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
