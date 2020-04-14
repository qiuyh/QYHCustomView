//
//  NSMutableAttributedString+QYHExtension.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (QYHExtension)
//添加NSMutableAttributedString
+ (NSMutableAttributedString*)attributedString:(NSString *)allString
                                   bigFontName:(NSString *)bigFontName
                                   bigFontSize:(CGFloat)bigFontSize
                                      bigColor:(UIColor *)bigColor
                                   smallString:(nullable NSString *)smallString
                                 smallFontName:(nullable NSString *)smallFontName
                                 smallFontSize:(CGFloat)smallFontSize
                                    smallColor:(nullable UIColor *)smallColor;
@end

NS_ASSUME_NONNULL_END
