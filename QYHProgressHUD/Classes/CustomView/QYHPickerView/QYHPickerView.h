//
//  QYHPickerView.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,PickerType) {
    PickerNeedRequestType  = 1,//需要请求
};

@protocol QYHPickerViewDelegate <NSObject>
@optional
- (void)confirmPicker:(NSMutableDictionary *)dict rowDict:(NSMutableDictionary *)rowDict;
- (void)removeFromSuperView;
- (void)pickerDidSelectRow:(NSInteger)row atComponent:(NSInteger)component;
@end

@interface QYHPickerView : UIView
@property (nonatomic, assign) CGFloat labelSize;
@property (nonatomic, assign) NSInteger components;
@property (nonatomic, strong) NSMutableDictionary *datasDict;
@property (nonatomic, assign) CGFloat componentWidth;
@property (nonatomic, assign) PickerType type;
@property (nonatomic, weak) id<QYHPickerViewDelegate>delegate;

- (void)creatPickerView;
- (void)reloadPickerViewAtIndex:(NSInteger)component;
- (void)pickerViewSelectIndex:(NSInteger)index atComponent:(NSInteger)component;
@end

NS_ASSUME_NONNULL_END
