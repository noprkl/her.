//
//  ReportViewController.m
//  her.
//
//  Created by 李祥起 on 2017/2/6.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "ReportViewController.h"
#import "SelectReportSenderCell.h"
#import "TwoChatroomVc.h"

@interface ReportViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView; /**< 聊天证据tableview */

@property (nonatomic, strong) SelectReportSenderCell *senderCellTool; /**< 发送高度计算 */

@property (nonatomic, strong) UILabel *reportResaon; /**< 举报理由 */

@property (nonatomic, strong) UITextView *reportEditView; /**< 举报输入框 */

@property (nonatomic, strong) UIButton *reportBtn; /**< 举报按钮 */

@end

static NSString *senderCellid = @"SelectReportSenderCell";
static NSString *cellid = @"Cellid";

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage originalImageNamed:@"back_del"] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickBackBtnAction)];
    self.title = @"举报广告";
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom);
    }];

    [self setUI];
}
- (void)clickBackBtnAction {
    // 返回
    int index = (int)[[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
}
- (void)setUI {
    self.senderCellTool = [self.tableView dequeueReusableCellWithIdentifier:senderCellid];
    //1.监听键盘弹出，把inputToolbar(输入工具条)往上移
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //2.监听键盘退出，inputToolbar恢复原位
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark 键盘显示时会触发的方法
-(void)kbWillShow:(NSNotification *)noti{
    
    //1.获取键盘高度
    //1.1获取键盘结束时候的位置
    CGRect kbEndFrm = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbHeight = kbEndFrm.size.height;
    if (self.reportMessageArr.count > 8){
        [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.bottom).offset(-kbHeight);
        }];
    }
    CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height + kbHeight);
    [self.tableView setContentOffset:offset animated:YES];

}
#pragma mark 键盘退出时会触发的方法
-(void)kbWillHide:(NSNotification *)noti{
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom);
    }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
}
#pragma mark
#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BackGround_Color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerNib:[UINib nibWithNibName:senderCellid bundle:nil] forCellReuseIdentifier:senderCellid];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditTextView)];
        [_tableView addGestureRecognizer:tapGesture];
    }
    return _tableView;
}
- (void)endEditTextView {
    [self.reportEditView resignFirstResponder];
    [self.reportEditView endEditing:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.reportMessageArr.count;
    }else if (section == 1) {
        return 1;
    }
    return 0.00001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SelectReportSenderCell *senderCell = [tableView dequeueReusableCellWithIdentifier:senderCellid];
        EaseMessageModel *model =  self.reportMessageArr[indexPath.row];
        senderCell.senderModel = model;
        senderCell.ishidSelectbtn = YES;
        return senderCell;
    }else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = BackGround_Color;
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 100)];
        textView.delegate = self;
        
        textView.layer.borderColor = HEXColor(@"#cccccc").CGColor;
        textView.layer.borderWidth = 1.0f;
        textView.layer.cornerRadius = 5;
        textView.layer.masksToBounds = YES;
        textView.backgroundColor = BackGround_Color;
        self.reportEditView = textView;
        
        [cell.contentView addSubview:textView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH - 30, 15)];
        label.text = @"请输入举报这个用户的理由";
        label.textColor = HEXColor(@"#999999");
        label.font = [UIFont systemFontOfSize:15];
        [textView addSubview:label];
        self.reportResaon = label;
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        EaseMessageModel *model =  self.reportMessageArr[indexPath.row];
        self.senderCellTool.senderModel = model;
        return [self.senderCellTool cellHeghit];
    }else if (indexPath.section == 1) {
        return 120;
    }
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 60;
    }else{
        return 10;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        view.backgroundColor = BackGround_Color;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, SCREEN_WIDTH - 20, 1)];
        label.backgroundColor = HEXColor(@"#cccccc");
        [view addSubview:label];
        return view;
    }else if (section == 1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        view.backgroundColor = BackGround_Color;
        UIButton *reportBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        reportBtn.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 40);
        [reportBtn setTitle:@"举报广告" forState:(UIControlStateNormal)];
        reportBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [reportBtn setBackgroundColor:HEXColor(@"#bfbfbf")];
        [reportBtn setTitleColor:HEXColor(@"#ffffff") forState:(UIControlStateNormal)];
        [reportBtn setEnabled:NO];
        
        reportBtn.layer.masksToBounds = YES;
        reportBtn.layer.cornerRadius = 10;
        self.reportBtn = reportBtn;
        
        [reportBtn addTarget:self action:@selector(clickReportBtnAction) forControlEvents:(UIControlEventTouchDown)];
        [view addSubview:reportBtn];
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }else {
        return 85/2;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.backgroundColor = BackGround_Color;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 300, 20)];
        label.text = @"聊天证据";
        label.textColor = HEXColor(@"#1a1a1a");
        label.font = [UIFont systemFontOfSize:17];
        [view addSubview:label];
        return view;
    }else if (section == 1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.backgroundColor = BackGround_Color;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 300, 20)];
        label.text = @"举报理由";
        label.textColor = HEXColor(@"#1a1a1a");
        label.font = [UIFont systemFontOfSize:17];
        [view addSubview:label];
        return view;
    }
    
    return nil;
}

#pragma mark
#pragma mark - Action
- (void)clickReportBtnAction {
    
#pragma mark
#pragma mark - 举报
}

#pragma mark
#pragma mark - textView代理
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length != 0 && ![textView.text isEqual:@"\n"] && ![textView.text isEqual:@" "]) {
        self.reportResaon.hidden = YES;
        [self.reportBtn setEnabled:YES];
        [self.reportBtn setBackgroundColor:HEXColor(@"#fd523e")];
    }else{
        self.reportResaon.hidden = NO;
        [self.reportBtn setEnabled:NO];
        [self.reportBtn setBackgroundColor:HEXColor(@"#bfbfbf")];
    }
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
