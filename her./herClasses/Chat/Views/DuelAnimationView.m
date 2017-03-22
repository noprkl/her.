//
//  DuelAnimationView.m
//  her.
//
//  Created by 李祥起 on 2017/3/22.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "DuelAnimationView.h"
#import "DuelAudioManager.h"

@interface DuelAnimationView ()

@property (nonatomic, strong) UIImageView *backImgView; /**< 背景 */


@property (nonatomic, strong) UIImageView *bulletImgView; /**< 子弹图片 */

@property (nonatomic, strong) UIImageView *gankImgView; /**< 枪 */

@property (nonatomic, strong) UIImageView *passImgView; /**< 通过图片 */

@property (nonatomic, strong) UIImageView *victoryImgView; /**< 胜利 */

@property (nonatomic, strong) UIImageView *iconView; /**< 头像 */

@property (nonatomic, strong) UILabel *timeLabel; /**< 5s倒计时 */

@property (nonatomic, strong) NSTimer *timer; /**< 倒计时 */

@end

static NSInteger iCount = 5;

@implementation DuelAnimationView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImgView];
        [self addSubview:self.bulletImgView];
        [self addSubview:self.gankImgView];
        [self addSubview:self.passImgView];
        [self addSubview:self.victoryImgView];
        [self addSubview:self.iconView];
        [self addSubview:self.timeLabel];
    }
    return self;
}

#pragma mark
#pragma mark - lazyLoad 
- (UIImageView *)backImgView {
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] init];
        _backImgView.image = [UIImage imageNamed:@"colouredribbon"];
        _backImgView.hidden = YES;
    }
    return _backImgView;
}
- (UIImageView *)bulletImgView {
    if (!_bulletImgView) {
        _bulletImgView = [[UIImageView alloc] init];
        _bulletImgView.image = [UIImage imageNamed:@"bore"];
    }
    return _bulletImgView;
}
- (UIImageView *)gankImgView {
    if (!_gankImgView) {
        _gankImgView = [[UIImageView alloc] init];
        _gankImgView.image = [UIImage imageNamed:@"handarm"];
        _gankImgView.hidden = YES;
    }
    return _gankImgView;
}
- (UIImageView *)passImgView {
    if (!_passImgView) {
        _passImgView = [[UIImageView alloc] init];
        _passImgView.image = [UIImage imageNamed:@"Customsclearancewords"];
        _passImgView.hidden = YES;
    }
    return _passImgView;
}
- (UIImageView *)victoryImgView {
    if (!_victoryImgView) {
        _victoryImgView = [[UIImageView alloc] init];
        _victoryImgView.image = [UIImage imageNamed:@"beerglass"];
        _victoryImgView.hidden = YES;
    }
    return _victoryImgView;
}
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"The-boy-picture"];
        _iconView.hidden = YES;
    }
    return _iconView;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"5S";
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = HEXColor(@"#ffffff");
    }
    return _timeLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bulletImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.top).offset(15);
        make.size.equalTo(KSIZE(143, 143));
    }];
    
    [self.gankImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.top).offset(40);
        make.size.equalTo(KSIZE(238, 98));
    }];
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(20);
        make.right.equalTo(self.right).offset(-5);
        make.width.equalTo(30);
    }];
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.timeLabel.left).offset(-5);
        make.size.equalTo(KSIZE(35, 35));
    }];
    [self.passImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.top).offset(30);
    }];
    [self.victoryImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.passImgView.bottom).offset(25);
        make.size.equalTo(KSIZE(71, 71));
    }];
}
#pragma mark
#pragma mark - 动画

/** 装子弹 */
- (void)startAnimation {
    // 装子弹 放音效
//    [[DuelAudioManager sharedManager] playSystemSound:@"vv"];
    
    [self showBulletImgView];
    NSLog(@"动画开始");
}
- (void)showBulletImgView {
    NSLog(@"装子弹");
    self.backImgView.hidden = YES;
    self.bulletImgView.hidden = NO;
    self.gankImgView.hidden = YES;
    self.iconView.hidden = YES;
    self.timeLabel.hidden = YES;
    [self.timer invalidate];
    self.passImgView.hidden = YES;
    self.victoryImgView.hidden = YES;
    
    [self performSelector:@selector(showgans) withObject:nil afterDelay:5];
}
- (void)showgans {
    NSLog(@"展示枪");
    self.backImgView.hidden = YES;
    self.bulletImgView.hidden = YES;
    self.gankImgView.hidden = NO;
    self.iconView.hidden = NO;
    self.timeLabel.hidden = NO;
    [self timerBegin];
    self.passImgView.hidden = YES;
    self.victoryImgView.hidden = YES;
    
}
- (void)fire {
    NSLog(@"开火");
    [self timerStop];
    [self performSelector:@selector(pass) withObject:nil afterDelay:5];
}
- (void)pass {
    NSLog(@"本轮没人死");
    self.backImgView.hidden = YES;
    self.bulletImgView.hidden = YES;
    self.gankImgView.hidden = YES;
    self.iconView.hidden = NO;
    self.timeLabel.hidden = YES;
    self.passImgView.hidden = NO;
    self.victoryImgView.hidden = NO;
    
    [self performSelector:@selector(victory) withObject:nil afterDelay:2];

}
- (void)victory {
    NSLog(@"胜利了");
    [self timerStop];
    self.backImgView.hidden = NO;
    self.bulletImgView.hidden = YES;
    self.gankImgView.hidden = YES;
    self.iconView.hidden = NO;
    self.timeLabel.hidden = YES;
    self.passImgView.hidden = NO;
    self.victoryImgView.hidden = YES;
    if (_victoryBlock) {
        _victoryBlock();
    }
}
- (void)faild {
    NSLog(@"胜利了");
    [self timerStop];
    self.backImgView.hidden = NO;
    self.bulletImgView.hidden = YES;
    self.gankImgView.hidden = YES;
    self.iconView.hidden = NO;
    self.timeLabel.hidden = YES;
    self.passImgView.hidden = NO;
    self.victoryImgView.hidden = YES;
    if (_faildBlock) {
        _faildBlock();
    }
}
- (void)timerBegin {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeOutLast) userInfo:nil repeats:YES];
}
- (void)timerStop {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)timeOutLast {
    iCount -- ;
    self.timeLabel.text = [NSString stringWithFormat:@"%ldS", iCount];
    if (iCount == 0) {
        [self fire];
        iCount = 5;
    }
}

- (void)stopAnimation {
    [self timerStop];
}

@end
