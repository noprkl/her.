//
//  MainViewController.m
//  her.
//
//  Created by ma c on 17/1/18.
//  Copyright © 2017年 LXq. All rights reserved.
//

#define SystemMessageCellHeight 55/2

#import "MainViewController.h"
#import "HerTipsView.h"
#import "HerNameView.h"
#import "FriendsView.h"
#import "LookHerAgainView.h"
#import "SystemMessageTableView.h"
#import "SystemMessageTableViewCell.h"
#import "FindingView.h" // 寻找是的变换文字

// 跳转
#import "TwoChatroomVc.h"
#import "ThreeChatroomVc.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger count;
}
@property (nonatomic, strong) UIButton *herBtn; /**< 按钮 */

@property (nonatomic, strong) UIImage *backImgView; /**< 背景图片 */

@property (nonatomic, strong) HerNameView *nameView; /**< 名字 */

@property (nonatomic, strong) LookHerAgainView *findAgainView; /**< 再次寻找 */

@property (nonatomic, strong) UIButton *heartBtn; /**< 心形按钮 */
@property (nonatomic, strong) HerTipsView *tipsView; /**< tips弹窗 */

@property (nonatomic, strong) FriendsView *friendView; /**< 好友view */

@property (nonatomic, strong) SystemMessageTableView *systemMessagetableView; /**< 系统提示tableview */

@property (nonatomic, strong) NSArray *systemMessageArray; /**< 系统消息数据 */
@property (nonatomic, assign) BOOL isAutoScroll; /**< 是否自动滚动 */


@property (nonatomic, strong) FindingView *findingView; /**< 寻找中提示文字 */
@property (nonatomic, strong) NSTimer *findingTimer; /**< 寻找中定时器 */
@property (nonatomic, assign) BOOL ischange; /**< 是否改变文字 */

