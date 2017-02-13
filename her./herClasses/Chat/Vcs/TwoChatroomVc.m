//
//  TwoChatroomVc.m
//  her.
//
//  Created by ma c on 17/1/18.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "TwoChatroomVc.h"
#import "TwoChatToolView.h"

@interface TwoChatroomVc ()<TwoChatToolViewDelegate>

@property (nonatomic, strong) TwoChatToolView *chatToolView; /**< 顶部tool */

@end

@implementation TwoChatroomVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}
- (void)initUI {
    [self.view addSubview:self.chatToolView];
    [self.chatToolView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(0);
        make.left.equalTo(self.view.left);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 64));
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark
#pragma mark - 头部tool
- (TwoChatToolView *)chatToolView {
    if (!_chatToolView) {
        _chatToolView = [[TwoChatToolView alloc] initWithFrame:CGRectZero];
        _chatToolView.backgroundColor = [UIColor whiteColor];
        _chatToolView.toolDelegate = self;
    }
    return _chatToolView;
}
#pragma mark - TwoChatToolViewDelegate代理
- (void)clickBackBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickFocusBtnAction {
    
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
