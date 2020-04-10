//
//  QYHProgressHUD.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/3.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "QYHProgressHUD.h"

#define QYHScreen_width [[UIScreen mainScreen] bounds].size.width
#define QYHAdaptionWidth(width) width*QYHScreen_width/375.0

#define titleFont QYHAdaptionWidth(15)

@implementation QYHProgressHUD

/**
带bezelView默认背景颜色的转圈圈
*/
+ (instancetype)showHUDToView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].windows.lastObject;
    return [QYHProgressHUD showHUDAddedTo:view animated:YES];
}
/**
 不带bezelView背景颜色的转圈圈
*/
+ (instancetype)showBgClearColorHUDToView:(nullable UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].windows.lastObject;
    QYHProgressHUD *hud = [QYHProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
    return hud;
}
/**
 吐司提示语，默认字体大小为16
*/
+ (instancetype)showMessage:(NSString *)message toView:(UIView *)view{
    return [self showMessage:message icon:nil toView:view];
}
/**
 吐司提示语
*/
+ (instancetype)showMessage:(NSString *)message toView:(UIView *)view fonSize:(CGFloat)fonSize{
    return [self showMessage:message icon:nil toView:view fonSize:fonSize];
}
/**
 吐司图片
*/
+ (instancetype)showIcon:(nullable NSString *)icon toView:(nullable UIView *)view{
    return [self showMessage:nil icon:icon toView:view];
}
/**
 吐司提示语，图片，默认字体大小为16
*/
+ (instancetype)showMessage:(nullable NSString *)message icon:(nullable NSString *)icon toView:(nullable UIView *)view{
    return [self showMessage:message icon:icon toView:view fonSize:titleFont];
}
/**
 吐司提示语，图片
*/
+ (instancetype)showMessage:(nullable NSString *)message icon:(nullable NSString *)icon toView:(nullable UIView *)view fonSize:(CGFloat)fonSize{
    if (view == nil) view = [UIApplication sharedApplication].windows.lastObject;
    QYHProgressHUD *hud = [QYHProgressHUD showHUDAddedTo:view animated:YES];
    if (message) {
        hud.detailsLabel.text = message;
        hud.detailsLabel.font = [UIFont systemFontOfSize:fonSize];
    }
    
    if (icon == nil) {
        hud.mode = MBProgressHUDModeText;
    }else{
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
        hud.mode = MBProgressHUDModeCustomView;
    }
    
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.5];
    
    return hud;
}
/**
 吐司进度条，默认字体大小为16
*/
+ (instancetype)showProgressHUDMode:(MBProgressHUDMode)progressHUDMode message:(nullable NSString *)message toView:(nullable UIView *)view{
    return [self showProgressHUDMode:progressHUDMode message:message toView:view fonSize:titleFont];
}
/**
 吐司进度条，默认字体大小为16
*/
+ (instancetype)showProgressHUDMode:(MBProgressHUDMode)progressHUDMode message:(nullable NSString *)message toView:(nullable UIView *)view fonSize:(CGFloat)fonSize{
    if (view == nil) view = [UIApplication sharedApplication].windows.lastObject;
    QYHProgressHUD *hud = [QYHProgressHUD showHUDAddedTo:view animated:YES];
    if (message) {
        hud.detailsLabel.text = message;
        hud.detailsLabel.font = [UIFont systemFontOfSize:fonSize];
    }
    
    hud.mode = progressHUDMode;
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}
/**
 自定义view
 */
+ (instancetype)showCustomView:(UIView *)customView toView:(nullable UIView *)view afterDelay:(CGFloat)afterDelay{
    if (view == nil) view = [UIApplication sharedApplication].windows.lastObject;
    //提高view的Content Hugging Priority
//    [customView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    QYHProgressHUD *hud = [QYHProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.bezelView.layer.cornerRadius = customView.layer.cornerRadius;
    hud.margin = 0;
    hud.customView = customView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    hud.removeFromSuperViewOnHide = YES;
    if (afterDelay) {
        [hud hideAnimated:YES afterDelay:afterDelay];
    }
    
    if (customView.frame.size.width) {
        NSNumber *width = @(customView.frame.size.width);
        NSString *hVFL = [NSString stringWithFormat:@"H:[customView(%@)]", width];
        NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hVFL options:kNilOptions metrics:nil views:@{@"customView":customView}];
        [customView addConstraints:hConstraints];
    }
    
    if (customView.frame.size.height) {
        NSNumber *height = @(customView.frame.size.height);
        NSString *vVFL = [NSString stringWithFormat:@"V:[customView(%@)]", height];
        NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vVFL options:kNilOptions metrics:nil views:@{@"customView":customView}];
        [customView addConstraints:vConstraints];
    }
    
    return hud;
}
/**
 设置背景颜色
*/
- (void)setDimBackgroundColor:(UIColor *)dimBackgroundColor{
    _dimBackgroundColor = dimBackgroundColor;
    self.backgroundView.backgroundColor = dimBackgroundColor;
}
/**
 隐藏
*/
+ (BOOL)hideHUDForView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].windows.lastObject;
    return [QYHProgressHUD hideHUDForView:view animated:YES];
}

@end
