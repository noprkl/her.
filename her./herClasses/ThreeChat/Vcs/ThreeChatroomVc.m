//
//  ThreeChatroomVc.m
//  her.
//
//  Created by ma c on 17/1/18.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "ThreeChatroomVc.h"
#import "ChatFocusListView.h"
#import "SliderCutSongView.h"
#import "ChangeSoundAnimationView.h"
#import "WaverAnimationView.h"
#import "ChatPeopleView.h"
#import "SelectReportMessageVc.h"
#import "DuelAlertView.h"
#import "DuelAnimationView.h"
#import "FightFailedViewController.h"

@interface ThreeChatroomVc ()<EaseMessageViewControllerDelegate, EMContactManagerDelegate, EaseMessageViewControllerDataSource, EaseChatBarMoreViewDelegate, EaseMessageCellDelegate>

@property (nonatomic, strong) ChatFocusListView *focusListView; /**< 关注的人 */

@property (nonatomic, strong) ChangeSoundAnimationView *soundAnimatioVeiw; /**< 切歌动画视图 */

@property (nonatomic, strong) UIButton *backButton; /**< 退出聊天按钮 */
@property (nonatomic, strong) ShowHintView *hintView; /**< 提示框 */

@property (nonatomic, strong) ChatPeopleView *chatView; /**< 聊天头像 */

@property (nonatomic, strong) UIButton *duelBtn; /**< 决斗按钮 */
@property (nonatomic, assign) NSInteger currentIndex; /**< 当前位置 */
@property (nonatomic, strong) UIButton *kickBtn; /**< 踢人按钮 */

@property (nonatomic, strong) DuelAnimationView *duelAnimationView; /**< 决斗动画 */

@end

@implementation ThreeChatroomVc
//#pragma mark
//#pragma mark - 自定义cell
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    //用户可以根据自己的用户体系，根据message设置用户昵称和头像
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    
    model.avatarImage = [UIImage imageNamed:@"The-girl-picture"];//默认头像
    model.nickname = @"";
    if (model.isSender) {// 发送者（我）
        //        model.nickname = [UserInfo getUserInfo].nickName;//用户昵称
    }else{//对方
        model.avatarImage = [UIImage imageNamed:@"The-boy-picture"];//头像网络地址
    }
    return model;
}

// 长按头像
- (void)messageViewController:(EaseMessageViewController *)viewController
  didSelectAvatarMessageModel:(id<IMessageModel>)messageModel {
    // 获得所有的聊天对话内容
    NSLog(@"%@", messageModel);
    NSLog(@"%@", self.dataArray);
    SelectReportMessageVc *selectVc = [[SelectReportMessageVc alloc] init];
    selectVc.messageArr = self.dataArray;
    [self.navigationController pushViewController:selectVc animated:NO];
    //    [self.tableView setEditing:YES animated:YES];
}


