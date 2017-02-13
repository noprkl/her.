//
//  TwoChatToolView.m
//  her.
//
//  Created by 李祥起 on 2017/2/7.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "TwoChatToolView.h"

@interface TwoChatToolView ()

@property (nonatomic, strong) UIView *lightLine; /**< 浅线 */

@property (nonatomic, strong) UIButton *backButton; /**< 返回按钮 */

@property (nonatomic, strong) UIButton *focusButton; /**< 关注按钮 */

@property (nonatomic, strong) UIImageView *otherIconView; /**< 对方头像 */

@property (nonatomic, strong) UILabel *otherNameLabel; /**< 对方名字 */

@end

@implementation TwoChatToolView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lightLine];
        [self addSubview:self.backButton];
        [self addSubview:self.focusButton];
        [self addSubview:self.otherIconView];
        [self addSubview:self.otherNameLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.lightLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(20);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 0.1));
        make.left.equalTo(self.left);
    }];
    [self.backButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(20);
        make.left.equalTo(self.left).offset(10);
    }];
    
    [self.otherIconView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton.centerY);
        make.left.equalTo(self.backButton.right).offset(20);
        make.size.equalTo(CGSizeMake(40, 40));
    }];

    [self.otherNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton.centerY);
        make.left.equalTo(self.otherIconView.right).offset(5);
    }];

    [self.focusButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton.centerY);
        make.right.equalTo(self.right).offset(-17);
        make.size.equalTo(CGSizeMake(26, 22));
    }];
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backButton setImage:[UIImage originalImageNamed:@"return"] forState:(UIControlStateNormal)];
        [_backButton setImage:[UIImage originalImageNamed:@"return"] forState:(UIControlStateSelected)];
        [_backButton setContentMode:(UIViewContentModeCenter)];
        [_backButton addTarget:self action:@selector(clickBackButtonAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _backButton;
}
- (UIButton *)focusButton {
    if (!_focusButton) {
        _focusButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_focusButton setImage:[UIImage originalImageNamed:@"like"] forState:(UIControlStateNormal)];
        [_focusButton setImage:[UIImage originalImageNamed:@"like-red"] forState:(UIControlStateSelected)];
        [_focusButton addTarget:self action:@selector(clickFocusButtonAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _focusButton;
}
- (UIImageView *)otherIconView {
    if (!_otherIconView) {
        _otherIconView = [[UIImageView alloc] init];
        _otherIconView.image = [UIImage imageNamed:@"The-boy-picture"];
    }
    return _otherIconView;
}
- (UILabel *)otherNameLabel {
    if (!_otherNameLabel) {
        _otherNameLabel = [[UILabel alloc] init];
        _otherNameLabel.text = @"Jack";
        _otherNameLabel.font = [UIFont boldSystemFontOfSize:21];
        _otherNameLabel.tintColor = HEXColor(@"#1a1a1a");
    }
    return _otherNameLabel;
}
#pragma mark
#pragma mark - Action
- (void)clickBackButtonAction {
    if ([self.toolDelegate respondsToSelector:@selector(clickBackBtnAction)]) {
        [self.toolDelegate clickBackBtnAction];
    }
}
- (void)clickFocusButtonAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if ([self.toolDelegate respondsToSelector:@selector(clickFocusBtnAction)]) {
        [self.toolDelegate clickFocusBtnAction];
    }
}
@end
