//
//  AMKTableViewRow.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/7/15.
//

#import <UIKit/UIKit.h>

/// UITableView RowModel
@interface AMKTableViewRow : NSObject
@property (nonatomic, copy) NSString *identifier; //!< id
@property (nonatomic, strong) NSMutableDictionary *userInfo; //!< 自定义信息

+ (instancetype)tableViewRow;
+ (instancetype)tableViewRowWithIdentifier:(NSString *)identifier;
- (instancetype)initWithIdentifier:(NSString *)identifier;
- (instancetype)initWithIdentifier:(NSString *)identifier userInfo:(NSDictionary *)userInfo;
@end
