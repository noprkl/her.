//
//  TwoChatroomVc.m
//  her.
//
//  Created by ma c on 17/1/18.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "TwoChatroomVc.h"
#import "TwoChatToolView.h"
#import "ChatFocusListView.h"
#import "SliderCutSongView.h"
#import "ChangeSoundAnimationView.h"

@interface TwoChatroomVc ()<TwoChatToolViewDelegate>

@property (nonatomic, strong) TwoChatToolView *chatToolView; /**< 顶部tool */

@property (nonatomic, strong) ChatFocusListView *focusListView; /**< 关注的人 */

@property (nonatomic, strong) ChangeSoundAnimationView *soundAnimatioVeiw; /**< 切歌动画视图 */

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
    [self.view addSubview:self.focusListView];
    [self.focusListView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chatToolView.bottom).offset(5);
        make.right.equalTo(self.view.right).offset(-5);
        make.size.equalTo(KSIZE(130, 135));
    }];
    [self.view addSubview:self.soundAnimatioVeiw];
    [self.soundAnimatioVeiw makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chatToolView.bottom).offset(0);
        make.left.equalTo(self.view.left).offset(30);
        make.centerX.equalTo(self.view.centerX);
        make.height.equalTo(60);
    }];
    
    SliderCutSongView *sliderView = [[SliderCutSongView alloc] init];
    sliderView.swipBlock = ^(){
        // 开始音乐播放动画
        [self.soundAnimatioVeiw startAnimation];
    };
    [sliderView show];
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
        make.top.equalTo(self.chatToolView.bottom).offset(5);
        make.right.equalTo(self.view.right).offset(-5);
        make.size.equalTo(KSIZE(130, 135));
    }];

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
                make.top.equalTo(weakSelf.chatToolView.bottom).offset(5);
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
