//
//  UITableView+AMKTableViewDelegate.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2019/11/21.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

/// UITableView 代理扩展
@protocol AMKTableViewDelegate <UITableViewDelegate>

@optional

/// 即将刷新数据
- (void)amk_tableViewWillReloadData:(UITableView *_Nullable)tableView;

/// 已刷新数据
- (void)amk_tableViewDidReloadData:(UITableView *_Nullable)tableView;

@end
