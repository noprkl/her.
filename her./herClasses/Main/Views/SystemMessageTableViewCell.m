//
//  SystemMessageTableViewCell.m
//  her.
//
//  Created by 李祥起 on 2017/2/6.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "SystemMessageTableViewCell.h"

@interface SystemMessageTableViewCell ()

@property (nonatomic, strong) UIButton *deleteBtn; /**< 删除按钮 */

@property (nonatomic, strong) UIImageView *backImgView; /**< 背景图片 */

@property (nonatomic, strong) UIImageView *iconView; /**< 头像图片 */

@property (nonatomic, strong) UILabel *messageLabel; /**< 消息内容 */

@property (nonatomic, strong) UIButton *appointBtn; /**< 赴约按钮 */

@end
@implementation SystemMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.deleteBtn];
        [self.contentView addSubview:self.backImgView];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.messageLabel];
        [self.contentView addSubview:self.appointBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(CGSizeMake(55/2, 55/2));
        make.left.equalTo(self.left);
    }];
    
    [self.backImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.deleteBtn.right);
        make.right.equalTo(self.right);
    }];
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.backImgView.left).offset(5);
        make.top.equalTo(5);
        make.width.equalTo(self.iconView.height);
    }];
    [self.messageLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.iconView.right);
        make.top.equalTo(self.backImgView.top);
    }];
    [self.appointBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.messageLabel.right).offset(5);
        make.size.equalTo(CGSizeMake(36, 20));
    }];
}
- (void)setState:(NSInteger)state {
    _state = state;

    if (state % 3) {
        self.iconView.image = [UIImage originalImageNamed:@"Did-not-send"];
        self.appointBtn.hidden = YES;
    }else{
        self.iconView.image = [UIImage originalImageNamed:@"The-girl-picture"];
        self.appointBtn.hidden = NO;
    }
    self.messageLabel.text = [NSString stringWithFormat:@"第%ld个信息", state];
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteBtn setImage:[UIImage originalImageNamed:@"quit"] forState:(UIControlStateNormal)];
        [_deleteBtn setContentMode:(UIViewContentModeCenter)];
        [_deleteBtn addTarget:self action:@selector(clickDeleteBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _deleteBtn;
}
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage originalImageNamed:@"The-girl-picture"];
    }
    return _iconView;
}
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"你已经被拉黑了，不要嚣张。";
        _messageLabel.textColor = HEXColor(@"#333333");
        _messageLabel.font = [UIFont systemFontOfSize:16];
    }
    return _messageLabel;
}
- (UIButton *)appointBtn {
    if (!_appointBtn) {
        _appointBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_appointBtn setTitle:@"赴约" forState:(UIControlStateNormal)];
        [_appointBtn setTitleColor:HEXColor(@"#333333") forState:(UIControlStateNormal)];
        _appointBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _appointBtn.layer.cornerRadius = 5;
        _appointBtn.layer.masksToBounds = YES;
        _appointBtn.layer.borderColor = HEXColor(@"#333333").CGColor;
        _appointBtn.layer.borderWidth = 1;
        
        [_appointBtn addTarget:self action:@selector(clickAppointBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _appointBtn;
}
- (UIImageView *)backImgView {
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] init];
        _backImgView.image = [UIImage originalImageNamed:@"bubble"];
    }
    return _backImgView;
}

#pragma mark
#pragma mark - Action
// 删除
- (void)clickDeleteBtnAction {
    if (_deleteBlock) {
        _deleteBlock();
    }
}
// 赴约
- (void)clickAppointBtnAction {
    if (_appointBlock) {
        _appointBlock();
    }
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
