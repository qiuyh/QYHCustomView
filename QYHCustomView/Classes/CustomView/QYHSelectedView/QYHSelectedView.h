//
//  QYHSelectedView.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYHBubbleView.h"

/**
 点击回调，index为cell的row，index为1000时，点击cell外的事件，（其他按钮或者隐藏收起）
 */
typedef void(^CompleteCallBack)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface QYHSelectedView : UITableView
/**
 当前view的边框颜色
 */
@property(nullable, nonatomic, copy) UIColor *borderColor;
/**
 当前view的cornerRadius
 */
@property(nonatomic, assign) CGFloat cornerRadius;
/**
当前view的父控件的背景颜色
*/
@property(nullable, nonatomic,copy) UIColor *bgBackgroundColor;
/**
 cell的高度
 */
@property(nonatomic, assign) CGFloat cellHeight;
/**
 cell底部是否显示线条
 */
@property(nonatomic, assign, getter=isShowCellLine) BOOL showCellLine;
/**
 cell底部线条颜色
 */
@property(nullable, nonatomic, copy) UIColor *lineColor;
/**
 cell的label对齐方式
 */
@property(nonatomic, assign) NSTextAlignment textAlignment;
/**
cell的label的fontsize
*/
@property(nonatomic, assign) CGFloat fontsize;
/**
 cell的label颜色
 */
@property(nullable, nonatomic, copy) UIColor *textColor;
/**
cell选中label颜色
*/
@property(nullable, nonatomic, copy) UIColor *selectedTextColor;
/**
cell选中的背景颜色
*/
@property(nullable, nonatomic, copy) UIColor *selectedBgColor;
/**
cell的左侧是否需要icon，需要的image
*/
@property(nullable, nonatomic, strong) NSArray *imageNamedArray;
/**
是否需要气泡
*/
@property(nonatomic, assign, getter=isShowBubble) BOOL showBubble;
/**
 气泡类型
 */
@property(nonatomic, assign) QYHBubbleType bubbleType;
/**
 当前选中的index, 1000为底部点击事件
 */
@property(nonatomic, assign) NSInteger currentIndex;
/**
 是否显示底部button
 */
@property(nonatomic, assign, getter=isShowAddSiteButton) BOOL showAddSiteButton;
/**
底部button的icon
*/
@property(nullable, nonatomic, strong) NSString *addSiteButtonImageNamed;
/**
底部button的title
*/
@property(nullable, nonatomic, strong) NSString *addSiteButtonTitle;
/**
是否显示底部阴影部分，当前view在上面
*/
@property(nonatomic, assign, getter=isShowAddBottomView) BOOL showAddBottomView;
/**
 有BubbleView的时候，当前选中的bubbleViewfillColorIndex需要BubbleView开口处fillColor和选择cell的背景颜色一样时用到
 */
@property(nonatomic, assign) NSInteger bubbleViewfillColorIndex;

- (void)showWithDataArray:(NSArray *)dataArray callBack:(nonnull CompleteCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
