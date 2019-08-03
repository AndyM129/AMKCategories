//
//  NSDictionary+AMKObjectForKey.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (AMKObjectForKey)

- (BOOL)amk_boolForKey:(id _Nullable)key;
- (BOOL)amk_boolForKeyPath:(NSString *_Nullable)keyPath;
- (BOOL)amk_boolForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (float)amk_floatForKey:(id _Nullable)key;
- (float)amk_floatForKeyPath:(NSString *_Nullable)keyPath;
- (float)amk_floatForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (double)amk_doubleForKey:(id _Nullable)key;
- (double)amk_doubleForKeyPath:(NSString *_Nullable)keyPath;
- (double)amk_doubleForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (NSInteger)amk_integerForKey:(id _Nullable)key;
- (NSInteger)amk_integerForKeyPath:(NSString *_Nullable)keyPath;
- (NSInteger)amk_integerForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (CGPoint)amk_CGPointForKey:(id _Nullable)key;
- (CGPoint)amk_CGPointForKeyPath:(NSString *_Nullable)keyPath;
- (CGPoint)amk_CGPointForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (CGVector)amk_CGVectorForKey:(id _Nullable)key;
- (CGVector)amk_CGVectorForKeyPath:(NSString *_Nullable)keyPath;
- (CGVector)amk_CGVectorForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (CGSize)amk_CGSizeForKey:(id _Nullable)key;
- (CGSize)amk_CGSizeForKeyPath:(NSString *_Nullable)keyPath;
- (CGSize)amk_CGSizeForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (CGRect)amk_CGRectForKey:(id _Nullable)key;
- (CGRect)amk_CGRectForKeyPath:(NSString *_Nullable)keyPath;
- (CGRect)amk_CGRectForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (CGAffineTransform)amk_CGAffineTransformForKey:(id _Nullable)key;
- (CGAffineTransform)amk_CGAffineTransformForKeyPath:(NSString *_Nullable)keyPath;
- (CGAffineTransform)amk_CGAffineTransformForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (UIEdgeInsets)amk_UIEdgeInsetsForKey:(id _Nullable)key;
- (UIEdgeInsets)amk_UIEdgeInsetsForKeyPath:(NSString *_Nullable)keyPath;
- (UIEdgeInsets)amk_UIEdgeInsetsForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (NSDirectionalEdgeInsets)amk_NSDirectionalEdgeInsetsForKey:(id _Nullable)key API_AVAILABLE(ios(11.0),tvos(11.0),watchos(4.0));
- (NSDirectionalEdgeInsets)amk_NSDirectionalEdgeInsetsForKeyPath:(NSString *_Nullable)keyPath API_AVAILABLE(ios(11.0),tvos(11.0),watchos(4.0));
- (NSDirectionalEdgeInsets)amk_NSDirectionalEdgeInsetsForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator API_AVAILABLE(ios(11.0),tvos(11.0),watchos(4.0));

- (UIOffset)amk_UIOffsetForKey:(id _Nullable)key;
- (UIOffset)amk_UIOffsetForKeyPath:(NSString *_Nullable)keyPath;
- (UIOffset)amk_UIOffsetForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (NSData *_Nullable)amk_dataForKey:(id _Nullable)key;
- (NSData *_Nullable)amk_dataForKeyPath:(NSString *_Nullable)keyPath;
- (NSData *_Nullable)amk_dataForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (NSString *_Nullable)amk_stringForKey:(id _Nullable)key;
- (NSString *_Nullable)amk_stringForKeyPath:(NSString *_Nullable)keyPath;
- (NSString *_Nullable)amk_stringForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (NSURL *_Nullable)amk_URLForKey:(id _Nullable)key;
- (NSURL *_Nullable)amk_URLForKeyPath:(NSString *_Nullable)keyPath;
- (NSURL *_Nullable)amk_URLForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (NSDate *_Nullable)amk_dateForKey:(id _Nullable)key;
- (NSDate *_Nullable)amk_dateForKeyPath:(NSString *_Nullable)keyPath;
- (NSDate *_Nullable)amk_dateForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (NSArray *_Nullable)amk_arrayForKey:(id _Nullable)key;
- (NSArray *_Nullable)amk_arrayForKeyPath:(NSString *_Nullable)keyPath;
- (NSArray *_Nullable)amk_arrayForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (NSDictionary *_Nullable)amk_dictionaryForKey:(id _Nullable)key;
- (NSDictionary *_Nullable)amk_dictionaryForKeyPath:(NSString *_Nullable)keyPath;
- (NSDictionary *_Nullable)amk_dictionaryForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator;

- (id _Nullable)amk_objectForKey:(id _Nullable)key;
- (id _Nullable)amk_objectForKeyPath:(NSString * _Nullable)keyPath;
- (id _Nullable)amk_objectForKeyPath:(NSString * _Nullable)keyPath separatingWithString:(NSString * _Nullable)separator;

@end

NS_ASSUME_NONNULL_END


