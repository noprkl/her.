//
//  SelectReportMessageVc.m
//  her.
//
//  Created by 李祥起 on 2017/3/17.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "SelectReportMessageVc.h"
#import "SelectReportAcceptCell.h"
#import "SelectReportSenderCell.h"
#import "EaseMessageModel.h"
#import "ReportViewController.h"

@interface SelectReportMessageVc ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView; /**< tableView */

@property (nonatomic, strong) NSArray *dataArray; /**< 数据 */


@property (nonatomic, strong) SelectReportAcceptCell *acceptCellTool; /**< 接受高度计算 */

@property (nonatomic, strong) SelectReportSenderCell *senderCellTool; /**< 发送高度计算 */

@property (nonatomic, strong) UIButton *reportBtn; /**< 举报按钮 */

@property (nonatomic, strong) NSMutableArray *reportArray; /**< 举报数据 */

@end

static NSString *acceptCellid = @"SelectReportAcceptCell";
static NSString *senderCellid = @"SelectReportSenderCell";
static NSString *timeCellid = @"timeCellid";
@implementation SelectReportMessageVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage originalImageNamed:@"back_del"] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickBackBtnAction)];
    self.title = @"举报广告";
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom).offset(-60);
    }];
    [self.view addSubview:self.reportBtn];
    [self.reportBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.bottom);
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.bottom.equalTo(self.view.bottom).offset(-10);
    }];
    
    self.acceptCellTool = [self.tableView dequeueReusableCellWithIdentifier:acceptCellid];
    self.senderCellTool = [self.tableView dequeueReusableCellWithIdentifier:senderCellid];
}
- (void)clickBackBtnAction {
    [self.navigationController popViewControllerAnimated:NO];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BackGround_Color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        [_tableView registerNib:[UINib nibWithNibName:senderCellid bundle:nil] forCellReuseIdentifier:senderCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:acceptCellid bundle:nil] forCellReuseIdentifier:acceptCellid];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:timeCellid];
    }
    return _tableView;
}
- (void)setMessageArr:(NSArray *)messageArr {
    _messageArr = messageArr;
    self.dataArray = messageArr;
    [self.tableView reloadData];
}
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)reportArray {
    if (!_reportArray) {
        _reportArray = [NSMutableArray array];
    }
    return _reportArray;
}
- (UIButton *)reportBtn {
    if (!_reportBtn) {
        _reportBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_reportBtn setTitle:@"举报广告" forState:(UIControlStateNormal)];
        _reportBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_reportBtn setBackgroundColor:HEXColor(@"#bfbfbf")];
        [_reportBtn setTitleColor:HEXColor(@"#ffffff") forState:(UIControlStateNormal)];
        [_reportBtn setEnabled:NO];
        
        _reportBtn.layer.masksToBounds = YES;
        _reportBtn.layer.cornerRadius = 10;
        
        
        [_reportBtn addTarget:self action:@selector(clickReportBtnAction) forControlEvents:(UIControlEventTouchDown)];
        
    }
    return _reportBtn;
}
- (void)clickReportBtnAction {
    
#pragma mark
#pragma mark - 举报
    NSLog(@"%@", self.reportArray);
    ReportViewController *reportVc = [[ReportViewController alloc] init];
    reportVc.reportMessageArr = self.reportArray;
    [self.navigationController pushViewController:reportVc animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id object = self.dataArray[indexPath.row];
    if ([object isKindOfClass:[NSString class]]) { // 时间
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:timeCellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = (NSString *)object;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = HEXColor(@"#666666");
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = BackGround_Color;
        return cell;
    }else{
        EaseMessageModel *model = (EaseMessageModel*)object;
        BOOL isSelect = [self.reportArray containsObject:model];
            
        
        if (!model.isSender) {
            SelectReportSenderCell *senderCell = [tableView dequeueReusableCellWithIdentifier:senderCellid];
            senderCell.senderModel = model;
            senderCell.isSelected = isSelect;
            
            senderCell.senderBolck = ^(EaseMessageModel *senderModel){
                if ([self.reportArray containsObject:senderModel]) {
                    [self.reportArray removeObject:senderModel];
                }else{
                    [self.reportArray addObject:senderModel];
                }

                if (self.reportArray.count > 0) {
                    [self.reportBtn setEnabled:YES];
                    [self.reportBtn setBackgroundColor:HEXColor(@"#fd523e")];
                }else{
                    [self.reportBtn setEnabled:NO];
                    [self.reportBtn setBackgroundColor:HEXColor(@"#bfbfbf")];
                }
                
            };
            return senderCell;
        }else{
            SelectReportAcceptCell *acceptCell = [tableView dequeueReusableCellWithIdentifier:acceptCellid];
            acceptCell.isSelected = isSelect;
            acceptCell.acceptBolck = ^(EaseMessageModel *acceptModel){
                if ([self.reportArray containsObject:acceptModel]) {
                    [self.reportArray removeObject:acceptModel];
                }else{
                    [self.reportArray addObject:acceptModel];
                }

                if (self.reportArray.count > 0) {
                    [self.reportBtn setEnabled:YES];
                    [self.reportBtn setBackgroundColor:HEXColor(@"#fd523e")];
                }else{
                    [self.reportBtn setEnabled:NO];
                    [self.reportBtn setBackgroundColor:HEXColor(@"#bfbfbf")];
                }
                
            };
            acceptCell.acceptModel = model;
            return acceptCell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.dataArray[indexPath.row];
    if ([object isKindOfClass:[NSString class]]) { // 时间
        return 44;
    }else{
        EaseMessageModel *model = (EaseMessageModel*)object;
        if (!model.isSender) {
            self.senderCellTool.senderModel = model;
            return [self.senderCellTool cellHeghit];
        }else{
            self.acceptCellTool.acceptModel = model;
            return [self.acceptCellTool cellHeghit];
        }
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
