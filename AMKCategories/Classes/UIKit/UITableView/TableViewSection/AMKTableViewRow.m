//
//  AMKTableViewRow.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/7/15.
//

#import "AMKTableViewRow.h"

@implementation AMKTableViewRow

#pragma mark - Init Methods

- (void)dealloc {
    
}

+ (instancetype)tableViewRow {
    return [[AMKTableViewRow alloc] initWithIdentifier:nil];
}

+ (instancetype)tableViewRowWithIdentifier:(NSString *)identifier {
    return [[AMKTableViewRow alloc] initWithIdentifier:identifier];
}

- (instancetype)initWithIdentifier:(NSString *)identifier {
    return [self initWithIdentifier:identifier userInfo:nil];
}

- (instancetype)initWithIdentifier:(NSString *)identifier userInfo:(NSDictionary *)userInfo {
    if (self = [super init]) {
        self.identifier = identifier;
        self.userInfo = userInfo.mutableCopy;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Getters & Setters

- (NSMutableDictionary *)userInfo {
    if (!_userInfo) {
        _userInfo = [NSMutableDictionary dictionary];
    }
    return _userInfo;
}

#pragma mark - Data & Networking

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[AMKTableViewRow class]] && [[object identifier] isEqualToString:self.identifier]) {
        return YES;
    }
    return NO;
}

- (NSUInteger)hash {
    return [super hash];
}

#pragma mark - Helper Methods

@end
