//
//  QYHSelectedView.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "QYHSelectedView.h"
#import "QYHSelectedCell.h"
#import "Masonry.h"

#define QYHScreen_width (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define QYHAdaptionWidth(width) (width*((QYHScreen_width/375.0>1.8)?1.8:(QYHScreen_width/375.0)))

@interface QYHSelectedView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) QYHBubbleView *bubbleView;
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, copy) CompleteCallBack callBack;
@property(nonatomic, strong) UIButton *footerButton;
@property(nonatomic, strong) UIView *lineView;
@end


@implementation QYHSelectedView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.layer.borderWidth = QYHAdaptionWidth(0.6);
    self.layer.borderColor = [UIColor blueColor].CGColor;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = QYHAdaptionWidth(3);
    self.delegate = self;
    self.dataSource = self;
    self.hidden = YES;
    
    //init
    self.lineColor = [[UIColor lightTextColor] colorWithAlphaComponent:0.3];
    self.textColor = [UIColor blackColor];
    self.selectedTextColor = [UIColor blueColor];
    self.selectedBgColor = [UIColor colorWithRed:230.0/255.0 green:235.0/255.0 blue:250.0/255.0 alpha:1.0];
    self.textAlignment = NSTextAlignmentLeft;
    self.fontsize = 12;
    self.currentIndex = 0;
    self.cellHeight = 44;
    self.bgBackgroundColor = [UIColor clearColor];
    self.showBubble = NO;
    self.showCellLine = YES;
    self.bubbleType = QYHBubbleTypeTopLeft;
    self.cornerRadius = QYHAdaptionWidth(3);
    self.showAddSiteButton = NO;
//    self.addSiteButtonImageNamed = @"";
//    self.addSiteButtonTitle = @"":
//    self.imageNamedArray = @[];
    self.showAddBottomView = NO;
    self.bubbleViewfillColorIndex = 9999;
}

- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    
    self.layer.borderColor = borderColor.CGColor;
}

- (void)showWithDataArray:(NSArray *)dataArray callBack:(nonnull CompleteCallBack)callBack{

    if (!self.hidden) {
        [self showHideView];
        return;
    }
    
    self.dataArray = dataArray;
    self.callBack = callBack;
    
    if (self.cellHeight > 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            NSInteger count = dataArray.count;
            if (count > 8) {
                count = 8;
            }
            make.height.mas_equalTo(QYHAdaptionWidth(self.cellHeight)*count);
            
        }];
    }
    
    [self bgView];
    [self addShowBubbleView];
    [self showHideView];
    [self reloadData];
}

- (void)hideTableView{//隐藏
    [self showHideView];
    
    if (self.callBack) {
        self.callBack(self.currentIndex);
    }
}

- (void)showHideView{
    self.hidden = !self.hidden;
    self.bgView.hidden = !self.bgView.hidden;
    
    if (self.showBubble) {
         self.bubbleView.hidden = !self.bubbleView.hidden;
    }
}

- (void)addShowBubbleView{
    if (self.isShowBubble) {
        [self bubbleView];
        [self setBubbleViewBgColor];
        
        if (self.isShowAddSiteButton) {
            [self footerButton];
            [self lineView];
        }
    }
}

/*
 选中第几个时改变fillColor颜色
 */
