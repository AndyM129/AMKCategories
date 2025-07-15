//
//  AMKTableViewSection.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/7/15.
//

#import "AMKTableViewSection.h"

@implementation AMKTableViewSection

#pragma mark - Init Methods

- (void)dealloc {
    
}

+ (instancetype)tableViewSectionWithIdentifier:(NSString *)identifier rows:(NSMutableArray<AMKTableViewRow *> *)rows {
    return [[AMKTableViewSection alloc] initWithIdentifier:identifier rows:rows];
}

- (instancetype)initWithIdentifier:(NSString *)identifier rows:(NSMutableArray<AMKTableViewRow *> *)rows {
    return [self initWithIdentifier:identifier title:nil userInfo:nil rows:rows];
}

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title userInfo:(NSDictionary *)userInfo rows:(NSMutableArray<AMKTableViewRow *> *)rows {
    if (self = [super init]) {
        self.identifier = identifier;
        self.title = title;
        self.userInfo = userInfo.mutableCopy;
        self.rows = rows;
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

- (NSMutableArray<AMKTableViewRow *> *)rows {
    if (!_rows) {
        _rows = [NSMutableArray array];
    }
    return _rows;
}

#pragma mark - Data & Networking

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[AMKTableViewSection class]]
        && [[object identifier] isEqualToString:self.identifier]
        && [[object title] isEqualToString:self.title]
        && [[object rows] isEqualToArray:self.rows]) {
        return YES;
    }
    return NO;
}
- (NSUInteger)hash {
    return [super hash];
}

#pragma mark - Helper Methods

@end
