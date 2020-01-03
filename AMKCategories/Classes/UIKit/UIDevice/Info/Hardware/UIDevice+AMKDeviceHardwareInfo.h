//
//  UIDevice+AMKDeviceHardwareInfo.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/1/3.
//

#import <UIKit/UIKit.h>

/// 设备硬件信息 相关扩展
@interface UIDevice (AMKDeviceHardwareInfo)

/// 设备型号，如："iPhone6,1"、"iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *amk_machineModel;

@end
