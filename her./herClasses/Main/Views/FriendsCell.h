//
//  FriendsCell.h
//  her.
//
//  Created by 李祥起 on 2017/2/4.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickStateButtonBlock)();

@interface FriendsCell : UITableViewCell

@property (nonatomic, strong) ClickStateButtonBlock stateBlock; /**< 点击状态按钮 */
@property (nonatomic, assign) NSInteger state; /**< 状态 */
@end
