//
//  AMKAppDelegate.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 07/26/2019.
//  Copyright (c) 2019 AndyM129. All rights reserved.
//

#import "AMKAppDelegate.h"
#import "AMKRootViewController.h"
#import <AMKCategories/UIWindow+AMKReleaseMode.h>
#import <FLEX/FLEX.h>

@implementation AMKAppDelegate

#pragma mark - Life Circle

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    [self setupAppearanceOfNavigationBar];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [UIWindow.alloc initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = AMKRootViewController.new;
    [self.window makeKeyAndVisible];
    //    [application amk_showAlertIfMobileProvisionWillExpireInDays:999];
    //    [application setAmk_releaseModeCornerMarkEnable:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FLEXManager.sharedManager showExplorer];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

/// 设置「导航栏」UI样式
- (void)setupAppearanceOfNavigationBar {
    [UINavigationBar.appearance setTranslucent:NO];
    [UINavigationBar.appearance setTintColor:UIColor.blackColor];
    [UINavigationBar.appearance setBarTintColor:UIColor.orangeColor];
    [UINavigationBar.appearance setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName: UIColor.blackColor}];
    [UINavigationBar.appearance setBackgroundColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]];
    [UINavigationBar.appearance setPrefersLargeTitles:NO];
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = [UINavigationBarAppearance.alloc init];
        appperance.backgroundColor = UINavigationBar.appearance.backgroundColor;
        appperance.titleTextAttributes = UINavigationBar.appearance.titleTextAttributes;
        UINavigationBar.appearance.standardAppearance = appperance;
        UINavigationBar.appearance.scrollEdgeAppearance = appperance;
    }
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end

#pragma mark -
#pragma mark -

#if __has_include(<LookinServer/LookinServer.h>)

@implementation NSObject (LookinConfig)

+ (BOOL)lookin_shouldCaptureImageOfView:(UIView *)view {
    NSArray *noShowViews = @[
        NSClassFromString(@"FLEXWindow"),
    ];
    return [noShowViews containsObject:view.class] ? NO : YES;
}

@end

#endif





#import <objc/runtime.h>

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

@interface NSDictionary (AMKProtocolProperties)
@end

@implementation NSDictionary (AMKProtocolProperties)

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    struct objc_method_description methodDesc = protocol_getMethodDescription(@protocol(AMKProtocolPropertiesExampleDictionary), sel, YES, YES);
    if (methodDesc.name == NULL) {
        return [super resolveInstanceMethod:sel];
    }

    const char *encoding = methodDesc.types;

    switch (encoding[0]) {
        case _C_ID:
            class_addMethod(self, sel, (IMP)amkProtocolProperties_dynamicGetter_id_safe, encoding);
            break;
        case _C_INT:
        case _C_LNG_LNG:
            class_addMethod(self, sel, (IMP)amkProtocolProperties_dynamicGetter_integer, encoding);
            break;
        case _C_BOOL:
            class_addMethod(self, sel, (IMP)amkProtocolProperties_dynamicGetter_bool, encoding);
            break;
        case _C_DBL:
        case _C_FLT:
            class_addMethod(self, sel, (IMP)amkProtocolProperties_dynamicGetter_double, encoding);
            break;
        default:
            class_addMethod(self, sel, (IMP)amkProtocolProperties_dynamicGetter_id_safe, encoding);
            break;
    }
    return YES;
}

#pragma mark - 动态 Getter

static NSString *amkProtocolProperties_keyFromSelector(SEL _cmd) {
    NSString *selName = NSStringFromSelector(_cmd);
    return [selName stringByReplacingOccurrencesOfString:@"amkpp_" withString:@""];
}

static id amkProtocolProperties_dynamicGetter_id_safe(id self, SEL _cmd) {
    NSString *key = amkProtocolProperties_keyFromSelector(_cmd);
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return nil;
    }

    // 获取协议属性类型
    objc_property_t property = class_getProperty([self class], sel_getName(_cmd));
    if (!property) return value;

    const char *typeEncoding = property_copyAttributeValue(property, "T");
    if (!typeEncoding) return value;

    id result = nil;

    if (typeEncoding[0] == _C_ID) {
        // 对象类型，解析类名
        char *className = property_copyAttributeValue(property, "T");
        if (className) {
            NSString *clsName = [NSString stringWithUTF8String:className];
            // 属性编码可能是 @"NSString"
            if ([clsName hasPrefix:@"@\""] && clsName.length > 3) {
                NSString *expectedClassName = [clsName substringWithRange:NSMakeRange(2, clsName.length - 3)];
                Class expectedClass = NSClassFromString(expectedClassName);
                if ([value isKindOfClass:expectedClass]) {
                    result = value;
                } else {
                    result = nil; // 类型不匹配返回 nil
                }
            } else {
                result = value;
            }
            free(className);
        } else {
            result = value;
        }
    } else {
        // 非对象类型，返回 nil
        result = nil;
    }

    free((void *)typeEncoding);
    return result;
}

static NSInteger amkProtocolProperties_dynamicGetter_integer(id self, SEL _cmd) {
    id value = [self objectForKey:amkProtocolProperties_keyFromSelector(_cmd)];
    return [value respondsToSelector:@selector(integerValue)] ? [value integerValue] : 0;
}

static BOOL amkProtocolProperties_dynamicGetter_bool(id self, SEL _cmd) {
    id value = [self objectForKey:amkProtocolProperties_keyFromSelector(_cmd)];
    return [value respondsToSelector:@selector(boolValue)] ? [value boolValue] : NO;
}

static double amkProtocolProperties_dynamicGetter_double(id self, SEL _cmd) {
    id value = [self objectForKey:amkProtocolProperties_keyFromSelector(_cmd)];
    return [value respondsToSelector:@selector(doubleValue)] ? [value doubleValue] : 0.0;
}

@end

#pragma mark - 测试

@interface Test : NSObject
@end

@implementation Test

+ (void)load {
    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [NSNotificationCenter.defaultCenter removeObserver:token];
        [self test];
    }];
}

+ (void)test {
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
}

@end
