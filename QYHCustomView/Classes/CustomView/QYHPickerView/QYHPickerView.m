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
static CGFloat CellSeperateHeight = 44.0f;

@interface QYHPickerView()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableDictionary *selectRowDict;
@end


@implementation QYHPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData{
    self.labelSize = AdaptionWidthWith6(16);
    self.labelColor = [UIColor colorWithHexString:@"0x101010" alpha:0.8];
    self.components = 1;
    self.componentWidth = SCREEN_WIDTH;
    self.lineViewColor = [UIColor colorWithHexString:@"0xDEDEDE" alpha:1];
    self.cancelTitle = @"取消";
    self.cancelSize = AdaptionFont6(18);
    self.cancelColor = [UIColor redColor];
    self.confirmTitle = @"确定";
    self.confirmSize = AdaptionFont6(18);
    self.confirmColor = [UIColor redColor];
}

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
        [_selectRowDict setValue:@{} forKey:@"0"];
        [_selectRowDict setValue:@{} forKey:@"1"];
    }
    return _selectRowDict;
}

#pragma mark -- UIPickerView
- (void)creatPickerView{
    [self shadowView];

    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, AdaptionWidthWith6(82))];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.shadowView addSubview:self.bgView];
    
    [self creatButton];
    [self creatPicker];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, AdaptionWidthWith6(49), SCREEN_WIDTH, AdaptionWidthWith6(0.8))];
    lineView.backgroundColor = self.lineViewColor;
    [self.bgView addSubview:lineView];
    [self shadowViewAnimation];
}

- (void)creatPicker{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, AdaptionWidthWith6(50), SCREEN_WIDTH, bgViewHeight - AdaptionWidthWith6(50))];
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
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(AdaptionWidthWith6(10), 0, AdaptionWidthWith6(80), AdaptionWidthWith6(49));
    [cancelBtn setTitle:self.cancelTitle forState:UIControlStateNormal];
    [cancelBtn setTitleColor:self.cancelColor forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:self.cancelSize];
    [self.bgView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [confirmBtn setTitle:self.confirmTitle forState:UIControlStateNormal];
    [confirmBtn setTitleColor:self.confirmColor forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(clickOKButton:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.frame = CGRectMake(SCREEN_WIDTH - AdaptionWidthWith6((80+10)), 0, AdaptionWidthWith6(80), AdaptionWidthWith6(49));
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:self.confirmSize];
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
    if (self.datasDict && [self.datasDict.allKeys containsObject:tempComponent]) {
        NSArray *arr = self.datasDict[tempComponent];
        if (arr && [arr isKindOfClass:[NSArray class]]) {
            return arr.count;
        }
    }
    
    return 0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.componentWidth;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UIView *pickerCell = [UIView new];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.componentWidth, AdaptionWidthWith6(CellSeperateHeight))];
    label.font = [UIFont boldSystemFontOfSize:self.labelSize];
    label.textColor = self.labelColor;
    label.textAlignment = NSTextAlignmentCenter;
    
    NSString *tempComponent = [NSString stringWithFormat:@"%ld",component];
    if (self.datasDict && [self.datasDict.allKeys containsObject:tempComponent]) {
        NSArray *arr = self.datasDict[tempComponent];
        if (arr && [arr isKindOfClass:[NSArray class]]) {
            label.text = arr[row];
        }
    }
    
    [pickerCell addSubview:label];
    
    [self changeSpearatorLineColor];
    
    return pickerCell;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    if (self.delegate &&[self.delegate respondsToSelector:@selector(pickerDidSelectRow:atComponent:)]){
//        [self.delegate pickerDidSelectRow:row atComponent:component];
//    }
//
    NSString *tempComponent = [NSString stringWithFormat:@"%ld",component];
    self.selectRowDict[tempComponent] = [NSString stringWithFormat:@"%ld",row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return AdaptionWidthWith6(CellSeperateHeight);
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