#pragma mark
#pragma mark - 视图加载
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setToolView];
    [self initUI];
    [self setChatUI];
    
    // 进来先发消息
    [self sendTextMessage:@"你好！"];
}
- (void)setChatUI {
    // 数据代理
    self.dataSource = self;
    self.delegate = self;
    
    // 下拉刷新
    self.showRefreshHeader = YES;

    self.tableView.backgroundColor = BackGround_Color;
    [self.tableView reloadData];
    
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"sender"] stretchableImageWithLeftCapWidth:10 topCapHeight:20]];//设置发送气泡
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"accept"] stretchableImageWithLeftCapWidth:10 topCapHeight:20]];//设置接收气泡
    [[EaseBaseMessageCell appearance] setAvatarSize:44.f];//设置头像大小
    
    [[EaseBaseMessageCell appearance] setSendMessageVoiceAnimationImages:@[[UIImage imageNamed:@"EaseUIResource.bundle/chat_sender_audio_playing_full"], [UIImage imageNamed:@"EaseUIResource.bundle/chat_sender_audio_playing_000"], [UIImage imageNamed:@"EaseUIResource.bundle/chat_sender_audio_playing_001"], [UIImage imageNamed:@"EaseUIResource.bundle/chat_sender_audio_playing_002"], [UIImage imageNamed:@"EaseUIResource.bundle/chat_sender_audio_playing_003"]]];//发送者语音消息播放图片
    
    [[EaseBaseMessageCell appearance] setRecvMessageVoiceAnimationImages:@[[UIImage imageNamed:@"EaseUIResource.bundle/chat_receiver_audio_playing_full"],[UIImage imageNamed:@"EaseUIResource.bundle/chat_receiver_audio_playing000"], [UIImage imageNamed:@"EaseUIResource.bundle/chat_receiver_audio_playing001"], [UIImage imageNamed:@"EaseUIResource.bundle/chat_receiver_audio_playing002"], [UIImage imageNamed:@"EaseUIResource.bundle/chat_receiver_audio_playing003"]]];//接收者语音消息播放图片
    
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableGesture:)];
    [self.tableView addGestureRecognizer:tapgesture];
}
- (void)initUI {
    [self showHint:@"提示：因当前男女比例失调开启3P模式，如不爽可发起决斗" dissAfter:1];
    [self.view addSubview:self.focusListView];
    [self.focusListView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(5);
        make.right.equalTo(self.view.right).offset(-5);
        make.size.equalTo(KSIZE(130, 135));
    }];
    //    Wave *wave = [[Wave alloc] initWithFrame:CGRectMake(30, 64, SCREEN_WIDTH - 60, 100)];
    //    wave.speed = 5;
    //    wave.waveHeight = WAVE_HEIGHT;
    //    wave.backgroundColor = BackGround_Color;
    //    [self.view insertSubview:wave belowSubview:self.chatToolView];
    //    self.soundAnimatioVeiw = wave;
    //    [self.view addSubview:self.soundAnimatioVeiw];
    //
    //    [self.soundAnimatioVeiw makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.chatToolView.bottom).offset(0);
    //        make.left.equalTo(self.view.left).offset(30);
    //        make.centerX.equalTo(self.view.centerX);
    //        make.height.equalTo(WAVE_HEIGHT);
    //    }];
    
    SliderCutSongView *sliderView = [[SliderCutSongView alloc] init];
    sliderView.swipBlock = ^(){
        // 开始音乐播放动画
        [self.soundAnimatioVeiw stopAnimation];
    };
    [sliderView show];
    
    [self.view addSubview:self.backButton];
    [self.backButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(-1);
        make.left.equalTo(self.view.left).offset(10);
        make.size.equalTo(KSIZE(80, 40));
    }];
    
    [self.view addSubview:self.duelAnimationView];
    [self.duelAnimationView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.left.right.equalTo(self.view);
        make.height.equalTo(150);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
}

#pragma mark
#pragma mark - 返回
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backButton setTitle:@"退出房间" forState:(UIControlStateNormal)];
        [_backButton setBackgroundImage:[UIImage originalImageNamed:@"bubble"] forState:(UIControlStateNormal)];
        [_backButton setBackgroundColor:[UIColor clearColor]];
        [_backButton setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_backButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
        _backButton.hidden = YES;
        [_backButton addTarget:self action:@selector(popToVc) forControlEvents:(UIControlEventTouchDown)];
    }
    return _backButton;
}

