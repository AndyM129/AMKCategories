//
//  UIDevice+AMKDeviceHardwareInfo.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/1/3.
//

#import "UIDevice+AMKDeviceHardwareInfo.h"
#import <sys/sysctl.h>


@implementation UIDevice (AMKDeviceHardwareInfo)

#pragma mark - Init Methods

#pragma mark - Properties

- (NSString *)amk_machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
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
