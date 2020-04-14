//
//  QYHProgressHUD.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/3.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYHProgressHUD : MBProgressHUD
/**
 背景颜色
*/
@property (nonatomic, strong) UIColor *dimBackgroundColor;
/**
 带bezelView默认背景颜色的转圈圈
 */
+ (instancetype)showHUDToView:(nullable UIView *)view;
/**
 不带bezelView背景颜色的转圈圈
*/
+ (instancetype)showBgClearColorHUDToView:(nullable UIView *)view;
/**
 吐司提示语，默认字体大小为15
*/
+ (instancetype)showMessage:(NSString *)message toView:(nullable UIView *)view;
/**
 吐司提示语
*/
+ (instancetype)showMessage:(NSString *)message toView:(nullable UIView *)view fonSize:(CGFloat)fonSize;
/**
 吐司提示语，图片，默认字体大小为15
*/
+ (instancetype)showMessage:(nullable NSString *)message icon:(nullable NSString *)icon toView:(nullable UIView *)view;
/**
 吐司提示语，图片
*/
+ (instancetype)showMessage:(nullable NSString *)message icon:(nullable NSString *)icon toView:(nullable UIView *)view fonSize:(CGFloat)fonSize;
/**
 吐司图片
*/
+ (instancetype)showIcon:(nullable NSString *)icon toView:(nullable UIView *)view;
/**
 吐司进度条，默认字体大小为15
*/
+ (instancetype)showProgressHUDMode:(MBProgressHUDMode)progressHUDMode message:(nullable NSString *)message toView:(nullable UIView *)view;
/**
 吐司进度条，默认字体大小为15
*/
+ (instancetype)showProgressHUDMode:(MBProgressHUDMode)progressHUDMode message:(nullable NSString *)message toView:(nullable UIView *)view fonSize:(CGFloat)fonSize;
/**
 自定义view
 view需要设置size或者autolayout
*/
+ (instancetype)showCustomView:(UIView *)customView toView:(nullable UIView *)view afterDelay:(CGFloat)afterDelay;
/**
 隐藏
*/
+ (BOOL)hideHUDForView:(nullable UIView *)view;

@end

NS_ASSUME_NONNULL_END
