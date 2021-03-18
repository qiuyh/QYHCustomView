//
//  QYHViewController.m
//  QYHCustomView
//
//  Created by 1039724903@qq.com on 06/04/2020.
//  Copyright (c) 2020 1039724903@qq.com. All rights reserved.
//

#import "QYHViewController.h"
#import "QYHProgressHUD.h"
#import "Masonry.h"
#import "QYHAlertView.h"
#import "QYHBubbleView.h"
#import "QYHSelectedView.h"
#import "QYHPickerView.h"
#import "QYHHeader.h"

@interface QYHViewController ()<QYHPickerViewDelegate>
@property (nonatomic, strong) QYHAlertView *alertView;
@property (nonatomic, strong) QYHSelectedView *selectedView;
@property (nonatomic, strong) QYHPickerView *pickerView;
@end

@implementation QYHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = CGRectMake(0, 0, 45, 45);
    button.center = self.view.center;
    
    [self.view addSubview:button];
    
}

- (void)click{
//    [self showCustomViewHUD];
    
//    [self showClassCustomAlert];

//    [self showSystemAlert];
    
//    QYHAlertView *alertView = [[QYHAlertView alloc] initWithTitle:@"同步成功，将在刷功" message:nil actionCancelWithTitle:@"关闭" actionConfirmWithTitle:nil handler:^(NSInteger index) {
//
//    }];
    
//    alertView.titleLabel.textColor = [UIColor redColor];

//    [QYHAlertView alertViewWithTitle:@"将在刷功" textField:YES actionCancelWithTitle:@"关闭" actionConfirmWithTitle:nil handler:^(NSInteger index) {
//        [QYHAlertView hideAnimated:YES];
//    }];
    
//    @weakify(self);
//    [QYHAlertView alertViewWithIcon:@"refresh_success" title:@"同步成功，将在刷功" message:@"同步成功，将在刷新周期的时间内做调整，将在刷新周期的时间内做调整" textField:YES actionCancelWithTitle:@"关闭" actionConfirmWithTitle:nil handler:^(NSInteger index) {
//        @strongify(self);
//
//        [QYHAlertView hideAnimated:YES];
//        [self showSystemAlert];
//    }];
    
//    [self showBubbleView];
    
    [self showSelectedView];
    
    
//    [self showPickerView];
}

- (void)showPickerView{
    _pickerView = [[QYHPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
    _pickerView.components = 2;
    _pickerView.datasDict = [@{@"0":@[@"123", @"234", @"345"],
                               @"1":@[@"123", @"234", @"345"]
    } mutableCopy];
    _pickerView.delegate = self;
    _pickerView.componentWidth = SCREEN_WIDTH*0.5;
    _pickerView.labelSize = 16;
    [_pickerView creatPickerView];
    [_pickerView pickerViewSelectIndex:2 atComponent:0];
    [_pickerView pickerViewSelectIndex:1 atComponent:1];
}
#pragma mark -- QYHPickerViewDelegate
- (void)confirmPicker:(NSMutableDictionary *)dict rowDict:(NSMutableDictionary *)rowDict{
    NSString *tempData = [dict valueForKey:@"0"];
    CGFloat tempFloat = [tempData floatValue];
   
    NSLog(@"dict==%@, rowDict==%@", dict, rowDict);
}


- (void)showSelectedView{
    [self.selectedView showWithDataArray:@[@"123", @"234", @"345"] callBack:^(NSInteger index) {
        
    }];
}

- (QYHSelectedView *)selectedView{
    if (!_selectedView) {
        QYHSelectedView *selectedView = [[QYHSelectedView alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:selectedView];
        
        [selectedView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo([UIApplication sharedApplication].keyWindow).offset(AdaptionWidthWith6(15));
            make.right.equalTo([UIApplication sharedApplication].keyWindow).offset(AdaptionWidthWith6(-114));
            make.top.equalTo([UIApplication sharedApplication].keyWindow).offset(NavigationHeight + AdaptionHeightWith6(10));
            make.height.mas_equalTo(AdaptionWidthWith6(150));
        }];
        
        selectedView.cellHeight = 55;
        selectedView.bgBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        selectedView.fontsize = 14;
        selectedView.showBubble = YES;
        selectedView.cornerRadius = 6;
        selectedView.bubbleViewfillColorIndex = 0;
        
        _selectedView = selectedView;
    }
    return _selectedView;
}

- (void)showBubbleView{
    QYHBubbleView *bubbleView = [[QYHBubbleView alloc] init];

    bubbleView.fillColor = [UIColor lightGrayColor];
    bubbleView.bubbleType = QYHBubbleTypeTopMiddle;
    bubbleView.strokeColor = [UIColor whiteColor];
    bubbleView.margin = 15;
    bubbleView.arrowWidth = 20;
    bubbleView.arrowHeight = 10;
    
    [self.view addSubview:bubbleView];
    [bubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 80));
        make.center.equalTo(self.view);
    }];
}

