//
//  AMKCustomProgressViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/7/8.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKCustomProgressViewController.h"
#import "AMKCustomProgressView.h"

@interface AMKCustomProgressViewController ()

@end

@implementation AMKCustomProgressViewController

//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIViewController amk_pushViewController:self.new animated:YES];
//    });
//}

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
    [self test_1];
    [self test_1_2];
    [self test_2];
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

#pragma mark - Data & Networking

#pragma mark - Layout Subviews


- (void)test_1 {
    CGFloat height = 10;
    UIView *progressView = [UIView.alloc initWithFrame:CGRectMake(0, 0, 0, height)];
    progressView.layer.masksToBounds = YES;
    progressView.layer.cornerRadius = height / 2;
    progressView.layer.backgroundColor = [[UIColor colorWithRed:0/255.0 green:140/255.0 blue:79/255.0 alpha:118/255.0] colorWithAlphaComponent:0.46].CGColor;
    
    UIImage *progressImage = [UIImage imageNamed:@"wkn_file_tab_top_cloud_space_progress_s"];
    progressImage = [progressImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, progressImage.size.height/2, 0, progressImage.size.height) resizingMode:UIImageResizingModeStretch];
    
    UIImageView *progressImageView = [UIImageView.alloc initWithImage:progressImage];
    [progressView addSubview:progressImageView];
    [progressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(progressView);
        make.height.mas_equalTo(progressView);
        make.left.mas_equalTo(progressView).offset(-height * 1.5);
        make.width.mas_equalTo(progressView).multipliedBy(0.3);
    }];
    
    [self.stackView addArrangedSubview:progressView];
    [self.stackView addArrangedButton:@"改变进度" controlEvents:UIControlEventTouchUpInside block:^(UIButton* sender) {
        CGFloat progress = arc4random() % 100 / 100.0;
        [sender setTitle:[NSString stringWithFormat:@"改变进度(%.0f%%)", progress*100] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            [progressImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(progressView);
                make.height.mas_equalTo(progressView);
                make.left.mas_equalTo(progressView).offset(-height * 1.5);
                make.width.mas_equalTo(progressView).multipliedBy(progress);
            }];
            [progressView layoutSubviews];
        }];
    }];
}

- (void)test_1_2 {
    CGFloat height = 5;
    UIView *progressView = [UIView.alloc initWithFrame:CGRectMake(0, 0, 0, height)];
    progressView.layer.masksToBounds = YES;
    progressView.layer.cornerRadius = height / 2;
    progressView.layer.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:255/255.0].CGColor;
    
    UIImage *progressImage = [UIImage imageNamed:@"wkn_file_tab_top_cloud_space_progress_s"];
    progressImage = [progressImage imageByTintColor:[UIColor colorWithRed:3/255.0 green:182/255.0 blue:104/255.0 alpha:255/255.0]];
    progressImage = [progressImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, progressImage.size.height/2, 0, progressImage.size.height) resizingMode:UIImageResizingModeStretch];
    
    UIImageView *progressImageView = [UIImageView.alloc initWithImage:progressImage];
    [progressView addSubview:progressImageView];
    [progressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(progressView);
        make.height.mas_equalTo(progressView);
        make.left.mas_equalTo(progressView).offset(-height * 1.5);
        make.width.mas_equalTo(progressView).multipliedBy(0.3);
    }];
    
    [self.stackView addArrangedSubview:progressView];
    [self.stackView addArrangedButton:@"改变进度" controlEvents:UIControlEventTouchUpInside block:^(UIButton* sender) {
        CGFloat progress = arc4random() % 100 / 100.0;
        [sender setTitle:[NSString stringWithFormat:@"改变进度(%.0f%%)", progress*100] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            [progressImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(progressView);
                make.height.mas_equalTo(progressView);
                make.left.mas_equalTo(progressView).offset(-height * 1.5);
                make.width.mas_equalTo(progressView).multipliedBy(progress);
            }];
            [progressView layoutSubviews];
        }];
    }];
}

- (void)test_2 {
    UIImage *progressImage = [UIImage imageNamed:@"wkn_file_tab_top_cloud_space_progress_s"];
    progressImage = [progressImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, progressImage.size.height/2, 0, progressImage.size.height) resizingMode:UIImageResizingModeStretch];

    AMKCustomProgressView *progressView = [AMKCustomProgressView.alloc initWithFrame:CGRectMake(0, 0, 0, 10)];
    progressView.layer.cornerRadius = 5;
    progressView.layer.masksToBounds = YES;
    progressView.layer.backgroundColor = [[UIColor colorWithRed:0/255.0 green:140/255.0 blue:79/255.0 alpha:118/255.0] colorWithAlphaComponent:0.46].CGColor;
    progressView.contentView.layer.cornerRadius = 1.5;
    progressView.contentView.layer.masksToBounds = YES;
    progressView.contentEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    progressView.progressImageView.image = progressImage;
    
    [self.stackView addArrangedSubview:progressView];
    [self.stackView addArrangedButton:@"改变进度" controlEvents:UIControlEventTouchUpInside block:^(UIButton* sender) {
        CGFloat progress = arc4random() % 100 / 100.0;
        if (progress > 0.8) progress = 1;
        [sender setTitle:[NSString stringWithFormat:@"改变进度(%.0f%%)", progress*100] forState:UIControlStateNormal];
        [progressView setProgress:progress animated:YES];
    }];
}
#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
