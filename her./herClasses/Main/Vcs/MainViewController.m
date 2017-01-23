//
//  MainViewController.m
//  her.
//
//  Created by ma c on 17/1/18.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "MainViewController.h"
#import "HerTipsView.h"
#import "HerNameView.h"

@interface MainViewController ()

@property (nonatomic, strong) UIButton *herBtn; /**< 按钮 */

@property (nonatomic, strong) UIImage *backImgView; /**< 背景图片 */

@property (nonatomic, strong) HerNameView *nameView; /**< 名字 */

@property (nonatomic, strong) UIButton *heartBtn; /**< 心形按钮 */

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setAlpha:0];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}
- (void)initUI {
    [self.view addSubview:self.herBtn];
    [self.view addSubview:self.nameView];
    [self.view addSubview:self.heartBtn];
    
    [self.nameView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(110);
        make.size.equalTo(CGSizeMake(235, 100));
    }];
    [self.herBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.bottom.equalTo(self.view.bottom).offset(-10);
    }];
    [self.heartBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).offset(-10);
        make.bottom.equalTo(self.view.bottom).offset(-10);
    }];
}
#pragma mark
#pragma mark - 懒加载
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
- (UIImage *)backImgView {
    if (!_backImgView) {
//        _backImgView = [UIImage imageNamed:]
    }
    return _backImgView;
}
- (HerNameView *)nameView {
    if (!_nameView) {
        _nameView = [[HerNameView alloc] init];
        
        __weak typeof(self) weakSelf = self;
        _nameView.sureBlock = ^(NSString *name){
            if (name.length != 0) {
                DLog(@"%@", name);
            }else{
                [weakSelf showHint:@"名字不能为空哦!" dissAfter:1.5];
            }
        };
    }
    return _nameView;
}
- (UIButton *)heartBtn {
    if (!_heartBtn) {
        _heartBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_heartBtn setImage:[UIImage originalImageNamed:@"like-red"] forState:(UIControlStateNormal)];
        [_heartBtn addTarget:self action:@selector(clickHeartBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _heartBtn;
}
#pragma mark
#pragma mark - Action
- (void)clickHerBtnAction {
    self.herBtn.enabled = NO;
    HerTipsView *tipsView = [[HerTipsView alloc] init];
    [tipsView show];
    tipsView.disBlock = ^(){
        self.herBtn.enabled = YES;
    };
}
- (void)clickHeartBtnAction {
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showHint:@"名字不能随便输入哦" dissAfter:2];
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