@end
static NSString *systemMessageTableViewCellid = @"SystemMessageTableViewCell";
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
    
    // 进来时 判断哪一个view是显示的
    // 从零开始计时
    count = 0;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.nameView.hidden = YES;
    self.findAgainView.hidden = NO;
    self.heartBtn.hidden = NO;
    self.systemMessagetableView.hidden = NO;
    self.findingView.hidden = YES;
}
- (void)initUI {
    [self.view addSubview:self.herBtn];
    [self.view addSubview:self.nameView];
    [self.view addSubview:self.heartBtn];
    [self.view addSubview:self.friendView];
    [self.view addSubview:self.findAgainView];
    [self.view addSubview:self.systemMessagetableView];
    [self.view addSubview:self.findingView];
    
    [self.systemMessagetableView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(20);
        make.size.equalTo(CGSizeMake(250 + SystemMessageCellHeight, SystemMessageCellHeight * 3));
    }];
    CGSize viewSize = CGSizeMake(235, 100);
    CGFloat topHeight = 120;
    // 名字
    [self.nameView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(topHeight);
        make.size.equalTo(viewSize);
    }];
    // 再次寻找
    [self.findAgainView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(topHeight);
        make.size.equalTo(viewSize);
    }];
    // 寻找中
    [self.findingView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(topHeight);
        make.size.equalTo(viewSize);
    }];
    
    [self.herBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.bottom.equalTo(self.view.bottom).offset(-10);
    }];
    [self.heartBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).offset(-10);
        make.bottom.equalTo(self.view.bottom).offset(-10);
    }];
    
    [self.friendView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(120);
        make.height.equalTo(110);
        make.bottom.equalTo(self.heartBtn.top).offset(-15);
        make.right.equalTo(self.view.right).offset(-15);
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
- (LookHerAgainView *)findAgainView {
    if (!_findAgainView) {
        _findAgainView = [[LookHerAgainView alloc] init];
        _findAgainView.hidden = YES;
        XWeakSelf;
        _findAgainView.beginBlock = ^(){
            [weakSelf beginFindingAnimation];
        };
    }
    return _findAgainView;
}
- (UIButton *)heartBtn {
    if (!_heartBtn) {
        _heartBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_heartBtn setImage:[UIImage originalImageNamed:@"like-red"] forState:(UIControlStateNormal)];
        [_heartBtn addTarget:self action:@selector(clickHeartBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _heartBtn;
}
- (FriendsView *)friendView {
    if (!_friendView) {
        
        _friendView = [[FriendsView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _friendView.hidden = YES;
        _friendView.alpha = 0.01;
        _friendView.statusBlock = ^(NSString *title){
            DLog(@"%@", title);
            if ([title isEqualToString:@"赴约"]) {
                
            }
        };
    }
    return _friendView;
}
#pragma mark
#pragma mark - Action
- (void)clickHerBtnAction {
    self.herBtn.enabled = NO;
    HerTipsView *tipsView = [[HerTipsView alloc] init];
    [tipsView show];
    self.tipsView = tipsView;
    tipsView.disBlock = ^(){
        self.herBtn.enabled = YES;
    };
}
- (void)clickHeartBtnAction:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        if (self.friendView.hidden) {
            self.friendView.alpha = 1;
        }else{
            self.friendView.alpha = 0.01;
        }
    } completion:^(BOOL finished) {
        self.friendView.hidden = !self.friendView.hidden;
    }];
}

#pragma mark
#pragma mark - 提示消息
- (NSArray *)systemMessageArray {
    if (!_systemMessageArray) {
        _systemMessageArray = [NSArray array];
    }
    return _systemMessageArray;
}

- (SystemMessageTableView *)systemMessagetableView {
    if (!_systemMessagetableView) {
        _systemMessagetableView = [[SystemMessageTableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _systemMessagetableView.delegate = self;
        _systemMessagetableView.dataSource = self;
        _systemMessagetableView.showsVerticalScrollIndicator = NO;
        _systemMessagetableView.backgroundColor = BackGround_Color;
        _systemMessagetableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [_systemMessagetableView registerClass:[SystemMessageTableViewCell class] forCellReuseIdentifier:systemMessageTableViewCellid];
    }
    return _systemMessagetableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger iCount = 6;
//    NSInteger count = self.systemMessageArray.count;
    
    return iCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:systemMessageTableViewCellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundView = [[UIView alloc] init];
    cell.backgroundView.backgroundColor = BackGround_Color;
    cell.state = indexPath.row;

//    XWeakSelf;
    cell.appointBlock = ^(){
        DLog(@"赴约");
    };
    cell.deleteBlock = ^(){
        DLog(@"删除");
        DLog(@"刷新");
        
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SystemMessageCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"%ld", indexPath.row);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.nameView.hidden = !self.nameView.hidden;
    self.findAgainView.hidden = !self.nameView.hidden;
    static NSInteger iCount = 3;
    if (iCount == 3) {
        iCount += 3;
    }else{
        iCount -= 3;
    }
    if (iCount > 3) {
        self.systemMessagetableView.isAutoScroll = YES;
    }else{
        self.systemMessagetableView.isAutoScroll = NO;
    }
}

#pragma mark
#pragma mark - 开始匹配 动画
- (FindingView *)findingView {
    if (!_findingView) {
        _findingView = [[FindingView alloc] init];
        _findingView.hidden = YES;
    }
    return _findingView;
}
- (void)beginFindingAnimation {
    self.nameView.hidden = YES;
    self.findAgainView.hidden = YES;
    self.heartBtn.hidden = YES;
    self.systemMessagetableView.hidden = YES;
    
    self.findingView.hidden = NO;
    self.ischange = NO;
    
    self.findingTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeFindingMessage) userInfo:nil repeats:YES];
}
- (void)changeFindingMessage {
    self.ischange = !self.ischange;

    if (_ischange) { //改变
        self.findingView.chineseMessage = @"请正确对待男女关系!";
        self.findingView.englishMessage = @"Treat the new relationship right";
    }else{
        self.findingView.chineseMessage = @"正在为你寻找附近的她";
        self.findingView.englishMessage = @"Seeking her for you ...";
    }
    
    count ++;
    DLog(@"%ld", count);
    if (count == 3) {
        [self.findingTimer invalidate];
        self.findingTimer = nil;
        [self haveFindHer];
    }
}
- (void)haveFindHer { // 寻找到她了
    self.findingView.chineseMessage = @"找到她了，嗨起来!";
    self.findingView.englishMessage = @"Bingo，high up！";
    
    // 计时停止
    [self.findingTimer invalidate];
    self.findingTimer = nil;
    [self performSelector:@selector(pushToChatVc) withObject:nil afterDelay:1];
}
- (void)pushToChatVc {
    // 如果有弹窗，弹窗消失
    [self.tipsView dismiss];

    TwoChatroomVc *twoChat = [[TwoChatroomVc alloc] init];
    twoChat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:twoChat animated:YES];
    self.findingView.chineseMessage = @"请正确对待男女关系!";
    self.findingView.englishMessage = @"Treat the new relationship right";
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
