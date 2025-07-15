//
//  AMK10090ExampleVideoTableViewCell.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/15.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMK10090ExampleVideoTableViewCell : UITableViewCell
@property (nonatomic, strong, readonly, nullable) UILabel *videoPlayerView;

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
