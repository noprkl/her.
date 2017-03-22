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
#import "UnableUserView.h" // 不能用哟
// 跳转
#import "TwoChatroomVc.h"
#import "ThreeChatroomVc.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件



@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, BMKRadarManagerDelegate, BMKLocationServiceDelegate>
{
    NSInteger count;
}
@property (nonatomic, strong) UIButton *herBtn; /**< 按钮 */

@property (nonatomic, strong) UIImageView *backGroundImgView; /**< 背景 */

@property (nonatomic, strong) UIImageView *backImgView; /**< 背景图片 */
@property (nonatomic, strong) UIImageView *findImgView; /**< 找到了图片 */

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

@property (nonatomic, strong) BMKRadarManager *radarManager; /**< 雷达 */

@property (nonatomic, strong) BMKLocationService *locService; /**< 定位 */

@property (nonatomic, assign) CGFloat longitude;  // 经度

@property (nonatomic, assign) CGFloat latitude; // 纬度


@property (nonatomic, strong) UnableUserView *unableView; /**< 不能用提示 */

@end

static NSString *systemMessageTableViewCellid = @"SystemMessageTableViewCell";

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 判断能不能用这个应用
//    [self initUI];
    [self unableUI];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.navigationController.navigationBar setAlpha:0];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    // 进来时 判断哪一个view是显示的
    NSString *userName = [KDefault objectForKey:UserName];
    if (userName) {
        self.nameView.hidden = YES;
        self.findAgainView.hidden = NO;
    }else{
        self.nameView.hidden = NO;
        self.findAgainView.hidden = YES;
    }
    
    // 从零开始计时
    count = 0;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.backGroundImgView.hidden = NO;
    self.findAgainView.hidden = NO;
    self.heartBtn.hidden = NO;
    self.systemMessagetableView.hidden = NO;
    self.findingView.hidden = YES;
}
- (void)unableUI {
    [self.view addSubview:self.unableView];
    [self.view addSubview:self.backGroundImgView];
    [self.view addSubview:self.herBtn];

    // 名字
    CGSize viewSize = CGSizeMake(235, 100);
    CGFloat topHeight = 70;
    [self.unableView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(topHeight);
        make.size.equalTo(viewSize);
    }];
    [self.backGroundImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.unableView.bottom).offset(25);
        make.bottom.equalTo(self.view.bottom).offset(-30);
        make.left.equalTo(self.view.left).offset(50);
    }];
    [self.herBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.bottom.equalTo(self.view.bottom).offset(-10);
    }];
}
- (void)initUI {
    [self.view addSubview:self.herBtn];
    [self.view addSubview:self.nameView];
    [self.view addSubview:self.backGroundImgView];
    [self.view addSubview:self.heartBtn];
    [self.view addSubview:self.friendView];
    [self.view addSubview:self.findAgainView];
    [self.view addSubview:self.systemMessagetableView];
    [self.view addSubview:self.findingView];
    
    // 找到了的动画
    [self.view addSubview:self.backImgView];
    [self.view addSubview:self.findImgView];
    
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
    [self.backGroundImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.nameView.bottom).offset(10);
        make.bottom.equalTo(self.view.bottom).offset(-30);
        make.left.equalTo(self.view.left).offset(50);
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
    [self.backImgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.findImgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(40, 40, 40, 40));
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
- (UIImageView *)backGroundImgView {
    if (!_backGroundImgView) {
        _backGroundImgView = [[UIImageView alloc] init];
        _backGroundImgView.image = [UIImage imageNamed:@"backGroundImage"];
    }
    return _backGroundImgView;
}
- (UIImageView *)backImgView {
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] init];
        _backImgView.image = [UIImage imageNamed:@"flash1"];
        _backImgView.hidden = YES;
    }
    return _backImgView;
}
- (UIImageView *)findImgView {
    if (!_findImgView) {
        _findImgView = [[UIImageView alloc] init];
        _findImgView.image = [UIImage imageNamed:@"child_find"];
        _findImgView.hidden = YES;
    }
    return _findImgView;
}
- (HerNameView *)nameView {
    if (!_nameView) {
        _nameView = [[HerNameView alloc] init];
        
        XWeakSelf;
        _nameView.sureBlock = ^(NSString *name){
            if (name.length != 0) {
                DLog(@"%@", name);
                
#pragma mark
#pragma mark - 设置名字
                [KDefault setObject:name forKey:UserName];
                // 同时注册环信账号
                // 环信重名怎么办？ 约定一个方式 或者后台注册，返回字段，这边登录
//                [[EMClient sharedClient] registerWithUsername:name password:@"111"];
                // 如果名字设置成功，隐藏
                
                weakSelf.nameView.hidden = YES;
                weakSelf.findAgainView.hidden = NO;
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
- (UnableUserView *)unableView {
    if (!_unableView) {
        _unableView = [[UnableUserView alloc] init];
    }
    return _unableView;
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
    DLog(@"%ld", (long)indexPath.row);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.nameView.hidden = !self.nameView.hidden;
//    self.findAgainView.hidden = !self.nameView.hidden;
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
    
#pragma mark
#pragma mark - 开始定位
    // 初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
    
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
    if (count == 1) {
        [self.findingTimer invalidate];
        self.findingTimer = nil;
        [self haveFindHer];
    }
}
- (void)haveFindHer { // 寻找到她了
    self.findingView.chineseMessage = @"找到她了，嗨起来!";
    self.findingView.englishMessage = @"Bingo，high up！";
    self.backImgView.hidden = NO;
    self.findImgView.hidden = NO;
    self.findingView.hidden = YES;
    NSLog(@"0");
    UIImage *image1 = [UIImage imageNamed:@"flash2"];
    UIImage *image2 = [UIImage imageNamed:@"flash1"];
    NSArray *arr = [NSArray arrayWithObjects:image1, image2, image1, image2, nil];
    self.backImgView.animationImages = arr;
    self.backImgView.animationDuration = 1.5;
    self.backImgView.animationRepeatCount = 0;
    [self.backImgView startAnimating];

    // 计时停止
    [self.findingTimer invalidate];
    self.findingTimer = nil;
    [_radarManager removeRadarManagerDelegate:self];//不用需移除，否则影响内存释放
    [self performSelector:@selector(pushToChatVc) withObject:nil afterDelay:1.5];
}
- (void)pushToChatVc {
    // 如果有弹窗，弹窗消失
    [self.tipsView dismiss];
    
    [self.backImgView stopAnimating];
    self.backImgView.hidden = YES;
    self.findImgView.hidden = YES;
    self.findingView.hidden = NO;
    
//    TwoChatroomVc *twoChat = [[TwoChatroomVc alloc] initWithConversationChatter:@"222" conversationType:(EMConversationTypeChat)];
//    twoChat.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:twoChat animated:YES];
    
    ThreeChatroomVc *twoChat = [[ThreeChatroomVc alloc] initWithConversationChatter:@"222" conversationType:(EMConversationTypeChatRoom)];
    twoChat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:twoChat animated:YES];
    
    self.findingView.chineseMessage = @"请正确对待男女关系!";
    self.findingView.englishMessage = @"Treat the new relationship right";
}

#pragma mark
#pragma mark - 定位-上传雷达
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"当前位置信息：didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    
    CGFloat longitude = userLocation.location.coordinate.longitude;
    CGFloat latitude = userLocation.location.coordinate.latitude;
#pragma mark
#pragma mark - 百度雷达 上传自己位置
    BMKRadarManager *radarManager = [BMKRadarManager getRadarManagerInstance];
    self.radarManager = radarManager;
    // 在不需要时，通过下边的方法使引用计数减1
    [BMKRadarManager releaseRadarManagerInstance];
    // 在上传和拉取位置信息前，需要设置userid，否则会自动生成
    radarManager.userId = @"her";
    // 通过添加radar delegate获取自动上传时的位置信息，以及获得雷达操作结果
    [radarManager addRadarManagerDelegate:self];//添加radar delegate
    
    //构造我的位置信息
    BMKRadarUploadInfo *myinfo = [[BMKRadarUploadInfo alloc] init];
    myinfo.extInfo = @"hello,world";//扩展信息
    myinfo.pt = CLLocationCoordinate2DMake(latitude, longitude);//我的地理坐标
    //上传我的位置信息
    BOOL res = [_radarManager uploadInfoRequest:myinfo];
    if (res) {
        NSLog(@"upload 成功");
    } else {
        NSLog(@"upload 失败");
    }
    [_radarManager startAutoUpload:5];
    
#pragma mark
#pragma mark - 百度雷达-检索位置
    
    BMKRadarNearbySearchOption *option = [[BMKRadarNearbySearchOption alloc] init]
    ;
    option.radius = 8000;//检索半径
    option.sortType = BMK_RADAR_SORT_TYPE_DISTANCE_FROM_NEAR_TO_FAR;//排序方式
    option.centerPt = CLLocationCoordinate2DMake(latitude, longitude);//检索中心点
    //发起检索
    BOOL searchRes = [_radarManager getRadarNearbySearchRequest:option];
    if (searchRes) {
        NSLog(@"get 成功");// 搜索成功
    } else {
        NSLog(@"get 失败");
    }
}
// 搜索结果
- (void)onGetRadarNearbySearchResult:(BMKRadarNearbyResult *)result error:(BMKRadarErrorCode)error {
    NSLog(@"onGetRadarNearbySearchResult  %d", error);
    if (error == BMK_RADAR_NO_ERROR) {// 搜到结果
        //得到用户的信息
        BMKRadarNearbyInfo* userInfo = [result.infoList firstObject];
//        userInfo.userId = [];
#pragma mark
#pragma mark - 找到了
        
        [self haveFindHer];
    }
}
// 方向变更处理
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
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
