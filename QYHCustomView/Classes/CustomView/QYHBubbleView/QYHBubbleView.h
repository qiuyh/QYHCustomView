//
//  QYHBubbleView.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QYHBubbleType) {
    QYHBubbleTypeTopLeft = 0,    // 箭头顶部左边
    QYHBubbleTypeTopMiddle,      // 箭头顶部中间
    QYHBubbleTypeTopRight,       // 箭头顶部右边
    QYHBubbleTypeLeftTop,        // 箭头左边顶部
    QYHBubbleTypeLeftMiddle,     // 箭头左边中间
    QYHBubbleTypeLeftBottom,     // 箭头左边底部
    QYHBubbleTypeBottomLeft,     // 箭头底部左边
    QYHBubbleTypeBottomMiddle,   // 箭头底部中间
    QYHBubbleTypeBottomRight,    // 箭头底部右边
    QYHBubbleTypeRightTop,       // 箭头右边顶部
    QYHBubbleTypeRightMiddle,    // 箭头右边中间
    QYHBubbleTypeRightBottom,    // 箭头右边底部
};

@interface QYHBubbleView : UIView

// 气泡类型
@property(nonatomic, assign) QYHBubbleType bubbleType;
// 边距(箭头处于中间时，该字段无用)
@property(nonatomic, assign) CGFloat margin;
// 箭头高度
@property(nonatomic, assign) CGFloat arrowHeight;
// 箭头宽度
@property(nonatomic, assign) CGFloat arrowWidth;
// 圆角半径
@property(nonatomic, assign) CGFloat cornerRadius;
// 边线宽度
@property(nonatomic, assign) CGFloat lineWidth;
// 边线颜色
@property(nonatomic, strong) UIColor * strokeColor;
// 填充颜色
@property(nonatomic, strong) UIColor * fillColor;

@end

NS_ASSUME_NONNULL_END
