//
//  NSDictionary+QYHExtension.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/13.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (QYHExtension)
/**
 * 分离出带参数URL的参数
 */
+(NSDictionary *)getParmWithURL:(NSString *)URLString;
/**
* json字符串转字典
*/
+ (NSDictionary*)initWithJsonString:(NSString*)json;
/**
* 字典转json字符串
*/
- (NSString*)jsonString;

@end

NS_ASSUME_NONNULL_END
