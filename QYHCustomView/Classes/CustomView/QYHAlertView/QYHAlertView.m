//
//  QYHAlertView.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/7.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "QYHAlertView.h"
#import "QYHProgressHUD.h"
#import "Masonry.h"

#define QYHScreen_width (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define QYHScreen_height (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define QYHAdaptionWidth(width) (width*((QYHScreen_width/375.0>1.8)?1.8:(QYHScreen_width/375.0)))
#define QYHSpace QYHAdaptionWidth(15)

typedef void(^HandlerBlock)(NSInteger index);

@interface QYHAlertView ()
@property (nonatomic, strong) QYHProgressHUD *hud;
@property (nonatomic, copy) HandlerBlock handler;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, assign, getter=isKeyBoardShow) BOOL keyBoardShow;
@end

@implementation QYHAlertView

+ (QYHAlertView *)shareInstance{
    static QYHAlertView *alertView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertView = [[QYHAlertView alloc] init];
    });
    
    return alertView;
}

- (void)setDimBackgroundColor:(UIColor *)dimBackgroundColor{
    _dimBackgroundColor = dimBackgroundColor;
    self.hud.dimBackgroundColor = dimBackgroundColor;
}

- (void)setAlertViewColor:(UIColor *)alertViewColor{
    _alertViewColor = alertViewColor;
    self.customView.backgroundColor = alertViewColor;
}

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
        actionCancelWithTitle:(nullable NSString *)cancelTitle
       actionConfirmWithTitle:(nullable NSString *)confirmTitle
                      handler:(void (^ __nullable)(NSInteger index))handler{
    
    self = [[self class] shareInstance];
    if (self) {
        [self alertViewWithTitle:title message:message actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(nullable NSString *)title
                           message:(nullable NSString *)message
             actionCancelWithTitle:(nullable NSString *)cancelTitle
            actionConfirmWithTitle:(nullable NSString *)confirmTitle
                           handler:(void (^ __nullable)(NSInteger index))handler{
    
    [[self shareInstance] alertViewWithTitle:title message:message actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    
    return [self shareInstance];
}

- (instancetype)initWithIcon:(nullable NSString *)icon
                       title:(nullable NSString *)title
                     message:(nullable NSString *)message
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler{
    
    self = [[self class] shareInstance];
    if (self) {
        [self alertViewWithIcon:icon title:title message:message textField:NO actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    }
    return self;
}

+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                            title:(nullable NSString *)title
                          message:(nullable NSString *)message
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler{
    
    [[self shareInstance] alertViewWithIcon:icon title:title message:message textField:NO actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    
    return [self shareInstance];
}

- (instancetype)initWithIcon:(nullable NSString *)icon
                       title:(nullable NSString *)title
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler{
    
    self = [[self class] shareInstance];
    if (self) {
        [self alertViewWithIcon:icon title:title message:nil textField:NO actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    }
    return self;
}

+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                            title:(nullable NSString *)title
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler{
    
    [[self shareInstance] alertViewWithIcon:icon title:title message:nil textField:NO actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    
    return [self shareInstance];
}

- (instancetype)initWithIcon:(nullable NSString *)icon
                     message:(nullable NSString *)message
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler{
    
    self = [[self class] shareInstance];
    if (self) {
        [self alertViewWithIcon:icon title:nil message:message textField:NO actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    }
    return self;
}

+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                          message:(nullable NSString *)message
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler{
    
    [[self shareInstance] alertViewWithIcon:icon title:nil message:message textField:NO actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    
    return [self shareInstance];
}

- (instancetype)initWithIcon:(nullable NSString *)icon
                       title:(nullable NSString *)title
                   textField:(BOOL)textField
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler{
    
    self = [[self class] shareInstance];
    if (self) {
        [self alertViewWithIcon:icon title:title message:nil textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    }
    return self;
}

+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                            title:(nullable NSString *)title
                        textField:(BOOL)textField
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler{
    
    [[self shareInstance] alertViewWithIcon:icon title:title message:nil textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    
    return [self shareInstance];
}

- (instancetype)initWithIcon:(nullable NSString *)icon
                     message:(nullable NSString *)message
                   textField:(BOOL)textField
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler{
    
    self = [[self class] shareInstance];
    if (self) {
        [self alertViewWithIcon:icon title:nil message:message textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    }
    return self;
}

+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                          message:(nullable NSString *)message
                        textField:(BOOL)textField
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler{
    
    [[self shareInstance] alertViewWithIcon:icon title:nil message:message textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    
    return [self shareInstance];
}

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                    textField:(BOOL)textField
        actionCancelWithTitle:(nullable NSString *)cancelTitle
       actionConfirmWithTitle:(nullable NSString *)confirmTitle
                      handler:(void (^ __nullable)(NSInteger index))handler{
    
    self = [[self class] shareInstance];
    if (self) {
        [self alertViewWithIcon:nil title:title message:message textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(nullable NSString *)title
                           message:(nullable NSString *)message
                         textField:(BOOL)textField
             actionCancelWithTitle:(nullable NSString *)cancelTitle
            actionConfirmWithTitle:(nullable NSString *)confirmTitle
                           handler:(void (^ __nullable)(NSInteger index))handler{
    
    [[self shareInstance] alertViewWithIcon:nil title:title message:message textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    
    return [self shareInstance];
}

- (instancetype)initWithTitle:(nullable NSString *)title
                    textField:(BOOL)textField
        actionCancelWithTitle:(nullable NSString *)cancelTitle
       actionConfirmWithTitle:(nullable NSString *)confirmTitle
                      handler:(void (^ __nullable)(NSInteger index))handler{
    
    self = [[self class] shareInstance];
    if (self) {
        [self alertViewWithIcon:nil title:title message:nil textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(nullable NSString *)title
                         textField:(BOOL)textField
             actionCancelWithTitle:(nullable NSString *)cancelTitle
            actionConfirmWithTitle:(nullable NSString *)confirmTitle
                           handler:(void (^ __nullable)(NSInteger index))handler{
    
    [[self shareInstance] alertViewWithIcon:nil title:title message:nil textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    
    return [self shareInstance];
}

- (instancetype)initWithMessage:(nullable NSString *)message
                      textField:(BOOL)textField
          actionCancelWithTitle:(nullable NSString *)cancelTitle
         actionConfirmWithTitle:(nullable NSString *)confirmTitle
                        handler:(void (^ __nullable)(NSInteger index))handler{
    
    self = [[self class] shareInstance];
    if (self) {
        [self alertViewWithIcon:nil title:nil message:message textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    }
    return self;
}

+ (instancetype)alertViewWithMessage:(nullable NSString *)message
                           textField:(BOOL)textField
               actionCancelWithTitle:(nullable NSString *)cancelTitle
              actionConfirmWithTitle:(nullable NSString *)confirmTitle
                             handler:(void (^ __nullable)(NSInteger index))handler{
    
    [[self shareInstance] alertViewWithIcon:nil title:nil message:message textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    
    return [self shareInstance];
}

- (instancetype)initWithIcon:(nullable NSString *)icon
                       title:(nullable NSString *)title
                     message:(nullable NSString *)message
                   textField:(BOOL)textField
       actionCancelWithTitle:(nullable NSString *)cancelTitle
      actionConfirmWithTitle:(nullable NSString *)confirmTitle
                     handler:(void (^ __nullable)(NSInteger index))handler{
    
    self = [[self class] shareInstance];
    if (self) {
        [self alertViewWithIcon:icon title:title message:message textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    }
    return self;
}

+ (instancetype)alertViewWithIcon:(nullable NSString *)icon
                            title:(nullable NSString *)title
                          message:(nullable NSString *)message
                        textField:(BOOL)textField
            actionCancelWithTitle:(nullable NSString *)cancelTitle
           actionConfirmWithTitle:(nullable NSString *)confirmTitle
                          handler:(void (^ __nullable)(NSInteger index))handler{
    
    [[self shareInstance] alertViewWithIcon:icon title:title message:message textField:textField actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
    
    return [self shareInstance];
}

- (void)closeAction:(UIButton *)button{
    if (self.textField) {
//        if (self.isKeyBoardShow) {
//            return;
//        }
    }else{
        [self hideAnimated:YES];
    }
                                                     
    if (self.handler) {
        self.handler(button.tag-1000);
    }
}

- (void)textFieldEndEditing{
    [self.textField endEditing:YES];
}

- (void)hideAnimated:(BOOL)animated{
    [self textFieldEndEditing];
    
    [self.hud hideAnimated:animated];
}

+ (void)hideAnimated:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[self shareInstance] hideAnimated:animated];
}


- (void)alertViewWithTitle:(nullable NSString *)title
                   message:(nullable NSString *)message
     actionCancelWithTitle:(nullable NSString *)cancelTitle
    actionConfirmWithTitle:(nullable NSString *)confirmTitle
                   handler:(void (^ __nullable)(NSInteger index))handler{
    
    [self alertViewWithIcon:nil title:title message:message textField:NO actionCancelWithTitle:cancelTitle actionConfirmWithTitle:confirmTitle handler:handler];
}

- (void)alertViewWithIcon:(nullable NSString *)icon
                    title:(nullable NSString *)title
                  message:(nullable NSString *)message
                textField:(BOOL)needTextField
    actionCancelWithTitle:(nullable NSString *)cancelTitle
   actionConfirmWithTitle:(nullable NSString *)confirmTitle
                  handler:(void (^ __nullable)(NSInteger index))handler{
    
    self.keyBoardShow = NO;
    
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = QYHAdaptionWidth(12);
    view.frame = CGRectMake(0, 0, QYHAdaptionWidth(270), 0);
    view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    
    self.customView = view;
    
    UIImageView *iconImageView;
    if (icon) {
        iconImageView = [[UIImageView alloc] init];
        iconImageView.image = [UIImage imageNamed:icon];
        
        [view addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(QYHSpace);
            make.centerX.equalTo(view);
        }];
        
        self.iconImageView = iconImageView;
    }
    
    UILabel *titleLabel;
    if (title) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.text = title;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:QYHAdaptionWidth(16)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(QYHSpace);
            make.right.equalTo(view).offset(-QYHSpace);
            if (iconImageView) {
                make.top.equalTo(iconImageView.mas_bottom).offset(QYHAdaptionWidth(10));
            }else{
                make.top.equalTo(view).offset(QYHSpace);
            }
        }];
        
        self.titleLabel = titleLabel;
    }
    
    UILabel *messageLabel;
    if (message) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.text = message;
        messageLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.95];
        messageLabel.font = [UIFont systemFontOfSize:QYHAdaptionWidth(12)];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (titleLabel) {
                make.top.equalTo(titleLabel.mas_bottom).offset(QYHAdaptionWidth(QYHSpace));
            }else if (iconImageView){
                make.top.equalTo(iconImageView.mas_bottom).offset(QYHAdaptionWidth(QYHSpace));
            }else{
                make.top.equalTo(view).offset(QYHSpace);
            }
            make.left.equalTo(view).offset(QYHSpace);
            make.right.equalTo(view).offset(-QYHSpace);
        }];
        
        self.messageLabel = messageLabel;
    }
    
    UITextField *textField;
    if (needTextField) {
        textField = [[UITextField alloc] init];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.textColor = [UIColor blackColor];
        textField.font = [UIFont systemFontOfSize:QYHAdaptionWidth(15)];
        textField.textAlignment = NSTextAlignmentCenter;
        
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.rightViewMode = UITextFieldViewModeAlways;
        
        CGFloat height = QYHAdaptionWidth(35);
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, QYHAdaptionWidth(5), height)];
        textField.leftView = leftView;
        textField.rightView = leftView;
        
        [view addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(QYHSpace);
            make.right.equalTo(view).offset(-QYHSpace);
            make.height.mas_equalTo(height);
            if (messageLabel) {
                make.top.equalTo(messageLabel.mas_bottom).offset(QYHSpace);
            }else if (titleLabel){
                make.top.equalTo(titleLabel.mas_bottom).offset(QYHSpace);
            }else if (iconImageView){
                make.top.equalTo(iconImageView.mas_bottom).offset(QYHSpace);
            }else{
                make.top.equalTo(view).offset(QYHSpace);
            }
        }];
        
        self.textField = textField;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    if (!titleLabel && !messageLabel && !iconImageView) {
        [QYHProgressHUD showMessage:@"no message" toView:nil];
        return;
    }
    
    if (!cancelTitle && !confirmTitle) {
        [QYHProgressHUD showMessage:@"no button" toView:nil];
        return;
    }
    
    UIColor *color = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:0.7f];
    UIView *hLineView = [[UIView alloc] init];
    hLineView.backgroundColor = color;
    
    [view addSubview:hLineView];
    [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.height.mas_equalTo(QYHAdaptionWidth(0.65));
        if (textField){
            make.top.equalTo(textField.mas_bottom).offset(QYHSpace);
        }else if (messageLabel) {
            make.top.equalTo(messageLabel.mas_bottom).offset(QYHSpace);
        }else if (titleLabel){
            make.top.equalTo(titleLabel.mas_bottom).offset(QYHSpace);
        }else if (iconImageView){
            make.top.equalTo(iconImageView.mas_bottom).offset(QYHSpace);
        }else{
            make.top.equalTo(view).offset(QYHSpace);
        }
    }];
    
    self.hLineView = hLineView;
    
    UIButton *cancelButton;
    if (cancelTitle) {
        cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorWithRed:35/255.0 green:120/255.0 blue:254/255.0 alpha:1.0] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:QYHAdaptionWidth(16)];
        cancelButton.tag = 1000;
        
        [cancelButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hLineView.mas_bottom);
            make.bottom.left.equalTo(view);
            make.height.mas_equalTo(QYHAdaptionWidth(49));
            if (!confirmTitle) {
                make.right.equalTo(view);
            }
        }];
        
        self.cancelButton = cancelButton;
    }
    
    UIButton *confirmButton;
    if (confirmTitle) {
        confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor colorWithRed:35/255.0 green:120/255.0 blue:254/255.0 alpha:1.0] forState:UIControlStateNormal];
        confirmButton.titleLabel.font = [UIFont systemFontOfSize:QYHAdaptionWidth(16)];
        confirmButton.tag = 1001;
        
        [confirmButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:confirmButton];
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hLineView.mas_bottom);
            make.bottom.right.equalTo(view);
            make.height.mas_equalTo(QYHAdaptionWidth(49));
            if (cancelButton) {
                make.width.equalTo(cancelButton);
                make.left.equalTo(cancelButton.mas_right);
            }else{
                make.bottom.left.right.equalTo(view);
            }
        }];
        
        
        self.confirmButton = confirmButton;
        
        if (cancelButton) {
            UIView *vLineView = [[UIView alloc] init];
            vLineView.backgroundColor = color;
            
            [view addSubview:vLineView];
            [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(hLineView.mas_bottom);
                make.centerX.bottom.equalTo(view);
                make.width.mas_equalTo(QYHAdaptionWidth(0.65));
            }];
            
            self.vLineView = vLineView;
        }
    }
    
    if (handler) {
        self.handler = handler;
    }
    
    self.hud = [QYHProgressHUD showCustomView:view toView:nil afterDelay:0];
    
    if (textField) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldEndEditing)];
        tap.cancelsTouchesInView = NO;
        
        [self.hud addGestureRecognizer:tap];
    }
}

// Handle keyboard show/hide changes
- (void)keyboardWillShow: (NSNotification *)notification{
    self.keyBoardShow = YES;
    CGSize dialogSize = self.customView.superview.frame.size;
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    CGFloat Y = (QYHScreen_height - keyboardSize.height - dialogSize.height - 30);
    if (Y > (QYHScreen_height - dialogSize.height) / 2) {
        Y = (QYHScreen_height - dialogSize.height) / 2 - 30;
    }
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.customView.superview.frame = CGRectMake((QYHScreen_width - dialogSize.width) / 2, Y, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}

- (void)keyboardWillHide: (NSNotification *)notification{
    CGSize dialogSize = self.customView.superview.frame.size;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
        self.customView.superview.frame = CGRectMake((QYHScreen_width - dialogSize.width) / 2, (QYHScreen_height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
    }
                     completion:^(BOOL finished) {
        self.keyBoardShow = NO;
    }
     ];
}


@end