#pragma mark
#pragma mark - 决斗
- (UIButton *)duelBtn {
    if (!_duelBtn) {
        _duelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_duelBtn setTitle:@"发起决斗" forState:(UIControlStateNormal)];
        [_duelBtn setBackgroundImage:[UIImage originalImageNamed:@"bubble"] forState:(UIControlStateNormal)];
        [_duelBtn setBackgroundColor:[UIColor clearColor]];
        [_duelBtn setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
        _duelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_duelBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
        _duelBtn.hidden = YES;
        [_duelBtn addTarget:self action:@selector(clickDuelBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _duelBtn;
}
- (DuelAnimationView *)duelAnimationView {
    if (!_duelAnimationView) {
        _duelAnimationView = [[DuelAnimationView alloc] init];
        _duelAnimationView.hidden = YES;
        XWeakSelf;
        _duelAnimationView.victoryBlock = ^(){
            // 胜利了 踢人
//            [weakSelf requestKick];
            // 失败了 走人
            FightFailedViewController *faildVc = [[FightFailedViewController alloc] init];
            [weakSelf.navigationController pushViewController:faildVc animated:YES];

        };
        _duelAnimationView.faildBlock = ^(){
            // 失败了 走人
            FightFailedViewController *faildVc = [[FightFailedViewController alloc] init];
            [weakSelf.navigationController pushViewController:faildVc animated:YES];
        };
    }
    return _duelAnimationView;
}
#pragma mark
#pragma mark - 决斗发起
- (void)clickDuelBtnAction:(UIButton *)sender {
    sender.hidden = YES;
    [self hidHitnView];
    
    NSString *title = [NSString stringWithFormat:@"你向Tom发出决斗战书"];
    [self showDuleHint:title isShowBtn:NO];
    
}

#pragma mark
#pragma mark - 收到决斗
- (void)acceptDuelRequest {
    [self hidHitnView];
    NSString *title = [NSString stringWithFormat:@"Jack向你发出决斗战书"];
    [self showDuleHint:title isShowBtn:YES];
}

#pragma mark
#pragma mark - 开始决斗
- (void)beginDuel {
    [self hidHitnView];
    self.tableView.backgroundColor = HEXColor(@"#000000");
    EaseChatToolbar *chatToolBar = (EaseChatToolbar *)self.chatToolbar;
    chatToolBar.backgroundImage = [UIImage originalImageNamed:@"决斗背景"];
    
    self.duelAnimationView.hidden = NO;
    [self.duelAnimationView startAnimation];
    
}


#pragma mark
#pragma mark - 踢人
- (UIButton *)kickBtn {
    if (!_kickBtn) {
        _kickBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_kickBtn setTitle:@"踢掉他" forState:(UIControlStateNormal)];
        [_kickBtn setBackgroundImage:[UIImage originalImageNamed:@"bubble"] forState:(UIControlStateNormal)];
        [_kickBtn setBackgroundColor:[UIColor clearColor]];
        [_kickBtn setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
        _kickBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_kickBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
        _kickBtn.hidden = YES;
        [_kickBtn addTarget:self action:@selector(requestKick) forControlEvents:(UIControlEventTouchDown)];
    }
    return _kickBtn;
}
#pragma mark
#pragma mark - 决斗输了 踢人
- (void)requestKick{
    [self setFocusBtn];
    [self hidHitnView];
    [self.kickBtn setHidden:YES];
    [self.duelAnimationView stopAnimation];
    self.duelAnimationView.hidden = YES;
    self.tableView.backgroundColor = BackGround_Color;
    EaseChatToolbar *chatToolBar = (EaseChatToolbar *)self.chatToolbar;
    chatToolBar.backgroundImage = [UIImage originalImageNamed:@"语音背景"];
}

/* 剩下的重新设置头部 */
- (void)setFocusBtn {
    [self.chatView createChatPeopleWithArray:@[@"jack"]];

    UIButton *custonBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    custonBtn.frame = CGRectMake(0, 0, 30, 30);
    [custonBtn setImage:[UIImage originalImageNamed:@"like"] forState:(UIControlStateNormal)];
    [custonBtn setImage:[UIImage originalImageNamed:@"like-red"] forState:(UIControlStateSelected)];
    [custonBtn addTarget:self action:@selector(clickFocusBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:custonBtn];
    
    // 消息点击回调
    [EaseBaseMessageCell appearance].delegate = self;
}

- (void)popToVc {
    [self.soundAnimatioVeiw stopAnimation];
    [self.hintView dismiss];
    // 返回是的按钮
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickBackBtnAction {
    self.backButton.hidden = !self.backButton.hidden;
    if (!self.backButton.isHidden) {
        [self performSelector:@selector(hidBackButton) withObject:nil afterDelay:3];
    }
}
- (void)clickFocusBtnAction:(UIButton *)btn {
    //    [UIView animateWithDuration:1 animations:^{
    //        self.focusListView.hidden = btn.selected;
    //    }];
    self.focusListView.delIndex = 4;
#warning -- @Focus
    // 进行数据请求 并判断如果个数为3的时候 显示为带删除的图片
    if (btn.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            self.focusListView.alpha = 0.01;
        } completion:^(BOOL finished) {
            self.focusListView.hidden = YES;
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.focusListView.alpha = 1;
        } completion:^(BOOL finished) {
            self.focusListView.hidden = NO;
        }];
    }
    btn.selected = !btn.selected;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.focusListView.isDel = !self.focusListView.isDel;
    self.focusListView.isShow = NO;
    
    [self.focusListView reloadData];
    [self.focusListView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(5);
        make.right.equalTo(self.view.right).offset(-5);
        make.size.equalTo(KSIZE(130, 135));
    }];
    [self hidBackButton];
}
- (void)tapTableGesture:(UITapGestureRecognizer *)tap {
    self.focusListView.isDel = !self.focusListView.isDel;
    self.focusListView.isShow = NO;
    self.duelBtn.hidden = YES;
    
    [self.focusListView reloadData];
    [self.focusListView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(5);
        make.right.equalTo(self.view.right).offset(-5);
        make.size.equalTo(KSIZE(130, 135));
    }];
    [self.view endEditing:YES];
    [self hidBackButton];

}
- (void)hidBackButton {
    self.backButton.hidden = YES;
    
}
#pragma mark
#pragma mark - 关注的人
- (ChatFocusListView *)focusListView {
    if (!_focusListView) {
        _focusListView = [[ChatFocusListView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _focusListView.isDel = YES;
        _focusListView.isShow = NO;
        _focusListView.hidden = YES;
        _focusListView.alpha = 0.01;
        XWeakSelf;
        _focusListView.deleteBlock = ^(NSInteger index){
            DLog(@"删除按钮");
            // 如果关注人数已经有3个 删除掉一个
            // 刷新表格 同时对应位置的心形变为灰色
            weakSelf.focusListView.isDel = NO;
            weakSelf.focusListView.delIndex = index;
            weakSelf.focusListView.isShow = YES;
            [weakSelf.focusListView reloadData];
            [weakSelf.focusListView remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.view.top).offset(5);
                make.right.equalTo(weakSelf.view.right).offset(-5);
                make.size.equalTo(KSIZE(130, 180));
            }];
        };
        _focusListView.addBlock = ^(){
            DLog(@"添加按钮");
            DLog(@"刷新");
        };
    }
    return _focusListView;
}

#pragma mark
#pragma mark - 音乐切换
- (ChangeSoundAnimationView *)soundAnimatioVeiw {
    if (!_soundAnimatioVeiw) {
        _soundAnimatioVeiw = [[ChangeSoundAnimationView alloc] init];
        _soundAnimatioVeiw.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction:)];
        swipe.numberOfTouchesRequired = 1;
        // 设置滑动方向为左、右滑
        swipe.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
        [_soundAnimatioVeiw addGestureRecognizer:swipe];
    }
    return _soundAnimatioVeiw;
}

