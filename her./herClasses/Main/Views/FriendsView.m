//
//  FriendsView.m
//  her.
//
//  Created by 李祥起 on 2017/1/19.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "FriendsView.h"
#import "FriendsCell.h"

@interface FriendsView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< tableView */

@end

static NSString *cellid = @"FriendsCell";
@implementation FriendsView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.bounces = NO;
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
        [self registerClass:[FriendsCell class] forCellReuseIdentifier:cellid];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
//    return self.friendArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, -10)];
    cell.stateBlock = ^{
        if (_statusBlock) {
            NSString *title;
            if (indexPath.row % 2) {
                title = @"赴约";
            }else{
                title = @"等他";
            }
            _statusBlock(title);
        }
    };
    cell.state = indexPath.row;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 37;
}
@end
