//
//  FriendsCell.m
//  her.
//
//  Created by 李祥起 on 2017/2/4.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "FriendsCell.h"

@interface FriendsCell ()

@property (nonatomic, strong) UIImageView *iconView; /**< 头像 */

@property (nonatomic, strong) UILabel *nameLabel; /**< 名字 */

@property (nonatomic, strong) UIButton *stateBtn; /**< 状态按钮 */

@end
@implementation FriendsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.stateBtn];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setState:(NSInteger)state {
    _state = state;
    if (state % 2) { // 当已关注的好友在那等你的时候 
        [self.stateBtn setTitleColor:HEXColor(@"#ffffff") forState:(UIControlStateNormal)];
        [self.stateBtn setTitle:@"赴约" forState:(UIControlStateNormal)];
        [self.stateBtn setBackgroundColor:HEXColor(@"#fd0202")];
        self.stateBtn.layer.borderColor = HEXColor(@"#fd0202").CGColor;
        self.nameLabel.textColor = HEXColor(@"#fd0202");
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(15/2);
        make.top.equalTo(5);
        make.width.equalTo(self.iconView.height);
    }];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.iconView.right).offset(9);
    }];
    [self.stateBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.nameLabel.right).offset(15/2);
        make.size.equalTo(CGSizeMake(35, 20));
    }];
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage originalImageNamed:@"The-girl-picture"];
    }
    return _iconView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"小明";
        _nameLabel.textColor = [UIColor colorWithHexString:@"#4d4d4d"];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}
- (UIButton *)stateBtn {
    if (!_stateBtn) {
        _stateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];

        [_stateBtn setTitle:@"等他" forState:(UIControlStateNormal)];
        [_stateBtn setTitleColor:HEXColor(@"#000000") forState:(UIControlStateNormal)];
        
        _stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _stateBtn.layer.borderColor = HEXColor(@"#999999").CGColor;
        _stateBtn.layer.borderWidth = 1;
        _stateBtn.layer.cornerRadius = 5;
        _stateBtn.layer.masksToBounds = YES;
        
        [_stateBtn addTarget:self action:@selector(clickStateBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _stateBtn;
}
- (void)clickStateBtnAction:(UIButton *)sender {
    if (_stateBlock) {
        _stateBlock();
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
