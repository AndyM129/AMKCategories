//
//  AMKScreenshotPreviewViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2020/4/27.
//  Copyright © 2020 AndyM129. All rights reserved.
//

#import "AMKScreenshotPreviewViewController.h"

@interface AMKScreenshotPreviewViewController ()
@property(nonatomic, strong, nullable, readwrite) UIScrollView *scrollView;
@property(nonatomic, strong, nullable, readwrite) UIImageView *imageView;
@end

@implementation AMKScreenshotPreviewViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"快速浏览" style:UIBarButtonItemStylePlain target:self action:@selector(didClickQuickLookBarButtonItem:)];
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

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView.alloc init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView.alloc init];
        [self.scrollView addSubview:_imageView];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.scrollView.contentSize = image.size;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)didClickQuickLookBarButtonItem:(id)sender {
    [UIView animateWithDuration:self.scrollView.contentSize.height/self.view.bounds.size.height*0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentSize.height-self.scrollView.bounds.size.height);
    }];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
