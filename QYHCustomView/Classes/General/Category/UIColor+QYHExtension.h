//
//  UIColor+QYHExtension.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/13.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IHGradientChangeDirection) {
    IHGradientChangeDirectionLevel,
    IHGradientChangeDirectionVertical,
    IHGradientChangeDirectionUpwardDiagonalLine,
    IHGradientChangeDirectionDownDiagonalLine,
};

@interface UIColor (QYHExtension)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)colorGradientChangeWithSize:(CGSize)size
                               direction:(IHGradientChangeDirection)direction
                              startColor:(UIColor *)startcolor
                                endColor:(UIColor *)endColor;
@end

NS_ASSUME_NONNULL_END
