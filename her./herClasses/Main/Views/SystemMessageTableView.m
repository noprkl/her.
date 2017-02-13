//
//  SystemMessageTableView.m
//  her.
//
//  Created by 李祥起 on 2017/2/6.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "SystemMessageTableView.h"
#import "SMTableViewInterceptor.h"

@interface SystemMessageTableView ()

@property (nonatomic, strong) SMTableViewInterceptor * dataSourceInterceptor;
@property (nonatomic, assign) NSInteger actualRows;

@property (nonatomic, strong) NSTimer *timer; /**< 滚动定时器 */

@end

@implementation SystemMessageTableView

#pragma mark - 重新布局
- (void)layoutSubviews {
    [self resetContentOffsetIfNeeded];
    [super layoutSubviews];
}

- (void)resetContentOffsetIfNeeded {
    CGPoint contentOffset  = self.contentOffset;
    //scroll over top
    if (contentOffset.y < 0.0) {
        contentOffset.y = self.contentSize.height / 3.0;
    }
    //scroll over bottom
    else if (contentOffset.y >= (self.contentSize.height - self.bounds.size.height)) {
        contentOffset.y = self.contentSize.height / 3.0 - self.bounds.size.height;
    }
    [self setContentOffset: contentOffset];
}
- (void)setIsAutoScroll:(BOOL)isAutoScroll {
    // 自动滚动
    if (isAutoScroll) {
        // 获得显示的最后一个cell的
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScrollTableView) userInfo:nil repeats:YES];
        
    }else{
        [self.timer invalidate];
        self.timer = nil;
    }
    // 设置tableview是否可以滑动
    self.bounces = isAutoScroll;

}
- (void)autoScrollTableView {
    CGPoint contentOffset  = self.contentOffset;
    contentOffset.y += 55/2;
    // 滑动到下一个
    [self setContentOffset: contentOffset animated:YES];
}

#pragma mark
#pragma mark - 重写DataSource Delegate Setter/Getter Override
- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    self.dataSourceInterceptor.receiver = dataSource;
    [super setDataSource:(id<UITableViewDataSource>)self.dataSourceInterceptor];
}

- (SMTableViewInterceptor *)dataSourceInterceptor {
    if (!_dataSourceInterceptor) {
        _dataSourceInterceptor = [[SMTableViewInterceptor alloc]init];
        _dataSourceInterceptor.middleMan = self;
    }
    return _dataSourceInterceptor;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     self.actualRows = [self.dataSourceInterceptor.receiver tableView:tableView numberOfRowsInSection:section];
    return self.actualRows * 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath * actualIndexPath = [NSIndexPath indexPathForRow:indexPath.row % self.actualRows inSection:indexPath.section];
    return [self.dataSourceInterceptor.receiver tableView:tableView cellForRowAtIndexPath:actualIndexPath];    
}

@end
