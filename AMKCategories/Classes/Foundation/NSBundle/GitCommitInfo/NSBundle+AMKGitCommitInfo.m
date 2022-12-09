//
//  NSBundle+AMKGitCommitInfo.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/7/26.
//

#import "NSBundle+AMKGitCommitInfo.h"
#import <objc/runtime.h>

NSString * _Nonnull const AMKGitCommitSHAInfoKey = @"AMKGitCommitSHA";
NSString * _Nonnull const AMKGitCommitBranchInfoKey = @"AMKGitCommitBranch";
NSString * _Nonnull const AMKGitCommitUserInfoKey = @"AMKGitCommitUser";
NSString * _Nonnull const AMKGitCommitDateInfoKey = @"AMKGitCommitDate";


@implementation NSBundle (AMKGitCommitInfo)

#pragma mark - Init Methods

#pragma mark - Properties

- (NSString *)amk_gitCommitSHA {
    static NSString *gitCommitSHA = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gitCommitSHA = [NSBundle mainBundle].infoDictionary[AMKGitCommitSHAInfoKey];
    });
    return gitCommitSHA;
}

- (NSString *)amk_gitCommitShortSHA {
    static NSString *gitCommitShortSHA = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gitCommitShortSHA = [self.amk_gitCommitSHA substringToIndex:MIN(6, self.amk_gitCommitSHA.length)];
    });
    return gitCommitShortSHA;
}

- (NSString *)amk_gitCommitBranch {
    static NSString *gitCommitBranch = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gitCommitBranch = [NSBundle mainBundle].infoDictionary[AMKGitCommitBranchInfoKey];
    });
    return gitCommitBranch;
}

- (NSString *)amk_gitCommitUser {
    static NSString *gitCommitUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gitCommitUser = [NSBundle mainBundle].infoDictionary[AMKGitCommitUserInfoKey];
    });
    return gitCommitUser;
}

- (NSDate *)amk_gitCommitDate {
    static NSDate *gitCommitDate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *gitCommitDateStr = [NSBundle mainBundle].infoDictionary[AMKGitCommitDateInfoKey];
        NSString *timeZoneString = [gitCommitDateStr componentsSeparatedByString:@"+"].lastObject;
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
        gitCommitDate = [formatter dateFromString:gitCommitDateStr];
        gitCommitDate = [gitCommitDate dateByAddingTimeInterval:timeZoneString.integerValue/100*3600];
    });
    return gitCommitDate;
}

#pragma mark - Public Methods

- (NSString *)amk_gitCommitDateStringWithFormat:(NSString *)dateFormat {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    });
    dateFormatter.dateFormat = dateFormat.length ? dateFormat : @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter stringFromDate:self.amk_gitCommitDate];
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end
