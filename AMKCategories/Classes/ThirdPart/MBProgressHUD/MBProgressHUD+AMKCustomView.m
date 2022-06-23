//
//  MBProgressHUD+AMKCustomView.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2022/6/23.
//

#import "MBProgressHUD+AMKCustomView.h"

@interface AMKMBProgressHUDCustomView ()

@end

@implementation AMKMBProgressHUDCustomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

@synthesize intrinsicContentSize = _intrinsicContentSize;

- (CGSize)intrinsicContentSize {
    if (CGSizeEqualToSize(CGSizeZero, _intrinsicContentSize)) {
        return self.frame.size;
    }
    return _intrinsicContentSize;
}

@end
