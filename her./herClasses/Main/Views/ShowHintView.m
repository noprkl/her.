//
//  ShowHintView.m
//  her.
//
//  Created by ma c on 17/1/18.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "ShowHintView.h"

@interface ShowHintView ()

@property (nonatomic, strong) UIControl *overLayer; /**< 背景 */

@property (nonatomic, strong) UILabel *alertLabel; /**< 提示文字 */
@end

@implementation ShowHintView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.alertLabel];
    }
    return self;
}

- (void)setUP {
    [self.alertLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom);
    }];
}
- (void)setAlertStr:(NSString *)alertStr {
    _alertStr = alertStr;
    self.alertLabel.text = alertStr;
}
//- (void)setOffsetY:(CGFloat)offsetY {
//    _offsetY = offsetY;
//    CGFloat width = 250;
//    CGFloat height = 50;
//    CGFloat x = (SCREEN_WIDTH - width) / 2;
//    CGFloat y = offsetY;
//    CGRect rect = self.frame;
//    rect = CGRectMake(x, y, width, height);
//    self.frame = rect;
//}

- (void)setFontColor:(UIColor *)fontColor {
    _fontColor = fontColor;
    self.alertLabel.textColor = fontColor;
}
- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    self.alertLabel.font = [UIFont systemFontOfSize:fontSize];
}
- (void)setBackGroundColor:(UIColor *)backGroundColor {
    _backGroundColor = backGroundColor;
    self.alertLabel.backgroundColor = backGroundColor;
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _alertLabel.font = [UIFont systemFontOfSize:19];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.backgroundColor = Alert_Color;
        _alertLabel.numberOfLines = 0;
        _alertLabel.layer.cornerRadius = 5;
        _alertLabel.layer.masksToBounds = YES;
    }
    return _alertLabel;
}
#pragma mark
#pragma mark - 蒙版弹出效果
- (UIControl *)overLayer {
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overLayer.backgroundColor = [UIColor clearColor];
    }
    return _overLayer;
}
- (void)show {
    CGFloat width = 250;
    if (_width) {
        width = _width;
    }
    
    CGFloat height = 50;
    CGFloat x = (SCREEN_WIDTH - width) / 2;
    CGFloat y = (SCREEN_HEIGHT - height) / 2;
    if (_offsetY) {
        y = _offsetY;
    }
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.overLayer.frame = CGRectMake(x, y, width, height);

    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];
    
#pragma mark
#pragma mark - 设置当前view的frame
    
    CGRect rect = self.frame;
    rect = CGRectMake(x, y, width, height);

    self.frame = rect;

    // 约束
    [self setUP];
    
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss {
    //返回时调用
    [self fadeOut];
}
- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut {
    [UIView animateWithDuration:0.25 animations:^{
        self.overLayer.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
    }];
}

@end
