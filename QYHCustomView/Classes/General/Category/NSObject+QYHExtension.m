//
//  NSObject+QYHExtension.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "NSObject+QYHExtension.h"

@implementation NSObject (QYHExtension)
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    //寻找当前显示的window    （若项目只有一个window  可省略）
    if (window.windowLevel != UIWindowLevelNormal)  {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)  {
            
            if (tmpWin.windowLevel == UIWindowLevelNormal)  {
                
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *root = window.rootViewController;
    
    while (root) {
        if ([root isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)root;
            root = tab.selectedViewController;
        }
        else if([root isKindOfClass:[UINavigationController class]]) {
            root = root.childViewControllers.lastObject;
        }
        else if (root.presentedViewController){
            root = root.presentedViewController;
        }
        else{
            result = root;
            root = nil;
        }
    }
    return result;
}


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
                       flowDirection:(NSInteger)flowDirection{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    if (isHorizonal) {
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
        
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
    
    if (flowDirection != 0){
        
        BOOL isFlowDirectionOne = flowDirection == 1;
        
        CGFloat fromValue = isFlowDirectionOne ? 300.f : 0.f;
        
        CGFloat endValue = isFlowDirectionOne ? 0.f : 300.f;
        
        CABasicAnimation *dashAnimation = [CABasicAnimation
                                           animationWithKeyPath:@"lineDashPhase"];
        [dashAnimation setFromValue:[NSNumber numberWithFloat:fromValue]];
        [dashAnimation setToValue:[NSNumber numberWithFloat:endValue]];
        [dashAnimation setDuration:20.f];
        dashAnimation.cumulative = YES;
        [dashAnimation setRepeatCount:MAXFLOAT];
        dashAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [shapeLayer addAnimation:dashAnimation forKey:@"linePhase"];
    }
}

// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 3;
}

@end
