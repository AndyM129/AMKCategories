//
//  AMKGitCommitInfoViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2019/7/26.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import "AMKGitCommitInfoViewController.h"
#import <AMKCategories/NSBundle+AMKGitCommitInfo.h>

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
    self.textView.text = [bundleInfo description];
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

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods


@end
