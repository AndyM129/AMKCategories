//
//  WKWebView+AMKScreenshot.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/4/27.
//

#import "WKWebView+AMKScreenshot.h"

@implementation WKWebView (AMKScreenshot)

#pragma mark - Init Methods

#pragma mark - Properties

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

-(void)snaplongWebViewWithMaxHeight:(CGFloat)maxheigtht finsih:(void (^)(UIImage * image))finishBlock{
    [self screenSnapshotNeedMask:NO addMaskAfterBlock:nil finishBlock:^(UIImage *snapShotImage) {
        
        finishBlock(snapShotImage);
        NSLog(@"📸 ✅ 截图生成成功: %@", snapShotImage);
    }];
    
}

#pragma mark WKWebView (TYSnapshot)

- (void )screenSnapshotNeedMask:(BOOL)needMask addMaskAfterBlock:(void(^)(void))addMaskAfterBlock finishBlock:(void(^)(UIImage *snapShotImage))finishBlock{
    if (!finishBlock)return;
    
//    UIView *snapShotMaskView;
//    if (needMask){
//        snapShotMaskView = [self addSnapShotMaskView];
//        addMaskAfterBlock?addMaskAfterBlock():nil;
//    }
    
    //保存原始信息
    CGRect oldFrame = self.frame;
    CGPoint oldOffset = self.scrollView.contentOffset;
    CGSize contentSize = self.scrollView.contentSize;
//    contentSize.height = self.snapshotHeight;
    
    //计算快照屏幕数
    NSUInteger snapshotScreenCount = floorf(contentSize.height / self.scrollView.bounds.size.height);
    
    //设置frame为contentSize
    self.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    
    self.scrollView.contentOffset = CGPointZero;
    
    UIGraphicsBeginImageContextWithOptions(contentSize, NO, [UIScreen mainScreen].scale);
    
    __weak typeof(self) weakSelf = self;
    //截取完所有图片
    [self scrollToDraw:0 maxIndex:(NSInteger )snapshotScreenCount finishBlock:^{
//        if (snapShotMaskView){
//            [snapShotMaskView removeFromSuperview];
//        }
        
        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        weakSelf.frame = oldFrame;
        weakSelf.scrollView.contentOffset = oldOffset;
        
        finishBlock(snapshotImage);
    }];
}

//滑动画了再截图
- (void )scrollToDraw:(NSInteger )index maxIndex:(NSInteger )maxIndex finishBlock:(void(^)(void))finishBlock{
    UIView *snapshotView = self;
    
    //截取的frame
    CGRect snapshotFrame = CGRectMake(0, (float)index * snapshotView.bounds.size.height, snapshotView.bounds.size.width, snapshotView.bounds.size.height);
    
    [self.scrollView setContentOffset:CGPointMake(0, index * snapshotView.frame.size.height)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(700 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        
        [snapshotView drawViewHierarchyInRect:snapshotFrame afterScreenUpdates:YES];
        
        if(index < maxIndex){
            [self scrollToDraw:index + 1 maxIndex:maxIndex finishBlock:finishBlock];
        }else{
            if (finishBlock) {
                finishBlock();
            }
        }
    });
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
