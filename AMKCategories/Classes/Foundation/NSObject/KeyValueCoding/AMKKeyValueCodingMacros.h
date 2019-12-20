//
//  AMKKeyValueCodingMacros.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/12/20.
//
//  参考：https://github.com/ReactiveCocoa/ReactiveObjC/blob/master/ReactiveObjC/extobjc/EXTKeyValueCoding.h
//

#ifndef AMKKeyValueCodingMacros_h
#define AMKKeyValueCodingMacros_h

#import <Foundation/Foundation.h>
#import "AMKMetamacros.h"

/**
 * \@amk_keypath allows compile-time verification of key paths. Given a real object
 * receiver and key path:
 *
 * @code
 
 NSString *UTF8StringPath = @amk_keypath(str.lowercaseString.UTF8String);
 // => @"lowercaseString.UTF8String"
 
 NSString *versionPath = @amk_keypath(NSObject, version);
 // => @"version"
 
 NSString *lowercaseStringPath = @amk_keypath(NSString.new, lowercaseString);
 // => @"lowercaseString"
 
 * @endcode
 *
 * ... the macro returns an \c NSString containing all but the first path
 * component or argument (e.g., @"lowercaseString.UTF8String", @"version").
 *
 * In addition to simply creating a key path, this macro ensures that the key
 * path is valid at compile-time (causing a syntax error if not), and supports
 * refactoring, such that changing the name of the property will also update any
 * uses of \@amk_keypath.
 */
#define amk_keypath(...) \
amk_metamacro_if_eq(1, amk_metamacro_argcount(__VA_ARGS__))(amk_keypath1(__VA_ARGS__))(amk_keypath2(__VA_ARGS__))

#define amk_keypath1(PATH) \
(((void)(NO && ((void)PATH, NO)), strchr(# PATH, '.') + 1))

#define amk_keypath2(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), # PATH))

/**
 * \@amk_collectionKeypath allows compile-time verification of key paths across collections NSArray/NSSet etc. Given a real object
 * receiver, collection object receiver and related amk_keypaths:
 *
 * @code
 
 NSString *employessFirstNamePath = @amk_collectionKeypath(department.employees, Employee.new, firstName)
 // => @"employees.firstName"
 
 NSString *employessFirstNamePath = @amk_collectionKeypath(Department.new, employees, Employee.new, firstName)
 // => @"employees.firstName"
 
 * @endcode
 *
 */
#define amk_collectionKeypath(...) \
amk_metamacro_if_eq(3, amk_metamacro_argcount(__VA_ARGS__))(amk_collectionKeypath3(__VA_ARGS__))(amk_collectionKeypath4(__VA_ARGS__))

#define amk_collectionKeypath3(PATH, COLLECTION_OBJECT, COLLECTION_PATH) ([[NSString stringWithFormat:@"%s.%s",amk_keypath(PATH), amk_keypath(COLLECTION_OBJECT, COLLECTION_PATH)] UTF8String])

#define amk_collectionKeypath4(OBJ, PATH, COLLECTION_OBJECT, COLLECTION_PATH) ([[NSString stringWithFormat:@"%s.%s",amk_keypath(OBJ, PATH), amk_keypath(COLLECTION_OBJECT, COLLECTION_PATH)] UTF8String])

#endif /* AMKKeyValueCodingMacros_h */
