//
//  FriendsView.h
//  her.
//
//  Created by 李祥起 on 2017/1/19.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "BaseView.h"

typedef void(^ClickStatusButtonBlock)(NSString *title);
@interface FriendsView : UITableView

@property (nonatomic, strong) NSArray *friendArray; /**< 关注的人数据 */

@property (nonatomic, strong) ClickStatusButtonBlock statusBlock; /**< 状态按钮回调 */

@end
