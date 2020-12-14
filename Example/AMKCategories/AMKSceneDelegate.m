//
//  AMKSceneDelegate.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/12/11.
//

#import "AMKSceneDelegate.h"

@interface AMKSceneDelegate ()

@end

@implementation AMKSceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
}


- (void)sceneDidDisconnect:(UIScene *)scene API_AVAILABLE(ios(13.0)) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene API_AVAILABLE(ios(13.0)) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene API_AVAILABLE(ios(13.0)) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene API_AVAILABLE(ios(13.0)) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene API_AVAILABLE(ios(13.0)) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

#pragma mark - System Integration

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts API_AVAILABLE(ios(13.0)) {
    UIOpenURLContext * context = URLContexts.allObjects.firstObject;
    NSLog(@"%@", context.URL);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.8];
    hud.bezelView.layer.shadowColor = [UIColor colorWithRed:102/255.0 green:108/255.0 blue:125/255.0 alpha:1/1.0].CGColor;
    hud.bezelView.layer.shadowOffset = CGSizeMake(0, 5);
    hud.bezelView.layer.shadowOpacity = 0.2;
    hud.bezelView.layer.shadowRadius = 10;
    hud.bezelView.layer.masksToBounds = NO;
    hud.bezelView.clipsToBounds = NO;
    hud.label.text = [context.URL.query queryDictionaryUsingEncoding:NSUTF8StringEncoding][@"title"]?:@"外部调起";
    hud.label.textColor = [UIColor whiteColor];
    hud.detailsLabel.text = context.URL.absoluteString?:@"";
    hud.detailsLabel.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:3];
}

@end

@implementation NSString (Query)

- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}


@end
