//
//  AMKExampleTableViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/10.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleTableViewController.h"
#import "AMKExampleViewController.h"
#import "AMKExampleViewModel+AMKAssociatedObject.h"

static NSString * const AMKExamplesTableViewCellReusableIdentifier = @"AMKExamplesTableViewCellReusableIdentifier";

@interface AMKExampleTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong, readwrite, nullable) UITableView *tableView;
@property (nonatomic, strong, readwrite, nullable) UIView *tableHeaderView;
@property (nonatomic, strong, readwrite, nullable) UILabel *subtitleLabel;
@end

@implementation AMKExampleTableViewController

#pragma mark - Dealloc

- (void)dealloc {
    [_subtitleLabel removeObserverBlocks];
}

#pragma mark - Init Methods

- (instancetype)initWithViewModel:(AMKExampleViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Examples";
        self.tabBarItem.title = @"Examples";
        self.tabBarItem.image = [UIImage imageWithColor:UIColor.blueColor size:CGSizeMake(25, 25)];
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Getters & Setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView.alloc initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
        _tableView.tableFooterView = [UIView.alloc initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 100)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(1, 0, 0, 0);
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        if (@available(iOS 13.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView.alloc initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
        _tableHeaderView.layoutMargins = UIEdgeInsetsMake(10, 10, 20, 10);
    }
    return _tableHeaderView;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        __weak __typeof__(self)weakSelf = self;
        _subtitleLabel = [UILabel.alloc init];
        _subtitleLabel.numberOfLines = 0;
        _subtitleLabel.textColor = UIColor.placeholderTextColor;
        _subtitleLabel.font = [UIFont systemFontOfSize:13];
        [_subtitleLabel addObserverBlockForKeyPath:@"bounds" block:^(UILabel *subtitleLabel, NSValue *oldVal, NSValue *newVal) {
            if (![newVal isEqualToValue:oldVal]) {
                CGFloat subtitleLabelHeight = MAX(subtitleLabel.font.lineHeight, newVal.CGRectValue.size.height);
                UIEdgeInsets contentInset = weakSelf.tableView.contentInset;
                contentInset.top = weakSelf.tableHeaderView.layoutMargins.top + subtitleLabelHeight + weakSelf.tableHeaderView.layoutMargins.bottom;
                weakSelf.tableView.contentInset = contentInset;
            }
        }];
        [self.tableHeaderView addSubview:self.subtitleLabel];
    }
    return _subtitleLabel;
}

@synthesize viewModel = _viewModel;

- (void)setViewModel:(AMKExampleViewModel *)viewModel {
    _viewModel = viewModel;
    [self reloadData];
}

#pragma mark - Data & Networking

- (void)reloadData {
    self.title = self.viewModel.title;
    self.tabBarItem.title = self.viewModel.title;
    
    if (!self.isViewLoaded) {
        return;
    }
    
    self.subtitleLabel.text = _viewModel.subtitle;
    [self.tableView reloadData];
}

#pragma mark - Layout Subviews

- (void)updateViewConstraints {
    [self.subtitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.tableHeaderView).insets(self.tableHeaderView.layoutMargins);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [super updateViewConstraints];
}

#pragma mark - Action Methods

- (void)gotoExampleViewControllerWithViewModel:(AMKExampleViewModel *)viewModel {
    // 解析所选项 对应的 示例页类名（用内置的类兜底）
    Class pageClass = NSClassFromString(viewModel.pageClassName);
    if (!pageClass) {
        if (viewModel.subExamples.count) {
            pageClass = AMKExampleTableViewController.class;
        } else {
            pageClass = AMKExampleViewController.class;
        }
    }
    
    // 若对应的类 未遵守示例页协议，则直接初始化
    UIViewController *viewController = nil;
    if (![pageClass conformsToProtocol:@protocol(AMKExampleViewControllerProtocol)]) {
        viewController = [pageClass.alloc init];
    }
    // 否则以指定方法初始化
    else {
        viewController = [pageClass.alloc initWithViewModel:viewModel];
    }

    // 跳转页面
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.subExamples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AMKExampleViewModel *subViewModel = [self.viewModel.subExamples objectAtIndex:section];
    if (subViewModel.isExpanded) {
        return subViewModel.subExamples.count + 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMKExampleViewModel *subViewModel = [self.viewModel.subExamples objectAtIndex:indexPath.section];
    if (indexPath.row > 0) {
        subViewModel = [subViewModel.subExamples objectAtIndex:indexPath.row - 1];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AMKExamplesTableViewCellReusableIdentifier];
    if (!cell) {
        cell = [UITableViewCell.alloc initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AMKExamplesTableViewCellReusableIdentifier];
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
        cell.detailTextLabel.textColor = UIColor.grayColor;
    }
    cell.contentView.alpha = indexPath.row == 0 ? 1 : 0.5;
    cell.indentationLevel = indexPath.row == 0 ? 0 : 1;
    cell.separatorInset = UIEdgeInsetsMake(0, cell.indentationLevel * 40, 0, 0);
    cell.textLabel.text = subViewModel.title;
    cell.detailTextLabel.text = subViewModel.subtitle;
    cell.accessoryType = indexPath.row == 0 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AMKExampleViewModel *subViewModel = [self.viewModel.subExamples objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        if (subViewModel.subExamples.count) {
            subViewModel.isExpanded = !subViewModel.isExpanded;
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [self gotoExampleViewControllerWithViewModel:subViewModel];
        }
    } else {
        subViewModel = [subViewModel.subExamples objectAtIndex:indexPath.row - 1];
        [self gotoExampleViewControllerWithViewModel:subViewModel];
    }
}

#pragma mark - Helper Methods

@end
