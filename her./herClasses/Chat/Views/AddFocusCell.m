//
//  AddFocusCell.m
//  her.
//
//  Created by 李祥起 on 2017/2/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "AddFocusCell.h"

@interface AddFocusCell ()

@property (nonatomic, strong) UIButton *addBtn; /**< 添加按钮 */

@property (nonatomic, strong) UIImageView *iconView; /**< 头像 */

@property (nonatomic, strong) UILabel *focusNameLabel; /**< 关注的人名字 */
@end

@implementation AddFocusCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.addBtn];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.focusNameLabel];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(5);
        make.size.equalTo(KSIZE(21, 21));
    }];
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(KSIZE(30, 30));
        make.left.equalTo(self.addBtn.right).offset(5);
    }];
   [self.focusNameLabel makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.centerY);
       make.right.equalTo(self.right).offset(-5);
       make.left.equalTo(self.iconView.right).offset(2);
   }];
}
- (void)setIsDel:(BOOL)isDel {
    _isDel = isDel;
    if (isDel) { // 如果已经删除掉了，图片就变灰色,这个地方做本地更好
        self.addBtn.selected = YES;
    }else{
        self.addBtn.selected = NO;
    }
}
- (void)setStr:(NSString *)str {
    _str = str;
    self.focusNameLabel.text = str;
}
#pragma mark
#pragma mark - 懒加载
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_addBtn setImage:[UIImage originalImageNamed:@"like-red"] forState:(UIControlStateNormal)];
        [_addBtn setImage:[UIImage originalImageNamed:@"like"] forState:(UIControlStateSelected)];
        [_addBtn setContentMode:(UIViewContentModeCenter)];
//        [_addBtn addTarget:self action:@selector(clickAddBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
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
#pragma mark
#pragma mark - Action
- (void)clickAddBtnAction:(UIButton *)btn {
//    btn.selected = !btn.selected;
//    if (_addBlock) {
//        _addBlock();
//    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
