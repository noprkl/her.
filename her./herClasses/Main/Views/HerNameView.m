//
//  HerNameView.m
//  her.
//
//  Created by ma c on 17/1/18.
//  Copyright © 2017年 LXq. All rights reserved.
//
// 名字长度
#define kMaxLength 8

#import "HerNameView.h"

@interface HerNameView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *backImgView; /**< 名字背景 */

@property (nonatomic, strong) UIView *line1; /**< 坐标竖线1 */

@property (nonatomic, strong) UILabel *nameLabel; /**< 我叫.. */

@property (nonatomic, strong) UITextField *nameTF; /**< 名字编辑 */

@property (nonatomic, strong) UIView *line; /**< 线 */

@property (nonatomic, strong) UIButton *sureBtn; /**< 确定 */

@property (nonatomic, strong) UIView *line2; /**< 坐标竖线2 */

@property (nonatomic, strong) UILabel *titleLabel; /**< 标题 */

@end
@implementation HerNameView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImgView];
        [self.backImgView addSubview:self.line1];
        [self.backImgView addSubview:self.line2];
        [self addSubview:self.nameLabel];
        [self addSubview:self.nameTF];
        [self addSubview:self.line];
        [self addSubview:self.sureBtn];
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
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.left.equalTo(self.line1.left).offset(10);
    }];
    [self.sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.right.equalTo(self.right).offset(-10);
        make.size.equalTo(CGSizeMake(44, 21));
    }];
    [self.nameTF makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.left.equalTo(self.nameLabel.right).offset(5);
        make.right.equalTo(self.sureBtn.left).offset(-5);
        make.height.equalTo(20);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameTF);
        make.top.equalTo(self.nameTF.bottom);
        make.height.equalTo(1);
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
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _nameLabel.font = [UIFont systemFontOfSize:19];
        _nameLabel.text = @"我叫";
    }
    return _nameLabel;
}
- (UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF = [[UITextField alloc] init];
        _nameTF.borderStyle = UITextBorderStyleNone;
        _nameTF.delegate = self;
        _nameTF.font = [UIFont systemFontOfSize:14];
        [_nameTF addTarget:self action:@selector(editNameText:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _nameTF;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"My name is";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"#5c5c5c"] forState:(UIControlStateNormal)];
        
        _sureBtn.layer.borderColor = [UIColor colorWithHexString:@"#5c5c5c"].CGColor;
        _sureBtn.layer.borderWidth = 0.5;
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.layer.masksToBounds = YES;
        [_sureBtn addTarget:self action:@selector(clickSureButtonAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sureBtn;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#b3b6b6"];
    }
    return _line;
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
- (void)clickSureButtonAction {
    // 取消键盘
    [self.nameTF resignFirstResponder];
    if (_sureBlock) {
        _sureBlock(self.nameTF.text);
    }
}
- (void)editNameText:(UITextField *)textField {
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}
#pragma mark
#pragma mark - 代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
