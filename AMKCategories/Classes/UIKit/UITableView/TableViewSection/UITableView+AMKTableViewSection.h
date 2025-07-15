//
//  UITableView+AMKTableViewSection.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/7/15.
//

#import <AMKCategories/AMKTableViewSection.h>

/// UITableView Section Utlities
@interface UITableView (AMKTableViewSection)
@property (nonatomic, copy) NSMutableArray<AMKTableViewSection *> *amk_sections; //!< 分区信息
@property (nonatomic, assign, getter=amk_isSelectAll) BOOL amk_selectAll;//!< 是否全部选中

- (NSIndexSet *)amk_indexesOfSectionsWithIdentifier:(NSString *)identifier;
- (NSArray<AMKTableViewSection *> *)amk_sectionsWithIdentifier:(NSString *)identifier;
- (NSArray<AMKTableViewRow *> *)amk_rowsWithIdentifier:(NSString *)identifier;
@end
