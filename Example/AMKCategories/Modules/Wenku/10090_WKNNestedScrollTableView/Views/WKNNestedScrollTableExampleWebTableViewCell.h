//
//  WKNNestedScrollTableExampleWebTableViewCell.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WKNNestedScrollTableViewCachedCellProtocol.h"
#import "WKNNestedScrollTableViewCellProtocol.h"

@interface WKNNestedScrollTableExampleWebTableViewCell : UITableViewCell <WKNNestedScrollTableViewCachedCellProtocol, WKNNestedScrollTableViewCellProtocol>

@property (nonatomic, strong, readonly, nullable) WKWebView *webView;

+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params;

@end

#pragma mark -

/// 长Web
@interface WKNNestedScrollTableExampleLongWebTableViewCell : WKNNestedScrollTableExampleWebTableViewCell

@end

#pragma mark -

/// 短Web
@interface WKNNestedScrollTableExampleShortWebTableViewCell : WKNNestedScrollTableExampleWebTableViewCell

@end
