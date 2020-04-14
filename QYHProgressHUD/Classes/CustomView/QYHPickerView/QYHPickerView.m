//
//  QYHPickerView.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "QYHPickerView.h"
#import "UIColor+QYHExtension.h"

#define bgViewHeight  225*SCREEN_HEIGHT/667
static CGFloat CellSeperateHeight = 50.0f;

@interface QYHPickerView()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableDictionary *selectRowDict;
@end


@implementation QYHPickerView

- (UIView *)shadowView{
    if (!_shadowView){
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
        _shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [[UIApplication sharedApplication].keyWindow addSubview:_shadowView];
    }
    return _shadowView;
}

- (NSMutableDictionary *)selectRowDict{
    if (!_selectRowDict){
        _selectRowDict = [[NSMutableDictionary alloc] init];
        [_selectRowDict setValue:@"0" forKey:@"0"];
        [_selectRowDict setValue:@"0" forKey:@"1"];
    }
    return _selectRowDict;
}

#pragma mark -- UIPickerView
- (void)creatPickerView{
    [self shadowView];

    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 82*SCREEN_HEIGHT/667)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.shadowView addSubview:self.bgView];
    
    [self creatButton];
    [self creatPicker];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"0xDEDEDE" alpha:1];
    [self.bgView addSubview:lineView];
    [self shadowViewAnimation];
}

- (void)creatPicker{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, bgViewHeight - 45)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;

    self.pickerView.showsSelectionIndicator = YES;
    [self.bgView addSubview:self.pickerView];
}

- (void)shadowViewAnimation{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.35f animations:^{
        weakSelf.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        weakSelf.bgView.frame = CGRectMake(0, SCREEN_HEIGHT - bgViewHeight, SCREEN_WIDTH, bgViewHeight);
    } completion:nil];
}

- (void)tapShadowView{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.35f animations:^{
        weakSelf.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        weakSelf.bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, bgViewHeight);
    } completion:^(BOOL finished) {
        [weakSelf.shadowView removeFromSuperview];
        [weakSelf removeFromSuperview];
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(removeFromSuperView)]){
            [weakSelf.delegate removeFromSuperView];
        }
    }];
}

- (void)creatButton{
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(15, 10, 80, 25);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptionFont6(16)];
    [self.bgView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(clickOKButton:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.frame = CGRectMake(SCREEN_WIDTH - 80  - 15, 10, 80, 25);
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptionFont6(16)];
    [self.bgView addSubview:confirmBtn];
}

#pragma mark -- UIPickerViewDelegate
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.components;
}

// 返回每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSString *tempComponent = [NSString stringWithFormat:@"%ld",component];
    NSArray *arr = self.datasDict[tempComponent];
    return arr.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.componentWidth;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIView *pickerCell = [UIView new];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.componentWidth, CellSeperateHeight)];
    label.font = [UIFont boldSystemFontOfSize:AdaptionFont6(self.labelSize)];
    label.textColor = [UIColor colorWithHexString:@"0x101010" alpha:0.8];
    NSString *tempComponent = [NSString stringWithFormat:@"%ld",component];
    NSArray *arr = self.datasDict[tempComponent];
    label.text = arr[row];

    label.textAlignment = NSTextAlignmentCenter;
    
    [pickerCell addSubview:label];
    [self changeSpearatorLineColor];
    return pickerCell;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *tempComponent = [NSString stringWithFormat:@"%ld",component];
    
    if (self.type == PickerNeedRequestType){
        if (self.delegate &&[self.delegate respondsToSelector:@selector(pickerDidSelectRow:atComponent:)]){
            [self.delegate pickerDidSelectRow:row atComponent:component];
        }
    }else{
        self.selectRowDict[tempComponent] = [NSString stringWithFormat:@"%ld",row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return CellSeperateHeight;
}

- (void)changeSpearatorLineColor{
    for(UIView *speartorView in self.pickerView.subviews){
        if (speartorView.frame.size.height < 1){//取出分割线view
            speartorView.backgroundColor = [UIColor colorWithHexString:@"0xDEDEDE" alpha:1];//隐藏分割线
        }
    }
}

- (void)clickCancelButton:(UIButton *)sender{
    [self tapShadowView];
}

- (void)clickOKButton:(UIButton *)sender{
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    NSString *target_0 = self.datasDict[@"0"][[self.selectRowDict[@"0"] integerValue]];

    [tempDict setObject:target_0 forKey:@"0"];
    
    if (self.components == 2){
        NSString *target_1 = self.datasDict[@"1"][[self.selectRowDict[@"1"] integerValue]];
        [tempDict setObject:target_1 forKey:@"1"];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmPicker:rowDict:)]){
        [self.delegate confirmPicker:tempDict rowDict:self.selectRowDict];
    }
    
    [self tapShadowView];
}

- (void)reloadPickerViewAtIndex:(NSInteger)component{
    [self.pickerView reloadComponent:component];
}

- (void)pickerViewSelectIndex:(NSInteger)index atComponent:(NSInteger)component{
    [self.pickerView selectRow:index inComponent:component animated:YES];
    
    NSString *tempComponent = [NSString stringWithFormat:@"%ld",component];
    self.selectRowDict[tempComponent] = [NSString stringWithFormat:@"%ld",index];
}

@end
