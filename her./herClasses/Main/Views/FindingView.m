//
//  FindingView.m
//  her.
//
//  Created by 李祥起 on 2017/2/6.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "FindingView.h"

@interface FindingView ()

@property (nonatomic, strong) UIImageView *backImgView; /**< 名字背景 */

@property (nonatomic, strong) UIView *line1; /**< 坐标竖线1 */

@property (nonatomic, strong) UILabel *chineseLabel; /**< 继续寻找 */

@property (nonatomic, strong) UIView *line2; /**< 坐标竖线2 */

@property (nonatomic, strong) UILabel *englishLabel; /**< 标题 */

@end
@implementation FindingView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImgView];
        [self.backImgView addSubview:self.line1];
        [self.backImgView addSubview:self.line2];
        [self addSubview:self.chineseLabel];
        [self addSubview:self.englishLabel];
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
    [self.chineseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.left.equalTo(self.line1.left).offset(10);
        make.right.equalTo(self.right).offset(-5);
    }];
   
    [self.englishLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line2.centerY);
        make.left.equalTo(self.line2.right).offset(10);
        make.right.equalTo(self.right).offset(-5);
    }];
    
}
- (void)setChineseMessage:(NSString *)chineseMessage {
    _chineseMessage = chineseMessage;
    self.chineseLabel.text = chineseMessage;
}
- (void)setEnglishMessage:(NSString *)englishMessage {
    _englishMessage = englishMessage;
    self.englishLabel.text = englishMessage;
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)backImgView {
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] initWithImage:[UIImage originalImageNamed:@"dialog-box-right"]];
    }
    return _backImgView;
}
- (UILabel *)chineseLabel {
    if (!_chineseLabel) {
        _chineseLabel = [[UILabel alloc] init];
        _chineseLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _chineseLabel.font = [UIFont systemFontOfSize:19];
        _chineseLabel.text = @"正在为你寻找附近的她";
        _chineseLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _chineseLabel;
}

- (UILabel *)englishLabel {
    if (!_englishLabel) {
        _englishLabel = [[UILabel alloc] init];
        _englishLabel.text = @"Seeking her for you ...";
        _englishLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _englishLabel.font = [UIFont systemFontOfSize:14];
        _englishLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _englishLabel;
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

@end

