//
//  DuelAlertView.m
//  her.
//
//  Created by 李祥起 on 2017/3/21.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "DuelAlertView.h"

@interface DuelAlertView ()

@property (nonatomic, strong) UIControl *overLayer; /**< 背景 */

@property (nonatomic, strong) UILabel *alertLabel; /**< 提示文字 */

@property (nonatomic, strong) UILabel *timeLabel; /**< 倒计时按钮 */

@property (nonatomic, strong) UIButton *acceptBtn; /**< 应战 */

@property (nonatomic, assign) BOOL isShowAcceptBtn; /**< 是否展示接受按钮 */

@property (nonatomic, strong) NSTimer *timer; /**< 倒计时 */

@end

static NSInteger iCount = 10;

@implementation DuelAlertView
- (instancetype)initWithFrame:(CGRect)frame isShowAccept:(BOOL)isShowAcceptBtn
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =  Alert_Color;
        [self addSubview:self.alertLabel];
        [self addSubview:self.timeLabel];
        
        if (isShowAcceptBtn) {
            [self addSubview:self.acceptBtn];
        }
        self.isShowAcceptBtn = isShowAcceptBtn;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}
- (void)setUP {
    if (self.isShowAcceptBtn) {
        [self.acceptBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY);
            make.right.equalTo(self.right).offset(-10);
            make.size.equalTo(KSIZE(37, 22));
        }];
        [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY);
            make.right.equalTo(self.acceptBtn.left);
            make.size.equalTo(KSIZE(35, 25));
        }];
    }else{
        [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY);
            make.right.equalTo(self.right);
            make.size.equalTo(KSIZE(45, 30));
        }];
    }
    
    
    [self.alertLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left).offset(5);
        make.right.equalTo(self.timeLabel.right);
        make.bottom.equalTo(self.bottom);
    }];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.alertLabel.text = title;
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _alertLabel.font = [UIFont systemFontOfSize:16];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
//        _alertLabel.backgroundColor = Alert_Color;
    }
    return _alertLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"10S";
        _timeLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _timeLabel.font = [UIFont systemFontOfSize:16];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}
- (UIButton *)acceptBtn {
    if (!_acceptBtn) {
        _acceptBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_acceptBtn setTitle:@"应战" forState:(UIControlStateNormal)];
        [_acceptBtn setTitleColor:Alert_Color forState:(UIControlStateNormal)];
        _acceptBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _acceptBtn.backgroundColor = HEXColor(@"#ffffff");
        _acceptBtn.layer.cornerRadius = 5;
        _acceptBtn.layer.masksToBounds = YES;
        [_acceptBtn addTarget:self action:@selector(clickAcceptBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _acceptBtn;
}
- (void)clickAcceptBtnAction {
    [self dismiss];
    // 数值为10
    iCount = 10;
    // 定时器暂停
    [self.timer invalidate];
    self.timer = nil;
    
    if (_duelBlock) {
        _duelBlock();
    }
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
    if (self.isShowAcceptBtn) {
        width = 290;
    }
    
    CGFloat height = 34;
    CGFloat x = (SCREEN_WIDTH - width) / 2;
    CGFloat y = (SCREEN_HEIGHT - height) / 2;
  
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
    
    // 开始倒计时
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lastTime) userInfo:nil repeats:YES];
    
}
- (void)lastTime {
    iCount --;
    self.timeLabel.text = [NSString stringWithFormat:@"%ldS", iCount];
    if (iCount == 0) {
        [self clickAcceptBtnAction];
    }
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
