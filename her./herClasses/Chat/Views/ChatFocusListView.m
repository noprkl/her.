//
//  ChatFocusListView.m
//  her.
//
//  Created by 李祥起 on 2017/2/8.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "ChatFocusListView.h"

@interface ChatFocusListView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ChatFocusListView
- (void)setFocusArray:(NSArray *)focusArray {
    _focusArray = focusArray;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
//    return self.focusArray.count;
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
@end
