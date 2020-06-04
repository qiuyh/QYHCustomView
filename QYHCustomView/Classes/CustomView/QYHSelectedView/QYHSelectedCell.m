//
//  QYHSelectedCell.m
//  QYHProgressHUD
//
//  Created by saj-king on 2020/4/14.
//  Copyright © 2020 SAJ. All rights reserved.
//

#import "QYHSelectedCell.h"
#import "Masonry.h"

#define QYHScreen_width (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define QYHAdaptionWidth(width) width*QYHScreen_width/375.0

@interface QYHSelectedCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *iconImageView;
@end

@implementation QYHSelectedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

- (void)setSeltected:(BOOL)seltected{
    if (seltected) {
        self.contentView.backgroundColor = self.selectedBgColor;
        self.titleLabel.textColor = self.selectedTextColor;
    }else{
        self.contentView.backgroundColor = self.bgColor;
        self.titleLabel.textColor = self.textColor;
    }
}

- (void)setShowLine:(BOOL)showLine{
    self.lineView.hidden = !showLine;
}

- (void)setIconNamed:(NSString *)iconNamed{
    self.iconImageView.image = [UIImage imageNamed:iconNamed];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.contentView).offset(QYHAdaptionWidth(37));
    }];
}

- (void)setFontsize:(CGFloat)fontsize{
    self.titleLabel.font = [UIFont systemFontOfSize:QYHAdaptionWidth(fontsize)];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    self.titleLabel.textAlignment = textAlignment;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:QYHAdaptionWidth(12)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;//
        
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(QYHAdaptionWidth(10));
            make.right.equalTo(self.contentView).offset(QYHAdaptionWidth(-10));
        }];
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = self.lineColor;
        
        [self.contentView addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(QYHAdaptionWidth(10));
            make.right.equalTo(self.contentView).offset(QYHAdaptionWidth(-10));
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(QYHAdaptionWidth(0.6));
        }];
    }
    return _lineView;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_iconImageView];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(QYHAdaptionWidth(10));
            make.centerY.equalTo(self.contentView);
            if (self.iconImageViewSize.width) {
                make.size.mas_equalTo(self.iconImageViewSize);
            }
        }];
    }
    return _iconImageView;
}

@end
