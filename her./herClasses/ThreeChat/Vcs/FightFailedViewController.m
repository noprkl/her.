//
//  FightFailedViewController.m
//  her.
//
//  Created by 李祥起 on 2017/2/6.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "FightFailedViewController.h"
#import "HerTipsView.h"

@interface FightFailedViewController ()

@property (nonatomic, strong) UIImageView *backImgView; /**< 名字背景 */

@property (nonatomic, strong) UIView *line1; /**< 坐标竖线1 */

@property (nonatomic, strong) UILabel *shareLabel; /**< 继续寻找 */

@property (nonatomic, strong) UIButton *shareBtn; /**< 分享 */

@property (nonatomic, strong) UIView *line2; /**< 坐标竖线2 */

@property (nonatomic, strong) UILabel *titleLabel; /**< 标题 */


@property (nonatomic, strong) UIImageView *backView; /**< 背景 */

@property (nonatomic, strong) UIButton *herBtn; /**< 按钮 */
@property (nonatomic, strong) HerTipsView *tipsView; /**< tips弹窗 */


@end

@implementation FightFailedViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.navigationController.navigationBar setAlpha:0];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.herBtn];
    [self.herBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.bottom.equalTo(self.view.bottom).offset(-10);
    }];
    [self.view addSubview:self.backImgView];
    [self.backImgView addSubview:self.line1];
    [self.backImgView addSubview:self.line2];
    [self.view addSubview:self.shareLabel];
    [self.view addSubview:self.shareBtn];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.backView];

    CGSize viewSize = CGSizeMake(250, 100);
    CGFloat topHeight = 120;
    // 名字
    [self.backImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(topHeight);
        make.size.equalTo(viewSize);
    }];
    [self.line1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImgView.top).offset(5);
        make.left.equalTo(self.backImgView.left).offset(5);
        make.size.equalTo(CGSizeMake(1, 75/2));
    }];
    [self.line2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.bottom);
        make.left.equalTo(self.line1.left);
        make.size.equalTo(CGSizeMake(1, 70/2));
    }];
    [self.shareLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.left.equalTo(self.line1.left).offset(10);
    }];
    [self.shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.right.equalTo(self.backImgView.right).offset(-10);
        make.size.equalTo(CGSizeMake(35, 35));
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line2.centerY);
        make.left.equalTo(self.line2.right).offset(10);
    }];

    [self.backView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.backImgView.bottom).offset(10);
        make.bottom.equalTo(self.view.bottom).offset(-30);
        make.left.equalTo(self.view.left).offset(50);
    }];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tipsView dismiss];
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc] init];
        _backView.image = [UIImage imageNamed:@"backGroundImage"];
    }
    return _backView;
}
- (UIButton *)herBtn {
    if (!_herBtn) {
        _herBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_herBtn setTitle:@"her." forState:(UIControlStateNormal)];
        _herBtn.titleLabel.font = [UIFont boldSystemFontOfSize:21];
        [_herBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:(UIControlStateNormal)];
        [_herBtn addTarget:self action:@selector(clickHerBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _herBtn;
}
- (void)clickHerBtnAction {
    self.herBtn.enabled = NO;
    HerTipsView *tipsView = [[HerTipsView alloc] init];
    [tipsView show];
    self.tipsView = tipsView;
    tipsView.disBlock = ^(){
        self.herBtn.enabled = YES;
    };
}
- (UIImageView *)backImgView {
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] initWithImage:[UIImage originalImageNamed:@"dialog-box-right"]];
    }
    return _backImgView;
}
- (UILabel *)shareLabel {
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc] init];
        _shareLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _shareLabel.font = [UIFont systemFontOfSize:19];
        _shareLabel.text = @"点击分享到朋友圈续命";
    }
    return _shareLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"Once more?";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}
- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_shareBtn setImage:[UIImage originalImageNamed:@"Share button"] forState:(UIControlStateNormal)];
        [_shareBtn addTarget:self action:@selector(shared) forControlEvents:(UIControlEventTouchDown)];
    }
    return _shareBtn;
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
- (void)shared {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
