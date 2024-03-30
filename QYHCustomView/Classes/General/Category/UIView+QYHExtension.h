//
//  UIView+QYHExtension.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/13.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QYHAdaptScreenWidthType) {
    QYHAdaptScreenWidthTypeConstraint = 1<<0, /**< 对约束的constant等比例 */
    QYHAdaptScreenWidthTypeFontSize = 1<<1, /**< 对字体等比例 */
    QYHAdaptScreenWidthTypeCornerRadius = 1<<2, /**< 对圆角等比例 */
    QYHAdaptScreenWidthTypeAll = 1<<3, /**< 对现有支持的属性等比例 */
};

@interface UIView (QYHExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 遍历当前view对象的subviews和constraints，对目标进行等比例换算
 
 @param type 想要和基准屏幕等比例换算的属性类型
 @param exceptViews 需要对哪些类进行例外
 */
- (void)adaptScreenWidthWithType:(QYHAdaptScreenWidthType)type
                     exceptViews:(NSArray<Class> *)exceptViews;
@end

NS_ASSUME_NONNULL_END