- (void)showClassCustomAlert{
    [QYHAlertView alertViewWithTitle:@"同步成功，将在刷功" message:@""  actionCancelWithTitle:@"关闭"  actionConfirmWithTitle:nil handler:^(NSInteger index) {

    }];
}

- (void)showSystemAlert{
    [self alertViewWithTitle:@"同步成功，将在刷功" titleColor:nil message:@"同步成功，将在刷新周期的时间内做调整" messageColor:nil actionCancelWithTitle:@"关闭" cancelTitleColor:nil actionConfirmWithTitle:nil confirmTitleColor:nil handler:^(UIAlertAction *action) {
        
    }];
}


- (void)showCustomViewHUD{
     UIView *view = [self getCustomView];
        QYHProgressHUD *hud = [QYHProgressHUD showCustomView:view toView:nil afterDelay:3.0];
    //    hud.dimBackgroundColor = [UIColor clearColor];
        
    //    [view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(200, 170));
    //    }];
}

- (UIView *)getCustomView{
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 7;
    view.frame = CGRectMake(0, 0, 200, 170);
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"refresh_success"];
    
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view).offset(20);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"刷新成功";
    
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(7);
        make.centerX.equalTo(view);
    }];
    
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.numberOfLines = 0;
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    detailLabel.text = @"同步成功，将在刷新周期的时间内做调整，请耐心等待。";
    
    [view addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.equalTo(view).offset(20);
        make.right.equalTo(view).offset(-20);
    }];
    
    return view;
}

- (void)alertViewWithTitle:(nullable NSString *)title
                titleColor:(nullable UIColor *)titleColor
                   message:(nullable NSString *)message
              messageColor:(nullable UIColor *)messageColor
     actionCancelWithTitle:(nullable NSString *)cancelTitle
          cancelTitleColor:(nullable UIColor *)cancelTitleColor
    actionConfirmWithTitle:(nullable NSString *)confirmTitle
         confirmTitleColor:(nullable UIColor *)confirmTitleColor
                   handler:(void (^ __nullable)(UIAlertAction *action))handler{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel;
    UIAlertAction *confirm;
    
    if (cancelTitle) {
        cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancel];
    }
    if (confirmTitle) {
        confirm = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:handler];
        [alertVC addAction:confirm];
    }
    
    if (titleColor) {
        NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [titleStr addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, titleStr.length)];
        [alertVC setValue:titleStr forKey:@"attributedTitle"];
    }
    
    if (messageColor) {
        NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [messageStr addAttribute:NSForegroundColorAttributeName value:messageColor range:NSMakeRange(0, messageStr.length)];
        [alertVC setValue:messageStr forKey:@"attributedMessage"];
    }
    
    if (cancelTitleColor) {
        [cancel setValue:cancelTitleColor forKey:@"_titleTextColor"];
    }
    
    if (confirmTitleColor) {
        [confirm setValue:confirmTitleColor forKey:@"_titleTextColor"];
    }
    
    [self presentViewController:alertVC animated:YES completion:nil];
}


@end
