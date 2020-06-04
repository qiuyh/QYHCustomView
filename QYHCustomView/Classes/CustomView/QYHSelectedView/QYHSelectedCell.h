//
//  QYHSelectedCell.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYHSelectedCell : UITableViewCell
@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign, getter=isSeltected) BOOL seltected;
@property(nonatomic, assign, getter=isShowLine) BOOL showLine;
@property(nonatomic, strong) NSString *iconNamed;
@property(nonatomic, assign) CGFloat fontsize;
@property(nonatomic, assign) NSTextAlignment textAlignment;
@property(nullable, nonatomic, copy) UIColor *textColor;
@property(nullable, nonatomic, copy) UIColor *bgColor;
@property(nullable, nonatomic, copy) UIColor *selectedTextColor;
@property(nullable, nonatomic, copy) UIColor *selectedBgColor;
@property(nullable, nonatomic, copy) UIColor *lineColor;
@property(nonatomic, assign) CGSize iconImageViewSize;
@end

NS_ASSUME_NONNULL_END
