//
//  QYHBubbleView.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "QYHBubbleView.h"

@implementation QYHBubbleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 初始化
        _bubbleType = QYHBubbleTypeTopLeft;
        _cornerRadius = 6.0;
        _margin = 10.0;
        _arrowHeight = 10.0;
        _arrowWidth = 16.0;
        _lineWidth = 1.0;
        _fillColor = [UIColor whiteColor];
        _strokeColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    }
    return self;
}

// 绘制
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, self.lineWidth); // 画笔宽度
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor); // 画笔颜色
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor); // 填充颜色
    [self getDrawPath:context];
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)getDrawPath:(CGContextRef)context{
    CGRect rrect = self.bounds;
    CGFloat radius = self.cornerRadius; // 圆角
    CGFloat arrowH = self.arrowHeight; // 箭头高度
    CGFloat arrowW = self.arrowWidth; // 箭头宽度
    CGFloat margin = self.margin; // 边距
    CGFloat arrX = 0; // 画箭头的起始位置x
    CGFloat arrY = 0; // 画箭头的起始位置y
    CGFloat maxX = CGRectGetMaxX(rrect);
    CGFloat maxY = CGRectGetMaxY(rrect);
    
    switch (self.bubbleType)
    {
        case QYHBubbleTypeTopLeft:
        case QYHBubbleTypeTopMiddle:
        case QYHBubbleTypeTopRight:
        {
            arrY = arrowH;
            if (self.bubbleType == QYHBubbleTypeTopLeft) {
                arrX = margin;
            } else if (self.bubbleType == QYHBubbleTypeTopMiddle) {
                arrX = CGRectGetMidX(rrect) - arrowW / 2.0;
            } else {
                arrX = CGRectGetWidth(rrect) - margin - arrowW;
            }
            
            // 画三角
            CGContextMoveToPoint(context, arrX, arrY);
            CGContextAddLineToPoint(context, arrX + arrowW / 2.0, 0);
            CGContextAddLineToPoint(context, arrX + arrowW, arrY);
            // 画剩余的五条直线
            CGContextAddArcToPoint(context, arrX + arrowW, arrY, maxX, arrY, radius); // →
            CGContextAddArcToPoint(context, maxX, arrY, maxX, maxY, radius); // ↓
            CGContextAddArcToPoint(context, maxX, maxY, 0, maxY, radius); // ←
            CGContextAddArcToPoint(context, 0, maxY, 0, arrY, radius); // ↑
            CGContextAddArcToPoint(context, 0, arrY, arrX, arrY, radius); // →
            CGContextClosePath(context);
            
            break;
        }
        case QYHBubbleTypeLeftTop:
        case QYHBubbleTypeLeftMiddle:
        case QYHBubbleTypeLeftBottom:
        {
            arrX = arrowH;
            if (self.bubbleType == QYHBubbleTypeLeftTop) {
                arrY = margin;
            } else if (self.bubbleType == QYHBubbleTypeLeftMiddle) {
                arrY = CGRectGetMidY(rrect) - arrowW / 2.0;
            } else {
                arrY = CGRectGetHeight(rrect) - margin - arrowW;
            }
            // 画三角
            CGContextMoveToPoint(context, arrX, arrY);
            CGContextAddLineToPoint(context, 0, arrY + arrowW / 2.0);
            CGContextAddLineToPoint(context, arrX, arrY + arrowW);
            // 画剩余的五条直线
            CGContextAddArcToPoint(context, arrX, arrY + arrowW, arrX, maxY, radius); // ↓
            CGContextAddArcToPoint(context, arrX, maxY, maxX, maxY, radius); // →
            CGContextAddArcToPoint(context, maxX, maxY, maxX, 0, radius); // ↑
            CGContextAddArcToPoint(context, maxX, 0, arrX, 0, radius); // ←
            CGContextAddArcToPoint(context, arrX, 0, arrX, arrY, radius); // ↓
            CGContextClosePath(context);
            
            break;
        }
        case QYHBubbleTypeBottomLeft:
        case QYHBubbleTypeBottomMiddle:
        case QYHBubbleTypeBottomRight:
        {
            arrY = CGRectGetHeight(rrect) - arrowH;
            if (self.bubbleType == QYHBubbleTypeBottomLeft) {
                arrX = margin;
            } else if (self.bubbleType == QYHBubbleTypeBottomMiddle) {
                arrX = CGRectGetMidX(rrect) - arrowW / 2.0;
            } else {
                arrX = CGRectGetWidth(rrect) - margin - arrowW;
            }
            // 画三角
            CGContextMoveToPoint(context, arrX, arrY);
            CGContextAddLineToPoint(context, arrX + arrowW / 2.0, maxY);
            CGContextAddLineToPoint(context, arrX + arrowW, arrY);
            // 画剩余的五条直线
            CGContextAddArcToPoint(context, arrX + arrowW, arrY, maxX, arrY, radius); // →
            CGContextAddArcToPoint(context, maxX, arrY, maxX, 0, radius); // ↑
            CGContextAddArcToPoint(context, maxX, 0, 0, 0, radius); // ←
            CGContextAddArcToPoint(context, 0, 0, 0, arrY, radius); // ↓
            CGContextAddArcToPoint(context, 0, arrY, arrX, arrY, radius); // →
            CGContextClosePath(context);
            break;
        }
        case QYHBubbleTypeRightTop:
        case QYHBubbleTypeRightMiddle:
        case QYHBubbleTypeRightBottom:
        {
            arrX = CGRectGetWidth(rrect) - arrowH;
            if (self.bubbleType == QYHBubbleTypeRightTop) {
                arrY = margin;
            } else if (self.bubbleType == QYHBubbleTypeRightMiddle) {
                arrY = CGRectGetMidY(rrect) - arrowW / 2.0;
            } else {
                arrY = CGRectGetHeight(rrect) - margin - arrowW;
            }
            // 画三角
            CGContextMoveToPoint(context, arrX, arrY);
            CGContextAddLineToPoint(context, maxX, arrY + arrowW / 2.0);
            CGContextAddLineToPoint(context, arrX, arrY + arrowW);
            // 画剩余的五条直线
            CGContextAddArcToPoint(context, arrX, arrY + arrowW, arrX, maxY, radius); // ↓
            CGContextAddArcToPoint(context, arrX, maxY, 0, maxY, radius); // ←
            CGContextAddArcToPoint(context, 0, maxY, 0, 0, radius); // ↑
            CGContextAddArcToPoint(context, 0, 0, arrX, 0, radius); // →
            CGContextAddArcToPoint(context, arrX, 0, arrX, arrY, radius); // ↓
            CGContextClosePath(context);
            break;
        }
        default:
            break;
    }
}

@end
