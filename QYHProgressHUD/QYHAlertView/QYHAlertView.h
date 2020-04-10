//
//  QYHAlertView.h
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/7.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYHAlertView : UIView
/**
 可以自由更改以下控件的属性
 */
@property (nonatomic, strong) UIColor *dimBackgroundColor;//背景颜色
@property (nonatomic, strong) UIColor *alertViewColor;//alertView颜色
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) UIView *vLineView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;

/**
 相当于alertView,带title，message
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
        actionCancelWithTitle:(nullable NSString *)cancelTitle
       actionConfirmWithTitle:(nullable NSString *)confirmTitle
                      handler:(void (^ __nullable)(NSInteger index))handler;

/**
 相当于alertView，类方法,带title，message
 */
+ (instancetype)alertViewWithTitle:(nullable NSString *)title
                           message:(nullable NSString *)message
             actionCancelWithTitle:(nullable NSString *)cancelTitle
            actionConfirmWithTitle:(nullable NSString *)confirmTitle
                           handler:(void (^ __nullable)(NSInteger index))handler;
/**
 带icon，title,message
 */
- (instancetype)initWithIcon:(nullable NSString *)icon
                       title:(nullable NSString *)title
                     message:(nullable NSString *)message
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler;
/**
 类方法, 带icon，title,message
 */
+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                            title:(nullable NSString *)title
                          message:(nullable NSString *)message
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler;
/**
 带icon，title
 */
- (instancetype)initWithIcon:(nullable NSString *)icon
                       title:(nullable NSString *)title
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler;
/**
 类方法, 带icon，title
 */
+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                            title:(nullable NSString *)title
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler;
/**
 带icon，message；
 */
- (instancetype)initWithIcon:(nullable NSString *)icon
                     message:(nullable NSString *)message
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler;

/**
 类方法, 带icon，message；
 */
+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                          message:(nullable NSString *)message
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler;

/**
 带icon,title,textField,textField为YES时需要手动调用hideAnimated隐藏；
 */
- (instancetype)initWithIcon:(nullable NSString *)icon
                       title:(nullable NSString *)title
                   textField:(BOOL)textField
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler;

/**
 类方法, 带icon,title,textField,textFieldd为YES时需要手动调用hideAnimated隐藏；
 */
+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                            title:(nullable NSString *)title
                        textField:(BOOL)textField
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler;

/**
 带icon,message,textField,textField为YES时需要手动调用hideAnimated隐藏；
 */
- (instancetype)initWithIcon:(nullable NSString *)icon
                     message:(nullable NSString *)message
                   textField:(BOOL)textField
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler;

/**
 类方法, 带icon,message,textField,textField为YES时需要手动调用hideAnimated隐藏；
 */
+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                          message:(nullable NSString *)message
                        textField:(BOOL)textField
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler;

/**
 带message,textField,textField为YES时需要手动调用hideAnimated隐藏；
 */
- (instancetype)initWithMessage:(nullable NSString *)message
                      textField:(BOOL)textField
          actionCancelWithTitle:(nullable NSString *)cancelTitle
         actionConfirmWithTitle:(nullable NSString *)confirmTitle
                        handler:(void (^ __nullable)(NSInteger index))handler;

/**
 类方法, 带message,textField,textFieldd为YES时需要手动调用hideAnimated隐藏；
 */
+ (instancetype)alertViewWithMessage:(nullable NSString *)message
                           textField:(BOOL)textField
               actionCancelWithTitle:(nullable NSString *)cancelTitle
              actionConfirmWithTitle:(nullable NSString *)confirmTitle
                             handler:(void (^ __nullable)(NSInteger index))handler;
/**
 带title,textField,textField为YES时需要手动调用hideAnimated隐藏；
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                    textField:(BOOL)textField
        actionCancelWithTitle:(nullable NSString *)cancelTitle
       actionConfirmWithTitle:(nullable NSString *)confirmTitle
                      handler:(void (^ __nullable)(NSInteger index))handler;

/**
 类方法, 带title,textField,textField为YES时需要手动调用hideAnimated隐藏；
 */
+ (instancetype)alertViewWithTitle:(nullable NSString *)title
                         textField:(BOOL)textField
             actionCancelWithTitle:(nullable NSString *)cancelTitle
            actionConfirmWithTitle:(nullable NSString *)confirmTitle
                           handler:(void (^ __nullable)(NSInteger index))handler;
/**
 带title,message,textField,textField为YES时需要手动调用hideAnimated隐藏；
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                    textField:(BOOL)textField
        actionCancelWithTitle:(nullable NSString *)cancelTitle
       actionConfirmWithTitle:(nullable NSString *)confirmTitle
                      handler:(void (^ __nullable)(NSInteger index))handler;

/**
 类方法, 带title,message,textField,textField为YES时需要手动调用hideAnimated隐藏；
 */
+ (instancetype)alertViewWithTitle:(nullable NSString *)title
                           message:(nullable NSString *)message
                         textField:(BOOL)textField
             actionCancelWithTitle:(nullable NSString *)cancelTitle
            actionConfirmWithTitle:(nullable NSString *)confirmTitle
                           handler:(void (^ __nullable)(NSInteger index))handler;

/**
 带icon,title,message,textField,textField为YES时需要手动调用hideAnimated隐藏；
 */
- (instancetype)initWithIcon:(nullable NSString *)icon
                       title:(nullable NSString *)title
                     message:(nullable NSString *)message
                   textField:(BOOL)textField
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler;

/**
 类方法, 带icon,title,message,textField,textField为YES时需要手动调用hideAnimated隐藏；
 */
+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                            title:(nullable NSString *)title
                          message:(nullable NSString *)message
                        textField:(BOOL)textField
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler;

- (void)hideAnimated:(BOOL)animated;
+ (void)hideAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
