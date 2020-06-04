//
//  NSObject+QYHExtension.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (QYHExtension)
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC;

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 *  param flowDirection   流动的方向  0为不流动，1.为顺，2为逆
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView
                          lineLength:(int)lineLength
                         lineSpacing:(int)lineSpacing
                           lineColor:(UIColor *)lineColor
                       lineDirection:(BOOL)isHorizonal
                       flowDirection:(NSInteger)flowDirection;

// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor;

@end

NS_ASSUME_NONNULL_END
