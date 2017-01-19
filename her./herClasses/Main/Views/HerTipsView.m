//
//  HerTipsView.m
//  her.
//
//  Created by ma c on 17/1/19.
//  Copyright © 2017年 LXq. All rights reserved.
//
// 左右间距
#define kcolMargin 0
#define krowMargin 10

#import "HerTipsView.h"

@interface HerTipsView ()
@property (nonatomic, strong) UIControl *overLayer; /**< 背景 */

@property (nonatomic, strong) UIButton *disBtn; /**< 消失按钮 */

@property (nonatomic, strong) UIImageView *conanIconView; /**< conan图片 */

@property (nonatomic, strong) UILabel *titleLable; /**< 标题 */

@property (nonatomic, strong) UILabel *appDescLabel; /**< 应用介绍 */

@property (nonatomic, strong) UILabel *companyDescLabel; /**< 公司介绍 */

@property (nonatomic, strong) UILabel *conanDescLabel; /**< conan介绍 */

@end

@implementation HerTipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor colorWithHexString:@"#333333"] colorWithAlphaComponent:0.9];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        [self addSubview:self.disBtn];
        [self addSubview:self.conanIconView];
        [self addSubview:self.titleLable];
        [self addSubview:self.appDescLabel];
        [self addSubview:self.companyDescLabel];
        [self addSubview:self.conanDescLabel];
    }
    return self;
}

- (void)setUP {
   [self.disBtn makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.top).offset(10);
       make.right.equalTo(self.right).offset(-10);
       make.size.equalTo(CGSizeMake(20, 20));
   }];
    [self.conanIconView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(85, 120));
        make.left.equalTo(self.left).offset(10);
        make.centerY.equalTo(self.centerY);
    }];
    [self.titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conanIconView.top);
        make.left.equalTo(self.conanIconView.right).offset(kcolMargin);
        make.right.equalTo(self.right).offset(-kcolMargin);
    }];
    [self.appDescLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable.bottom).offset(krowMargin);
        make.left.equalTo(self.conanIconView.right).offset(kcolMargin);
        make.right.equalTo(self.right).offset(-kcolMargin);
    }];
    [self.companyDescLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appDescLabel.bottom).offset(krowMargin);
        make.left.equalTo(self.conanIconView.right).offset(kcolMargin);
        make.right.equalTo(self.right).offset(-kcolMargin);
    }];
    [self.conanDescLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.conanIconView.bottom).offset(0);
        make.left.equalTo(self.conanIconView.right).offset(kcolMargin);
        make.right.equalTo(self.right).offset(-kcolMargin);
    }];
}

#pragma mark
#pragma mark - 懒加载
- (UIButton *)disBtn {
    if (!_disBtn) {
        _disBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_disBtn setImage:[UIImage originalImageNamed:@"quit"] forState:(UIControlStateNormal)];
        [_disBtn setContentMode:(UIViewContentModeCenter)];
        [_disBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchDown)];
    }
    return _disBtn;
}
- (UIImageView *)conanIconView {
    if (!_conanIconView) {
        _conanIconView = [[UIImageView alloc] initWithImage:[UIImage originalImageNamed:@"Conan-photo"]];
        _conanIconView.layer.cornerRadius = 5;
        _conanIconView.layer.masksToBounds = YES;
    }
    return _conanIconView;
}
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"her.";
        _titleLable.font = [UIFont systemFontOfSize:16];
        _titleLable.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}
- (UILabel *)appDescLabel {
    if (!_appDescLabel) {
        _appDescLabel = [[UILabel alloc] init];
        _appDescLabel.text = @"一款陪伴你的伪人工智能软件。";
        _appDescLabel.font = [UIFont systemFontOfSize:14];
        _appDescLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _appDescLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _appDescLabel;
}
- (UILabel *)companyDescLabel {
    if (!_companyDescLabel) {
        _companyDescLabel = [[UILabel alloc] init];
        _companyDescLabel.text = @"柯南与科技出品";
        _companyDescLabel.font = [UIFont systemFontOfSize:14];
        _companyDescLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _companyDescLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _companyDescLabel;
}
- (UILabel *)conanDescLabel {
    if (!_conanDescLabel) {
        _conanDescLabel = [[UILabel alloc] init];
        _conanDescLabel.text = @"我是柯南,一个魔法师侦探。我有过爱情。";
        _conanDescLabel.font = [UIFont systemFontOfSize:16];
        _conanDescLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _conanDescLabel.textAlignment = NSTextAlignmentCenter;
        _conanDescLabel.numberOfLines = 2;
    }
    return _conanDescLabel;
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
    
    CGFloat width = 300;
    CGFloat height = 200;
    CGFloat x = (SCREEN_WIDTH - width) / 2;
    CGFloat y = SCREEN_HEIGHT - 125 - height;
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
    if (_disBlock) {
        _disBlock();
    }
}
- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut {
    [UIView animateWithDuration:0.5 animations:^{
        self.overLayer.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
    }];
}

@end
