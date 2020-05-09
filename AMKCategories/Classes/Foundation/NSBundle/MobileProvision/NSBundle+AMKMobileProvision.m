//
//  NSBundle+AMKMobileProvision.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/9.
//

#import "NSBundle+AMKMobileProvision.h"

@implementation NSBundle (AMKMobileProvision)

#pragma mark - Init Methods

#pragma mark - Properties

- (NSString *)amk_mobileProvisionPath {
    static NSString *mobileProvisionPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mobileProvisionPath = [self pathForResource:@"embedded" ofType:@"mobileprovision"];
    });
    return mobileProvisionPath.copy;
}

// 参考：https://github.com/amazon-archives/BSMobileProvision
- (NSDictionary<NSString *,id> *)amk_mobileProvisionInfoDictionary {
    static NSDictionary<NSString *,id> *mobileProvisionInfoDictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *mobileProvisionPath = [self amk_mobileProvisionPath];
        if (!mobileProvisionPath.length) {
            NSLog(@"unable to find mobile provision path");
        } else {
            // NSISOLatin1 keeps the binary wrapper from being parsed as unicode and dropped as invalid
            NSString *binaryString = [NSString stringWithContentsOfFile:mobileProvisionPath encoding:NSISOLatin1StringEncoding error:NULL];
            if (!binaryString) {
                NSLog(@"unable to load contents of mobile provision");
            } else {
                NSScanner *scanner = [NSScanner scannerWithString:binaryString];
                BOOL ok = [scanner scanUpToString:@"<plist" intoString:nil];
                if (!ok) {
                    NSLog(@"unable to find beginning of plist");
                } else {
                    NSString *plistString;
                    BOOL ok = [scanner scanUpToString:@"</plist>" intoString:&plistString];
                    if (!ok) {
                        NSLog(@"unable to find end of plist");
                    } else {
                        plistString = [NSString stringWithFormat:@"%@</plist>",plistString];
                        // juggle latin1 back to utf-8!
                        NSData *plistdata_latin1 = [plistString dataUsingEncoding:NSISOLatin1StringEncoding];
                        //        plistString = [NSString stringWithUTF8String:[plistdata_latin1 bytes]];
                        //        NSData *plistdata2_latin1 = [plistString dataUsingEncoding:NSISOLatin1StringEncoding];
                        NSError *error = nil;
                        mobileProvisionInfoDictionary = [NSPropertyListSerialization propertyListWithData:plistdata_latin1 options:NSPropertyListImmutable format:NULL error:&error];
                        if (error) {
                            mobileProvisionInfoDictionary = nil;
                            NSLog(@"error parsing extracted plist — %@",error);
                        }
                    }
                }
            }
        }
    });
    return mobileProvisionInfoDictionary.copy;
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end

//#if defined(DEBUG)
//
//@implementation NSBundle (AMKMobileProvisionTests)
//
//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self test_amk_mobileProvisionInfoDictionary];
//    });
//}
//
//+ (void)test_amk_mobileProvisionInfoDictionary {
//    NSLog(@"MobileProvisionInfoDictionary = %@", NSBundle.mainBundle.amk_mobileProvisionInfoDictionary);
//}
//
//@end
//
//#endif
