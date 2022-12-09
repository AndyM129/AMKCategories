//
//  AMKGitCommitInfoViewController.m
//  AMKCategories_Example
//
//  Created by https://github.com/andym129 on 2019/7/26.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import "AMKGitCommitInfoViewController.h"
#import <AMKCategories/NSBundle+AMKGitCommitInfo.h>
#import <AMKCategories/UILabel+AMKLabelDrawing.h>

@interface AMKGitCommitInfoViewController ()
@property(nonatomic, strong) UITextView *textView;
@end

@implementation AMKGitCommitInfoViewController

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Git提交信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *bundleInfo = [NSMutableDictionary dictionary];
    bundleInfo[@"GitCommitSHA"] = NSBundle.mainBundle.amk_gitCommitSHA ?:@"";
    bundleInfo[@"GitCommitShortSHA"] = NSBundle.mainBundle.amk_gitCommitShortSHA ?:@"";
    bundleInfo[@"GitCommitBranch"] = NSBundle.mainBundle.amk_gitCommitBranch ?:@"";
    bundleInfo[@"GitCommitUser"] = NSBundle.mainBundle.amk_gitCommitUser ?:@"";
    bundleInfo[@"GitCommitDate"] = NSBundle.mainBundle.amk_gitCommitDate ?:@"";
    bundleInfo[@"GitCommitLocalDate"] = [NSBundle.mainBundle amk_gitCommitDateStringWithFormat:nil];
    self.textView.text = [bundleInfo description];
    
    [self buildInfoLabel];
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

#pragma mark - Properties

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.frame = self.view.bounds;
        _textView.editable = NO;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_textView];
    }
    return _textView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (UILabel *)buildInfoLabel {
    UIView *superview = UIApplication.sharedApplication.delegate.window;
    UILabel *buildInfoLabel = [superview viewWithTag:@"buildInfoLabel".hash];
    if (!buildInfoLabel) {
        buildInfoLabel = [UILabel.alloc init];
        buildInfoLabel.amk_contentInset = UIEdgeInsetsMake(5, 3, 1, 3);
        buildInfoLabel.layer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2].CGColor;
        buildInfoLabel.layer.cornerRadius = buildInfoLabel.amk_contentInset.top;
        buildInfoLabel.font = [UIFont systemFontOfSize:10];
        buildInfoLabel.adjustsFontSizeToFitWidth = YES;
        buildInfoLabel.textColor = [UIColor colorWithWhite:0 alpha:0.3];
        buildInfoLabel.text = [NSString stringWithFormat:@"%@@%@ %@", NSBundle.mainBundle.amk_gitCommitBranch, NSBundle.mainBundle.amk_gitCommitShortSHA, [NSBundle.mainBundle amk_gitCommitDateStringWithFormat:nil]];
        [superview addSubview:buildInfoLabel];
        [buildInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(superview);
            make.top.mas_equalTo(superview).inset(-buildInfoLabel.layer.cornerRadius);
            make.width.mas_lessThanOrEqualTo(superview).inset(10);
        }];
    }
    return buildInfoLabel;
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods


@end
