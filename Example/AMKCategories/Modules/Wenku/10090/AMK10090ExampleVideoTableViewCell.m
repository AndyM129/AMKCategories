//
//  AMK10090ExampleVideoTableViewCell.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/15.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMK10090ExampleVideoTableViewCell.h"

@interface AMK10090ExampleVideoTableViewCell ()
@property (nonatomic, strong, readwrite, nullable) UILabel *videoPlayerView;
@end

@implementation AMK10090ExampleVideoTableViewCell

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Getters & Setters

- (UILabel *)videoPlayerView {
    if (!_videoPlayerView) {
        _videoPlayerView = [UILabel.alloc init];
        _videoPlayerView.text = @"假装视频播放器";
        _videoPlayerView.textColor = [UIColor.whiteColor colorWithAlphaComponent:0.85];
        _videoPlayerView.textAlignment = NSTextAlignmentCenter;
        _videoPlayerView.backgroundColor = UIColor.blackColor;
        [self.contentView addSubview:_videoPlayerView];
    }
    return _videoPlayerView;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // 不调用父类实现，以避免编辑模式下的默认处理
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.videoPlayerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    // Clear subviews data ...
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