- (void)swipeGestureAction:(UISwipeGestureRecognizer *)swip{
    // 切歌
}

#pragma mark
#pragma mark - 设置头部视图
- (void)setToolView {
    
    [self.navigationController.navigationBar setAlpha:0];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage originalImageNamed:@"navBG"] forBarMetrics:(UIBarMetricsDefault)];
    
    ChatPeopleView *chatView = [[ChatPeopleView alloc] initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH - 100, 44)];
    [chatView createChatPeopleWithArray:@[@"jack", @"make"]];
    [self.navigationItem setTitleView:chatView];
    self.chatView = chatView;
    
    [self.view addSubview:self.duelBtn];
    [self.view addSubview:self.kickBtn];

    _currentIndex = 0;
    if (_currentIndex == 0) {
        chatView.firstBlock = ^(){
            
            NSLog(@"第一个");
            [self.duelBtn remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.top).offset(-1);
                make.left.equalTo(self.view.left).offset(80);
                make.size.equalTo(KSIZE(80, 40));
            }];
            if (_currentIndex == 1) {
                self.duelBtn.hidden = !self.duelBtn.hidden;
            }
            _currentIndex = 1;
        };
        chatView.secondBlock = ^(){
            [self.duelBtn remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.top).offset(-1);
                make.right.equalTo(self.view.right).offset(-30);
                make.size.equalTo(KSIZE(80, 40));
            }];
            if (_currentIndex == 2) {
                NSLog(@"第二个");
                self.duelBtn.hidden = !self.duelBtn.hidden;
            }
            _currentIndex = 2;
        };

    }else{
        chatView.firstBlock = ^(){
            
            NSLog(@"第一个");
            [self.kickBtn remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.top).offset(-1);
                make.left.equalTo(self.view.left).offset(80);
                make.size.equalTo(KSIZE(80, 40));
            }];
            if (_currentIndex == 1) {
                self.kickBtn.hidden = !self.kickBtn.hidden;
            }
            _currentIndex = 1;
        };
        chatView.secondBlock = ^(){
            [self.kickBtn remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.top).offset(-1);
                make.right.equalTo(self.view.right).offset(-30);
                make.size.equalTo(KSIZE(80, 40));
            }];
            if (_currentIndex == 2) {
                NSLog(@"第二个");
                self.kickBtn.hidden = !self.kickBtn.hidden;
            }
            _currentIndex = 2;
        };
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage originalImageNamed:@"return"] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickBackBtnAction)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showHint:(NSString *)message dissAfter:(CGFloat)delay {
    ShowHintView *hintView = [[ShowHintView alloc] init];
    hintView.alertStr = message;
    hintView.offsetY = 220;
    hintView.fontSize = 14;
    hintView.backGroundColor = HEXColor(@"#cccccc");
    hintView.fontColor = HEXColor(@"#ffffff");
    [hintView show];
    self.hintView = hintView;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidHitnView)];
    [hintView addGestureRecognizer:tapGesture];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [hintView dismiss];
//    });
}
- (void)hidHitnView {
    [self.hintView dismiss];
}
- (void)showDuleHint:(NSString *)title isShowBtn:(BOOL)isShowBtn {
    DuelAlertView *alertView = [[DuelAlertView alloc] initWithFrame:(CGRectZero) isShowAccept:isShowBtn];
    alertView.title = title;
    alertView.duelBlock = ^(){
        NSLog(@"接受决斗");
        [self beginDuel];
    };
    [alertView show];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [alertView dismiss];
//    });
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
