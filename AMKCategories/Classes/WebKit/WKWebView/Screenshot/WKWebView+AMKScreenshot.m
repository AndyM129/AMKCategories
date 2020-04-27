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

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Plan 1

-(void)snaplongWebViewWithMaxHeight:(CGFloat)maxheigtht finsih:(void (^)(UIImage * image))finishBlock{
    [self screenSnapshotNeedMask:NO addMaskAfterBlock:nil finishBlock:^(UIImage *snapShotImage) {
        
        finishBlock(snapShotImage);
        NSLog(@"📸 ✅ 截图生成成功: %@", snapShotImage);
    }];
    
}

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

#pragma mark - Plan 2

//- (void)takeScreenshotInRect:(CGRect)rect withCompletion:(void (^_Nullable)(UIImage *_Nullable image))completionHandler {
//    // 若没有回调，则直接返回
//    if (!completionHandler) return;
//
//    // 保存原始信息
//    CGRect originalFrame = self.frame;
//    CGPoint originalOffset = self.scrollView.contentOffset;
//    CGSize contentSize = self.scrollView.contentSize;
//
//    // 计算快照屏幕数
//    NSUInteger snapshotScreenCount = floorf(contentSize.height / self.scrollView.bounds.size.height);
//
//    // 设置frame为contentSize
//    self.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
//
//    // 回到top 准备开始截屏
//    self.scrollView.contentOffset = CGPointZero;
//    UIGraphicsBeginImageContextWithOptions(contentSize, NO, UIScreen.mainScreen.scale);
//
//    __weak typeof(self) weakSelf = self;
//    //截取完所有图片
//    [self scrollToDraw:0 maxIndex:(NSInteger )snapshotScreenCount finishBlock:^{
//        //        if (snapShotMaskView){
//        //            [snapShotMaskView removeFromSuperview];
//        //        }
//
//        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//
//        weakSelf.frame = originalFrame;
//        weakSelf.scrollView.contentOffset = originalOffset;
//
//        completionHandler(snapshotImage);
//    }];
//}

- (void)takeScreenshotInRect:(CGRect)rect withCompletion:(void (^_Nullable)(UIImage *_Nullable image))completionHandler {
    WKWebView *webView = self;
    
    UIView *snapshotView = [webView snapshotViewAfterScreenUpdates:YES];
    snapshotView.frame = webView.frame;
    [webView.superview addSubview:snapshotView];
    
    CGPoint currentOffset = webView.scrollView.contentOffset;
    CGRect currentFrame = webView.frame;
    UIView *currentSuperView = webView.superview;
    NSUInteger currentIndex = [webView.superview.subviews indexOfObject:webView];
    
    UIView *containerView = [[UIView alloc] initWithFrame:webView.bounds];
    [webView removeFromSuperview];
    [containerView addSubview:webView];
    
    CGSize totalSize = webView.scrollView.contentSize;
    NSInteger page = ceil(totalSize.height / containerView.bounds.size.height);
    
    webView.scrollView.contentOffset = CGPointZero;
    webView.frame = CGRectMake(0, 0, containerView.bounds.size.width, webView.scrollView.contentSize.height);
    
    UIGraphicsBeginImageContextWithOptions(totalSize, YES, UIScreen.mainScreen.scale);
    [self drawContentPage:containerView webView:webView index:0 maxIndex:page completion:^{
        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [webView removeFromSuperview];
        [currentSuperView insertSubview:webView atIndex:currentIndex];
        webView.frame = currentFrame;
        webView.scrollView.contentOffset = currentOffset;
        
        [snapshotView removeFromSuperview];
        
        completionHandler(snapshotImage);
    }];
}

- (void)drawContentPage:(UIView *)targetView webView:(WKWebView *)webView index:(NSInteger)index maxIndex:(NSInteger)maxIndex completion:(dispatch_block_t)completion {
    CGRect splitFrame = CGRectMake(0, index * CGRectGetHeight(targetView.bounds), targetView.bounds.size.width, targetView.frame.size.height);
    CGRect myFrame = webView.frame;
    myFrame.origin.y = -(index * targetView.frame.size.height);
    webView.frame = myFrame;
    
    #define DELAY_TIME_DRAW 0.1
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DELAY_TIME_DRAW * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [targetView drawViewHierarchyInRect:splitFrame afterScreenUpdates:YES];
        
        if (index < maxIndex) {
            [self drawContentPage:targetView webView:webView index:index + 1 maxIndex:maxIndex completion:completion];
        } else {
            completion();
        }
    });
}

#pragma mark - Plane 3

- (void)takeSnapshotInRect:(CGRect)rect completionHandler:(void (^)(UIImage * _Nullable snapshotImage, NSError * _Nullable error))completionHandler {
    if (!completionHandler) return;
    
//    if (@available(iOS 11.0, *)) {
//        WKSnapshotConfiguration *configuration = [WKSnapshotConfiguration.alloc init];
//        configuration.rect = rect;
//        [self takeSnapshotWithConfiguration:configuration completionHandler:completionHandler];
//    } else {
        CGRect originalBounds = self.bounds;
        self.bounds = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
        [self setNeedsLayout];
        
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentSize.height)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.bounds = originalBounds;
        [self setNeedsLayout];
        
        completionHandler(snapshotImage, nil);
    });
//    }
}

#pragma mark - Helper Methods


@end
