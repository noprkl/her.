//
//  LookHerAgainView.m
//  her.
//
//  Created by 李祥起 on 2017/2/6.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "LookHerAgainView.h"

@interface LookHerAgainView ()

@property (nonatomic, strong) UIImageView *backImgView; /**< 名字背景 */

@property (nonatomic, strong) UIView *line1; /**< 坐标竖线1 */

@property (nonatomic, strong) UILabel *findAgainLabel; /**< 继续寻找 */

@property (nonatomic, strong) UIButton *beginBtn; /**< 确定 */

@property (nonatomic, strong) UIView *line2; /**< 坐标竖线2 */

@property (nonatomic, strong) UILabel *titleLabel; /**< 标题 */

@end
@implementation LookHerAgainView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImgView];
        [self.backImgView addSubview:self.line1];
        [self.backImgView addSubview:self.line2];
        [self addSubview:self.findAgainLabel];
        [self addSubview:self.beginBtn];
        [self addSubview:self.titleLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom);
    }];
    [self.line1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(self.left).offset(5);
        make.size.equalTo(CGSizeMake(1, 75/2));
    }];
    [self.line2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.bottom);
        make.left.equalTo(self.line1.left);
        make.size.equalTo(CGSizeMake(1, 70/2));
    }];
    [self.findAgainLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.left.equalTo(self.line1.left).offset(10);
    }];
    [self.beginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.right.equalTo(self.right).offset(-10);
        make.size.equalTo(CGSizeMake(36, 20));
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line2.centerY);
        make.left.equalTo(self.line2.right).offset(10);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)backImgView {
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] initWithImage:[UIImage originalImageNamed:@"dialog-box-right"]];
    }
    return _backImgView;
}
- (UILabel *)findAgainLabel {
    if (!_findAgainLabel) {
        _findAgainLabel = [[UILabel alloc] init];
        _findAgainLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _findAgainLabel.font = [UIFont systemFontOfSize:19];
        _findAgainLabel.text = @"继续寻找附近的他？";
    }
    return _findAgainLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"Continue to look for him？";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}
- (UIButton *)beginBtn {
    if (!_beginBtn) {
        _beginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_beginBtn setTitle:@"开始" forState:(UIControlStateNormal)];
        _beginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_beginBtn setTitleColor:HEXColor(@"#333333") forState:(UIControlStateNormal)];
        
        _beginBtn.layer.borderColor = HEXColor(@"#5c5c5c").CGColor;
        _beginBtn.layer.borderWidth = 0.5;
        _beginBtn.layer.cornerRadius = 5;
        _beginBtn.layer.masksToBounds = YES;
        [_beginBtn addTarget:self action:@selector(clickBeginButtonAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _beginBtn;
}

- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = BackGround_Color;
    }
    return _line1;
}
- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [[UIColor colorWithHexString:@"#5c5c5c"] colorWithAlphaComponent:0.7];
    }
    return _line2;
}
#pragma mark
#pragma mark - Action
- (void)clickBeginButtonAction {
    if (_beginBlock) {
        _beginBlock();
    }
}
@end