- (void)setBubbleViewBgColor{
    if (self.currentIndex == self.bubbleViewfillColorIndex) {
        self.bubbleView.fillColor = self.selectedBgColor;
    }else{
        self.bubbleView.fillColor = self.backgroundColor;
    }
    
    [self.bubbleView setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

//底部点击事件
- (void)footerAction{
    self.currentIndex = 1000;
    [self hideTableView];
}

- (void)setAddSiteButtonTitle:(NSString *)addSiteButtonTitle{
    [self.footerButton setTitle:addSiteButtonTitle forState:UIControlStateNormal];
}

- (void)setAddSiteButtonImageNamed:(NSString *)addSiteButtonImageNamed{
    if (addSiteButtonImageNamed) {
        [self.footerButton setImage:[UIImage imageNamed:addSiteButtonImageNamed] forState:UIControlStateNormal];
        self.footerButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    }
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger rowIndex = indexPath.row;
    static NSString *identifier = @"QYHSelectedCell";
    QYHSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QYHSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (rowIndex < self.dataArray.count) {
        cell.bgColor = self.backgroundColor;
        cell.textColor = self.textColor;
        cell.selectedTextColor = self.selectedTextColor;
        cell.selectedBgColor = self.selectedBgColor;
        cell.lineColor = self.lineColor;
        cell.title = self.dataArray[rowIndex];
        cell.seltected = self.currentIndex == rowIndex;
        
        cell.textAlignment = self.textAlignment;
        cell.fontsize = self.fontsize;
        cell.showLine = rowIndex != self.dataArray.count-1;
        cell.showLine = self.isShowCellLine;
        
        if (self.imageNamedArray && rowIndex < self.imageNamedArray.count) {
            cell.iconNamed = self.imageNamedArray[rowIndex];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < self.dataArray.count) {
        self.currentIndex = indexPath.row;
    }
    
    [self hideTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return QYHAdaptionWidth((self.cellHeight));
}

#pragma mark -- lazy

- (UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = self.bgBackgroundColor;
        bgView.hidden = YES;
        bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTableView)];
        tap.cancelsTouchesInView = NO;
        [bgView addGestureRecognizer:tap];
        [self.superview insertSubview:bgView belowSubview:self];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.superview);
        }];
        
        _bgView = bgView;
        
        if (self.isShowAddBottomView) {
            UIView *bottomBgView = [[UIView alloc] init];
            bottomBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            
            [bgView addSubview:bottomBgView];
            
            [bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(bgView);
                make.top.equalTo(self.mas_bottom);
            }];
        }
    }
    return _bgView;
}

- (QYHBubbleView *)bubbleView{
    if (!_bubbleView) {
        QYHBubbleView *bubbleView = [[QYHBubbleView alloc] initWithFrame:self.bounds];
        bubbleView.fillColor = self.backgroundColor;
        bubbleView.bubbleType = self.bubbleType;
        
        self.borderColor = [UIColor clearColor];
        bubbleView.strokeColor = [UIColor blueColor];
        bubbleView.margin = 15;
        bubbleView.arrowWidth = 20;
        bubbleView.arrowHeight = 10;
        bubbleView.hidden = YES;
        
        [self.superview insertSubview:bubbleView aboveSubview:self.bgView];
        
        [bubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(1);
            make.bottom.equalTo(self).offset(self.isShowAddSiteButton ? QYHAdaptionWidth(self.cellHeight) : 1);
            
            make.left.equalTo(self).offset(-1);
            make.top.equalTo(self.mas_top).offset(QYHAdaptionWidth(-8));
        }];
        
        _bubbleView = bubbleView;
    }
    
    return _bubbleView;
}

- (UIButton *)footerButton{
    if (!_footerButton) {
        _footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _footerButton.titleLabel.font = [UIFont systemFontOfSize:QYHAdaptionWidth(self.fontsize)];
        [_footerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [self.bubbleView addSubview:_footerButton];
        
        [_footerButton addTarget:self action:@selector(footerAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_footerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.bubbleView);
            make.height.mas_equalTo(QYHAdaptionWidth(self.cellHeight));
        }];
    }
    return _footerButton;
}

- (UIView *)lineView{
    if (!_lineView) {
        UIView *lineView = [UIView new];
        lineView.backgroundColor = self.lineColor;
        
        [self.footerButton addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.footerButton);
            make.height.mas_equalTo(QYHAdaptionWidth(0.6));
        }];
        
        self.lineView = lineView;
    }
    return _lineView;
}


@end
