//
//  WKNNestedScrollTableExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableExampleViewController.h"
#import "WKNNestedScrollTableExampleNormalTableViewCell.h"
#import "WKNNestedScrollTableView.h"
#import <AMKCategories/UITableView+AMKTableViewSection.h>

@interface WKNNestedScrollTableExampleViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong, readwrite, nullable) WKNNestedScrollTableView *tableView;
@end

@implementation WKNNestedScrollTableExampleViewController

+ (void)load {
    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull notification) {
        [NSNotificationCenter.defaultCenter removeObserver:token];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIViewController amk_pushViewController:self.new animated:YES];
        });
    }];
}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"WKNNestedScrollTableView 示例页";
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

- (WKNNestedScrollTableView *)tableView {
    if (!_tableView) {
        _tableView = [WKNNestedScrollTableView.alloc initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView.alloc initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, CGFLOAT_MIN)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:WKNNestedScrollTableExampleNormalTableViewCell.class forCellReuseIdentifier:WKNNestedScrollTableExampleNormalTableViewCell.className];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.className];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - Data & Networking

- (void)reloadData {
    NSMutableArray<AMKTableViewSection *> *sections = @[].mutableCopy;
    [sections addObject:({
        AMKTableViewSection *section = [AMKTableViewSection.alloc initWithIdentifier:WKNNestedScrollTableExampleNormalTableViewCell.className rows:nil];
        for (NSInteger i=0; i<5; i++) {
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:WKNNestedScrollTableExampleNormalTableViewCell.className userInfo:nil]];
        }
        section;
    })];
    [sections addObject:({
        AMKTableViewSection *section = [AMKTableViewSection.alloc initWithIdentifier:WKNNestedScrollTableExampleNormalTableViewCell.className rows:nil];
        for (NSInteger i=0; i<5; i++) {
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:WKNNestedScrollTableExampleNormalTableViewCell.className userInfo:nil]];
        }
        section;
    })];
//    [sections addObject:({
//        AMKTableViewSection *section = [AMKTableViewSection.alloc initWithIdentifier:AMK10090ExampleCategoryTitleTableViewCell.className rows:nil];
//        [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleCategoryTitleTableViewCell.className userInfo:nil]];
//        if (self.categoryTitleViewSelectedIndex == 0) {
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleWebViewTableViewCell.className userInfo:nil]];
//        } else {
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
//            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
//        }
//        section;
//    })];
    
    self.tableView.amk_sections = sections;
    [self.tableView reloadData];
}

#pragma mark - Layout Subviews

- (void)updateViewConstraints {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [super updateViewConstraints];
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableView.amk_sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AMKTableViewSection *tableViewSection = self.tableView.amk_sections[section];
    return tableViewSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMKTableViewSection *tableViewSection = self.tableView.amk_sections[indexPath.section];
    AMKTableViewRow *tableViewRow = tableViewSection.rows[indexPath.row];
    
    if ([tableViewRow.identifier isEqualToString:WKNNestedScrollTableExampleNormalTableViewCell.className]) {
        WKNNestedScrollTableExampleNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WKNNestedScrollTableExampleNormalTableViewCell.className forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"Item <%ld, %ld>", indexPath.section, indexPath.row];
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:UITableViewCell.className forIndexPath:indexPath];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMKTableViewSection *tableViewSection = self.tableView.amk_sections[indexPath.section];
    AMKTableViewRow *tableViewRow = tableViewSection.rows[indexPath.row];
    
    if ([tableViewRow.identifier isEqualToString:WKNNestedScrollTableExampleNormalTableViewCell.className]) {
        return [WKNNestedScrollTableExampleNormalTableViewCell tableView:tableView heightForRowAtIndexPath:indexPath withParams:nil];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Helper Methods

@end
