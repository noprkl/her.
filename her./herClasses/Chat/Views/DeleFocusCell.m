//
//  DeleFocusCell.m
//  her.
//
//  Created by 李祥起 on 2017/2/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "DeleFocusCell.h"

@interface DeleFocusCell ()


@property (nonatomic, strong) UIButton *delBtn; /**< 删除按钮 */

@property (nonatomic, strong) UIImageView *iconView; /**< 头像 */

@property (nonatomic, strong) UILabel *focusNameLabel; /**< 关注的人名字 */
@end

@implementation DeleFocusCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.delBtn];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.focusNameLabel];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.delBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(5);
        make.size.equalTo(KSIZE(21, 21));
    }];
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(KSIZE(30, 30));
        make.left.equalTo(self.delBtn.right).offset(5);
    }];
    [self.focusNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(self.right).offset(-5);
        make.left.equalTo(self.iconView.right).offset(2);
    }];
}

#pragma mark
#pragma mark - 懒加载
- (UIButton *)delBtn {
    if (!_delBtn) {
        _delBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_delBtn setImage:[UIImage originalImageNamed:@"remove"] forState:(UIControlStateNormal)];

        [_delBtn setContentMode:(UIViewContentModeCenter)];
        [_delBtn addTarget:self action:@selector(clickdelBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _delBtn;
}
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage originalImageNamed:@"The-girl-picture"]];
    }
    return _iconView;
}
- (UILabel *)focusNameLabel {
    if (!_focusNameLabel) {
        _focusNameLabel = [[UILabel alloc] init];
        _focusNameLabel.text = @"玫瑰还是";
        _focusNameLabel.font = [UIFont systemFontOfSize:16];
        _focusNameLabel.textColor = HEXColor(@"#fc0101");
    }
    return _focusNameLabel;
}
- (void)setStr:(NSString *)str {
    _str = str;
    self.focusNameLabel.text = str;
}
#pragma mark
#pragma mark - Action
- (void)clickdelBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (_delBlock) {
        _delBlock();
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
