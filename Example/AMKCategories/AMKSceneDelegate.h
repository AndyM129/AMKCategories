//
//  AMKSceneDelegate.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/12/11.
//

#import <UIKit/UIKit.h>

@interface AMKSceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (strong, nonatomic) UIWindow * window;

@end


@interface NSString (Query)

- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding;

@end
