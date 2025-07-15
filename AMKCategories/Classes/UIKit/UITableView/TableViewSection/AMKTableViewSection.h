//
//  AMKTableViewSection.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/7/15.
//

#import <AMKCategories/AMKTableViewRow.h>

/// UITableView SectionModel
@interface AMKTableViewSection : NSObject
@property (nonatomic, copy) NSString *identifier; //!< id
@property (nonatomic, copy) NSString *title; //!< 标题
@property (nonatomic, strong) NSMutableDictionary *userInfo; //!< 自定义信息
@property (nonatomic, strong) NSMutableArray<AMKTableViewRow *> *rows;

+ (instancetype)tableViewSectionWithIdentifier:(NSString *)identifier rows:(NSMutableArray<AMKTableViewRow *> *)rows;
- (instancetype)initWithIdentifier:(NSString *)identifier rows:(NSMutableArray<AMKTableViewRow *> *)rows;
- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title userInfo:(NSDictionary *)userInfo rows:(NSMutableArray<AMKTableViewRow *> *)rows;
@end
