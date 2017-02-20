//
//  ChatFocusListView.m
//  her.
//
//  Created by 李祥起 on 2017/2/8.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "ChatFocusListView.h"
#import "AddFocusCell.h"
#import "DeleFocusCell.h"

@interface ChatFocusListView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) BOOL isAdd; /**< 是否添加 */
@end
static NSString *addCellId = @"AddFocusCell";
static NSString *delCellId = @"DeleFocusCell";

@implementation ChatFocusListView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self ) {
        self.bounces = NO;
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [self registerClass:[AddFocusCell class] forCellReuseIdentifier:addCellId];
        [self registerClass:[DeleFocusCell class] forCellReuseIdentifier:delCellId];
    }
    return self;
}
- (void)setFocusArray:(NSArray *)focusArray {
    _focusArray = focusArray;
}
- (void)setIsDel:(BOOL)isDel {
    _isDel = isDel;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
//    return self.focusArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isDel) { // 显示删除按钮
        DeleFocusCell *cell = [tableView dequeueReusableCellWithIdentifier:delCellId];
        cell.delBlock = ^(){
            if (_deleteBlock) {
                _deleteBlock(indexPath.row);
            }
        };
        cell.str = [@(indexPath.row) stringValue];
        return cell;
    }else{
        AddFocusCell *cell = [tableView dequeueReusableCellWithIdentifier:addCellId];
//        cell.addBlock = ^(){
//            _isAdd = !_isAdd;
//            if (_addBlock) {
//                _addBlock();
//            }
//        };
        cell.str = [@(indexPath.row) stringValue];
        if (_delIndex == indexPath.row) {
            cell.isDel = YES;
        }else{
            cell.isDel = NO;
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_isShow) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        view.backgroundColor = HEXColor(@"#ffffff");
        UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat x = (130 - 51) / 2;
        CGFloat y = (45 - 24) / 2;
        addBtn.frame = CGRectMake(x, y, 51, 24);
        
        addBtn.layer.cornerRadius = 5;
        addBtn.layer.masksToBounds = YES;
        addBtn.backgroundColor = HEXColor(@"#fe8326");
        [addBtn setTitle:@"上位" forState:(UIControlStateNormal)];
        [addBtn setTitleColor:HEXColor(@"#ffffff") forState:(UIControlStateNormal)];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [addBtn addTarget:self action:@selector(clickBottomAddAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        [view addSubview:addBtn];
        return view;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_isShow) {
        return 45;
    }else{
        return 0;
    }
}
- (void)clickBottomAddAction {
    if (_addBlock) {
        _addBlock();
    }
}
@end
